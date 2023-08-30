import 'package:mucke/domain/entities/song.dart';

final Song song1 = Song(
  album: 'Sample Album',
  albumId: 1,
  artist: 'Sample Artist',
  blockLevel: 3,
  duration: const Duration(minutes: 3, seconds: 45),
  path: '/path/to/song1.mp3',
  title: 'Sample Song 1',
  likeCount: 1,
  playCount: 350,
  discNumber: 1,
  next: false,
  previous: false,
  timeAdded: DateTime(1990),
  trackNumber: 5,
);

final Song song2 = Song(
  album: 'Sample Album 2',
  albumId: 2,
  artist: 'Sample Artist 2',
  blockLevel: 2,
  duration: const Duration(minutes: 4, seconds: 10),
  path: '/path/to/song2.mp3',
  title: 'Sample Song 2',
  likeCount: 3,
  playCount: 420,
  discNumber: 1,
  next: false,
  previous: false,
  timeAdded: DateTime(2000),
  trackNumber: 2,
);

final Song song3 = Song(
  album: 'Sample Album 1',
  albumId: 1,
  artist: 'Sample Artist 1',
  blockLevel: 0,
  duration: const Duration(minutes: 5, seconds: 20),
  path: '/path/to/song3.mp3',
  title: 'Sample Song 3',
  likeCount: 0,
  playCount: 150,
  discNumber: 2,
  next: false,
  previous: false,
  timeAdded: DateTime(2010),
  trackNumber: 7,
);
