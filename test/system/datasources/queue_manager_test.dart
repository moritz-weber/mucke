import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mucke/system/datasources/music_data_source_contract.dart';
import 'package:mucke/system/audio/queue_generator.dart';
import 'package:mucke/system/models/album_model.dart';
import 'package:mucke/system/models/song_model.dart';

import '../../test_constants.dart';

class MockMusicDataSource extends Mock implements MusicDataSource {}

void main() {
  QueueGenerator queueManager;
  MusicDataSource musicDataSource;
  List<MediaItem> mediaItems;

  group('generatePlusPermutation', () {

    setUp(() {
      musicDataSource = MockMusicDataSource();
      queueManager = QueueGenerator(musicDataSource);
    });

    test(
      'should exclude blocked songs',
      () async {
        // arrange
    
        // act
    
        // assert
    
      },
    );
  });
}
