// Async filesystem operations are intentional: logging must not block the UI
// isolate while writing or rotating log files.
// ignore_for_file: avoid_slow_async_io

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart' as logging;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const _maxHistoryItems = 1000;
const _maxRotatedFiles = 6;
const _maxLogFileSize = 1024 * 1024;

StreamSubscription<logging.LogRecord>? _logSubscription;
Future<void> _writeQueue = Future<void>.value();
final List<logging.LogRecord> _history = <logging.LogRecord>[];

/// The recent in-memory log records, newest last.
List<logging.LogRecord> get logHistory => List.unmodifiable(_history);

/// Returns the logging level configured for an application package.
logging.Level loggingLevelForPackage(String packageName) {
  switch (packageName) {
    case 'rocks.mucke.dev':
      return logging.Level.ALL;
    case 'rocks.mucke.github':
      return logging.Level.FINE;
    default:
      return logging.Level.INFO;
  }
}

/// Initialises logging with console output and file logging.
///
/// Logs are written to `{appDocDir}/logs/mucke.log` and rotated by size.
/// The current file and up to six rotated files are retained.
///
/// The listener is installed only once, so calling this more than once is
/// harmless.
Future<void> initLogging({
  logging.Level level = logging.Level.ALL,
  int maxHistoryItems = _maxHistoryItems,
}) async {
  if (_logSubscription != null) {
    return;
  }

  logging.Logger.root.level = level;

  final appDir = await getApplicationDocumentsDirectory();
  final logDir = Directory(p.join(appDir.path, 'logs'));
  if (!await logDir.exists()) {
    await logDir.create(recursive: true);
  }

  final logFile = File(p.join(logDir.path, 'mucke.log'));

  _logSubscription = logging.Logger.root.onRecord.listen((record) {
    _history.add(record);
    if (_history.length > maxHistoryItems) {
      _history.removeRange(0, _history.length - maxHistoryItems);
    }

    final line = '${_formatLogRecord(record)}\n';
    if (record.level >= logging.Level.SEVERE) {
      stderr.write(line);
    } else {
      stdout.write(line);
    }

    // Keep file operations serialized without blocking the UI isolate.
    _writeQueue = _writeQueue.then((_) async {
      try {
        await _appendAndRotate(logFile, line);
      } catch (error, stackTrace) {
        // Logging failures must not terminate the application.
        stderr.writeln('Could not write log file: $error');
        stderr.writeln(stackTrace);
      }
    });
  });
}

String _formatLogRecord(logging.LogRecord rec) {
  final err = rec.error != null ? ' Error: ${rec.error}' : '';
  final stack = rec.stackTrace != null ? '\n${rec.stackTrace}' : '';
  final name = rec.loggerName.isNotEmpty ? '${rec.loggerName}: ' : '';
  return '${rec.time.toIso8601String()} ${rec.level.name}: $name${rec.message}$err$stack';
}

Future<void> _appendAndRotate(File logFile, String line) async {
  if (await logFile.exists() && await logFile.length() + line.length > _maxLogFileSize) {
    await _rotate(logFile);
  }

  await logFile.writeAsString(line, mode: FileMode.append);
}

Future<void> _rotate(File logFile) async {
  for (var i = _maxRotatedFiles; i >= 1; i--) {
    final oldFile = File('${logFile.path}.$i');
    if (!await oldFile.exists()) {
      continue;
    }

    if (i == _maxRotatedFiles) {
      await oldFile.delete();
    } else {
      await oldFile.rename('${logFile.path}.${i + 1}');
    }
  }

  if (await logFile.exists()) {
    await logFile.rename('${logFile.path}.1');
  }
}
