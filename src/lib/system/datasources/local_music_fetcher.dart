import 'package:rxdart/rxdart.dart';

import 'library_scan_result.dart';

abstract class LocalMusicFetcher {
  ValueStream<int?> get fileNumStream;
  ValueStream<int?> get progressStream;
  Future<LibraryScanResult> getLocalMusic();
}
