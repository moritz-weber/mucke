import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:mucke/domain/entities/playable.dart';
import 'package:mucke/domain/entities/queue_item.dart';
import 'package:mucke/domain/entities/shuffle_mode.dart';
import 'package:mucke/domain/modules/dynamic_queue.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';


@GenerateNiceMocks([MockSpec<MusicDataRepository>(), MockSpec<Playable>()])
import 'dynamic_queue_test.mocks.dart';

void main() {
  late DynamicQueue sut;
  late MockMusicDataRepository mockMusicDataRepository;

  setUp(() {
    mockMusicDataRepository = MockMusicDataRepository();
    sut = DynamicQueue(mockMusicDataRepository);
  });

  group('init', () {
    test(
      'should set playable',
      () async {
        // arrange
        final tQueue = <QueueItem>[];
        final tAvailableSongs = <QueueItem>[];
        final tPlayable = MockPlayable();

        // act
        sut.init(tQueue, tAvailableSongs, tPlayable);
        
        // assert
        expect(sut.playableStream.value, tPlayable);
      },
    );
  });
}