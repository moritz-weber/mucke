import 'package:logging/logging.dart';


void initLogging({Level level = Level.INFO}) {
  Logger.root.level = level;
  Logger.root.onRecord.listen((LogRecord rec) {
    final err = rec.error != null ? ' Error: ${rec.error}' : '';
    final stack = rec.stackTrace != null ? '\n${rec.stackTrace}' : '';
    final name = rec.loggerName.isNotEmpty ? '${rec.loggerName}: ' : '';
    // Basic console output; adapt to write to files or remote sinks as needed.
    print('${rec.time} [${rec.level.name}] $name${rec.message}$err$stack');
  });
}
