import 'package:rxdart/rxdart.dart';

abstract class LocalMusicFetcher {
  ValueStream<int?> get fileNumStream;
  ValueStream<int?> get progressStream;
  Future<Map<String, List>> getLocalMusic();
}
