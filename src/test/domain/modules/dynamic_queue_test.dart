import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mucke/domain/entities/playable.dart';
import 'package:mucke/domain/entities/queue_item.dart';
import 'package:mucke/domain/modules/dynamic_queue.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';

import '../../test_songs.dart';
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

    test(
      'should set queue',
      () async {
        // arrange
        final tQueue = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 1, isAvailable: true),
          QueueItem(song3, originalIndex: 2, isAvailable: true)
        ];
        final tAvailableSongs = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 1, isAvailable: true),
          QueueItem(song3, originalIndex: 2, isAvailable: true)
        ];

        final tPlayable = MockPlayable();

        // act
        sut.init(tQueue, tAvailableSongs, tPlayable);

        // assert
        expect(sut.queueItemsStream.value, tQueue);
        expect(sut.queue, [song1, song2, song3]);
      },
    );

    test(
      'should set available songs',
      () async {
        // arrange
        final tQueue = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 1, isAvailable: true),
          QueueItem(song3, originalIndex: 2, isAvailable: false)
        ];
        final tAvailableSongs = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 1, isAvailable: true),
          QueueItem(song3, originalIndex: 2, isAvailable: false)
        ];

        final tPlayable = MockPlayable();

        // act
        sut.init(tQueue, tAvailableSongs, tPlayable);

        // assert
        expect(sut.availableSongsStream.value, tAvailableSongs);
        expect(sut.availableSongs, [song1, song2]);
      },
    );

    test(
      'QueueItems missing in availableSongs get filtered out',
      () async {
        // arrange
        final tQueue = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 4, isAvailable: true),
        ];
        final tAvailableSongs = <QueueItem>[
          QueueItem(song1, originalIndex: 0, isAvailable: true),
          QueueItem(song2, originalIndex: 1, isAvailable: true),
          QueueItem(song3, originalIndex: 2, isAvailable: false)
        ];

        final tPlayable = MockPlayable();

        // act
        sut.init(tQueue, tAvailableSongs, tPlayable);

        // assert
        expect(sut.queueItemsStream.value, [QueueItem(song1, originalIndex: 0, isAvailable: true)]);
        expect(sut.queue, [song1]);
      },
    );
  });

  // group('moveQueueItem', () {
  //   test('basic', () {
  //     // arrange
  //     final tQueue = <QueueItem>[
  //       QueueItem(song1, originalIndex: 0, isAvailable: true),
  //       QueueItem(song2, originalIndex: 4, isAvailable: true),
  //     ];
  //     final tAvailableSongs = <QueueItem>[
  //       QueueItem(song1, originalIndex: 0, isAvailable: true),
  //       QueueItem(song2, originalIndex: 1, isAvailable: true),
  //       QueueItem(song3, originalIndex: 2, isAvailable: false)
  //     ];

  //     final tPlayable = MockPlayable();

  //     // act
  //     sut.init(tQueue, tAvailableSongs, tPlayable);

  //     // assert
  //     expect(sut.queueItemsStream.value, [QueueItem(song1, originalIndex: 0, isAvailable: true)]);
  //     expect(sut.queue, [song1]);
  //   });
  // });
}
