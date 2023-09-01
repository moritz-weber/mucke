import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mucke/domain/entities/playable.dart';
import 'package:mucke/domain/entities/queue_item.dart';
import 'package:mucke/domain/modules/dynamic_queue.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';
import 'package:mucke/system/models/queue_item_model.dart';

import '../../data/beartooth_aggressive.dart';
import '../../data/in_flames_clayman.dart';
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

  group('addToQueue', () {
    late List<QueueItem> tQueue;
    late List<QueueItem> tAvailableSongs;

    setUp(() {
      tQueue = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );
      tAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );
      const tPlayable = clayman;
      sut.init(tQueue, tAvailableSongs, tPlayable);
    });

    test('add one song', () {
      // arrange
      final tNewSongs = [aggressive1];

      // act
      sut.addToQueue(tNewSongs);

      // assert
      expect(sut.queue.last, tNewSongs[0]);
      // tAvailableSongs is actually modified by this
      // because DynamicQueue uses the exact list
      expect(
        sut.availableSongsStream.value.last,
        QueueItemModel(
          tNewSongs[0],
          originalIndex: tAvailableSongs.length - 1,
          isAvailable: false,
          source: QueueItemSource.added,
        ),
      );
    });

    test('add two songs', () {
      // arrange
      final tNewSongs = [aggressive1, aggressive2];

      // act
      sut.addToQueue(tNewSongs);

      // assert
      expect(sut.queue.length, tQueue.length + 2);
      expect(sut.queue.last, tNewSongs[1]);
      // tAvailableSongs is actually modified by this
      // because DynamicQueue uses the exact list
      expect(
        sut.availableSongsStream.value.last,
        QueueItemModel(
          tNewSongs[1],
          originalIndex: tAvailableSongs.length - 1,
          isAvailable: false,
          source: QueueItemSource.added,
        ),
      );
    });
  });

  group('moveQueueItem', () {
    late List<QueueItem> tQueue;

    setUp(() {
      tQueue = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );
      final tAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );
      const tPlayable = clayman;
      sut.init(tQueue, tAvailableSongs, tPlayable);
    });

    test('0 -> 1', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(0, 1);

      // assert
      final expectedQueue = [tQueue[1]] + [tQueue[0]] + tQueue.sublist(2);
      expect(sut.queueItemsStream.value, expectedQueue);
      expect(sut.queue, expectedQueue.map((e) => e.song).toList());
    });

    test('1 -> 0', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(1, 0);

      // assert
      expect(sut.queueItemsStream.value, [tQueue[1]] + [tQueue[0]] + tQueue.sublist(2));
    });

    test('3 -> 3', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(3, 3);

      // assert
      expect(sut.queueItemsStream.value, tQueue);
    });

    test('2 -> 7', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(2, 7);

      // assert
      expect(
        sut.queueItemsStream.value,
        tQueue.sublist(0, 2) + tQueue.sublist(3, 8) + [tQueue[2]] + tQueue.sublist(8),
      );
    });

    test('0 -> queue.length - 1', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(0, tQueue.length - 1);

      // assert
      expect(sut.queueItemsStream.value, tQueue.sublist(1) + [tQueue[0]]);
    });

    test('0 -> queue.length', () {
      // arrange -> setUp

      // act & assert
      expect(() => sut.moveQueueItem(0, tQueue.length), throwsRangeError);
    });

    test('queue.length - 1 -> 0', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(tQueue.length - 1, 0);

      // assert
      expect(sut.queueItemsStream.value, [tQueue.last] + tQueue.sublist(0, tQueue.length - 1));
    });

    test('queue.length - 1 -> 1', () {
      // arrange -> setUp

      // act
      sut.moveQueueItem(tQueue.length - 1, 1);

      // assert
      expect(
        sut.queueItemsStream.value,
        [tQueue[0]] + [tQueue.last] + tQueue.sublist(1, tQueue.length - 1),
      );
    });
  });

  group('determineNewStartIndex', () {
    test('choose next song', () {
      // arrange
      const tOldStartIndex = 0;
      final tAllAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );

      final tFilteredAvailableSongs = tAllAvailableSongs.sublist(1);

      // act
      final newStartIndex = sut.determineNewStartIndex(
        tOldStartIndex,
        tAllAvailableSongs,
        tFilteredAvailableSongs,
      );

      // assert
      expect(newStartIndex, 0);
      expect(tFilteredAvailableSongs[newStartIndex], tAllAvailableSongs[1]);
    });

    test('choose previous song', () {
      // arrange
      const tOldStartIndex = 1;
      final tAllAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );

      final tFilteredAvailableSongs = [tAllAvailableSongs[0]] + tAllAvailableSongs.sublist(3);

      // act
      final newStartIndex = sut.determineNewStartIndex(
        tOldStartIndex,
        tAllAvailableSongs,
        tFilteredAvailableSongs,
      );

      // assert
      expect(newStartIndex, 0);
      expect(tFilteredAvailableSongs[newStartIndex], tAllAvailableSongs[0]);
    });

    test('choose last song', () {
      // arrange
      const tOldStartIndex = 0;
      final tAllAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );

      final tFilteredAvailableSongs = [tAllAvailableSongs.last];

      // act
      final newStartIndex = sut.determineNewStartIndex(
        tOldStartIndex,
        tAllAvailableSongs,
        tFilteredAvailableSongs,
      );

      // assert
      expect(newStartIndex, 0);
      expect(tFilteredAvailableSongs[newStartIndex], tAllAvailableSongs.last);
    });

    test('choose first song', () {
      // arrange
      final tAllAvailableSongs = List<QueueItem>.generate(
        claymanSongs.length,
        (i) => QueueItem(
          claymanSongs[i],
          originalIndex: i,
          isAvailable: false,
        ),
      );
      final tOldStartIndex = tAllAvailableSongs.length - 1;

      final tFilteredAvailableSongs = [tAllAvailableSongs.first];

      // act
      final newStartIndex = sut.determineNewStartIndex(
        tOldStartIndex,
        tAllAvailableSongs,
        tFilteredAvailableSongs,
      );

      // assert
      expect(newStartIndex, 0);
      expect(tFilteredAvailableSongs[newStartIndex], tAllAvailableSongs.first);
    });
  });
}
