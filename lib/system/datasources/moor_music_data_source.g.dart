// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_music_data_source.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorAlbum extends DataClass implements Insertable<MoorAlbum> {
  final String title;
  final String artist;
  final String albumArtPath;
  final int year;
  MoorAlbum(
      {@required this.title,
      @required this.artist,
      this.albumArtPath,
      this.year});
  factory MoorAlbum.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return MoorAlbum(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      albumArtPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      year: intType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
    );
  }
  factory MoorAlbum.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorAlbum(
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      albumArtPath: serializer.fromJson<String>(json['albumArtPath']),
      year: serializer.fromJson<int>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'albumArtPath': serializer.toJson<String>(albumArtPath),
      'year': serializer.toJson<int>(year),
    };
  }

  @override
  AlbumsCompanion createCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      albumArtPath: albumArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtPath),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
    );
  }

  MoorAlbum copyWith(
          {String title, String artist, String albumArtPath, int year}) =>
      MoorAlbum(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        year: year ?? this.year,
      );
  @override
  String toString() {
    return (StringBuffer('MoorAlbum(')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(title.hashCode,
      $mrjc(artist.hashCode, $mrjc(albumArtPath.hashCode, year.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorAlbum &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.albumArtPath == this.albumArtPath &&
          other.year == this.year);
}

class AlbumsCompanion extends UpdateCompanion<MoorAlbum> {
  final Value<String> title;
  final Value<String> artist;
  final Value<String> albumArtPath;
  final Value<int> year;
  const AlbumsCompanion({
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  });
  AlbumsCompanion.insert({
    @required String title,
    @required String artist,
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist);
  AlbumsCompanion copyWith(
      {Value<String> title,
      Value<String> artist,
      Value<String> albumArtPath,
      Value<int> year}) {
    return AlbumsCompanion(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      year: year ?? this.year,
    );
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, MoorAlbum> {
  final GeneratedDatabase _db;
  final String _alias;
  $AlbumsTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  GeneratedTextColumn _artist;
  @override
  GeneratedTextColumn get artist => _artist ??= _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn(
      'artist',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  GeneratedTextColumn _albumArtPath;
  @override
  GeneratedTextColumn get albumArtPath =>
      _albumArtPath ??= _constructAlbumArtPath();
  GeneratedTextColumn _constructAlbumArtPath() {
    return GeneratedTextColumn(
      'album_art_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedIntColumn _year;
  @override
  GeneratedIntColumn get year => _year ??= _constructYear();
  GeneratedIntColumn _constructYear() {
    return GeneratedIntColumn(
      'year',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [title, artist, albumArtPath, year];
  @override
  $AlbumsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'albums';
  @override
  final String actualTableName = 'albums';
  @override
  VerificationContext validateIntegrity(AlbumsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.artist.present) {
      context.handle(
          _artistMeta, artist.isAcceptableValue(d.artist.value, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (d.albumArtPath.present) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableValue(
              d.albumArtPath.value, _albumArtPathMeta));
    }
    if (d.year.present) {
      context.handle(
          _yearMeta, year.isAcceptableValue(d.year.value, _yearMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title, artist};
  @override
  MoorAlbum map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorAlbum.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AlbumsCompanion d) {
    final map = <String, Variable>{};
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.artist.present) {
      map['artist'] = Variable<String, StringType>(d.artist.value);
    }
    if (d.albumArtPath.present) {
      map['album_art_path'] =
          Variable<String, StringType>(d.albumArtPath.value);
    }
    if (d.year.present) {
      map['year'] = Variable<int, IntType>(d.year.value);
    }
    return map;
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(_db, alias);
  }
}

class MoorSong extends DataClass implements Insertable<MoorSong> {
  final String title;
  final String album;
  final String artist;
  final String path;
  final String albumArtPath;
  final int trackNumber;
  MoorSong(
      {@required this.title,
      @required this.album,
      @required this.artist,
      @required this.path,
      this.albumArtPath,
      this.trackNumber});
  factory MoorSong.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return MoorSong(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      album:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}album']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
      albumArtPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      trackNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}track_number']),
    );
  }
  factory MoorSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorSong(
      title: serializer.fromJson<String>(json['title']),
      album: serializer.fromJson<String>(json['album']),
      artist: serializer.fromJson<String>(json['artist']),
      path: serializer.fromJson<String>(json['path']),
      albumArtPath: serializer.fromJson<String>(json['albumArtPath']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'album': serializer.toJson<String>(album),
      'artist': serializer.toJson<String>(artist),
      'path': serializer.toJson<String>(path),
      'albumArtPath': serializer.toJson<String>(albumArtPath),
      'trackNumber': serializer.toJson<int>(trackNumber),
    };
  }

  @override
  SongsCompanion createCompanion(bool nullToAbsent) {
    return SongsCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      album:
          album == null && nullToAbsent ? const Value.absent() : Value(album),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      albumArtPath: albumArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtPath),
      trackNumber: trackNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNumber),
    );
  }

  MoorSong copyWith(
          {String title,
          String album,
          String artist,
          String path,
          String albumArtPath,
          int trackNumber}) =>
      MoorSong(
        title: title ?? this.title,
        album: album ?? this.album,
        artist: artist ?? this.artist,
        path: path ?? this.path,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        trackNumber: trackNumber ?? this.trackNumber,
      );
  @override
  String toString() {
    return (StringBuffer('MoorSong(')
          ..write('title: $title, ')
          ..write('album: $album, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('trackNumber: $trackNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      title.hashCode,
      $mrjc(
          album.hashCode,
          $mrjc(
              artist.hashCode,
              $mrjc(path.hashCode,
                  $mrjc(albumArtPath.hashCode, trackNumber.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorSong &&
          other.title == this.title &&
          other.album == this.album &&
          other.artist == this.artist &&
          other.path == this.path &&
          other.albumArtPath == this.albumArtPath &&
          other.trackNumber == this.trackNumber);
}

class SongsCompanion extends UpdateCompanion<MoorSong> {
  final Value<String> title;
  final Value<String> album;
  final Value<String> artist;
  final Value<String> path;
  final Value<String> albumArtPath;
  final Value<int> trackNumber;
  const SongsCompanion({
    this.title = const Value.absent(),
    this.album = const Value.absent(),
    this.artist = const Value.absent(),
    this.path = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.trackNumber = const Value.absent(),
  });
  SongsCompanion.insert({
    @required String title,
    @required String album,
    @required String artist,
    @required String path,
    this.albumArtPath = const Value.absent(),
    this.trackNumber = const Value.absent(),
  })  : title = Value(title),
        album = Value(album),
        artist = Value(artist),
        path = Value(path);
  SongsCompanion copyWith(
      {Value<String> title,
      Value<String> album,
      Value<String> artist,
      Value<String> path,
      Value<String> albumArtPath,
      Value<int> trackNumber}) {
    return SongsCompanion(
      title: title ?? this.title,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      trackNumber: trackNumber ?? this.trackNumber,
    );
  }
}

class $SongsTable extends Songs with TableInfo<$SongsTable, MoorSong> {
  final GeneratedDatabase _db;
  final String _alias;
  $SongsTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumMeta = const VerificationMeta('album');
  GeneratedTextColumn _album;
  @override
  GeneratedTextColumn get album => _album ??= _constructAlbum();
  GeneratedTextColumn _constructAlbum() {
    return GeneratedTextColumn(
      'album',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  GeneratedTextColumn _artist;
  @override
  GeneratedTextColumn get artist => _artist ??= _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn(
      'artist',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pathMeta = const VerificationMeta('path');
  GeneratedTextColumn _path;
  @override
  GeneratedTextColumn get path => _path ??= _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn(
      'path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  GeneratedTextColumn _albumArtPath;
  @override
  GeneratedTextColumn get albumArtPath =>
      _albumArtPath ??= _constructAlbumArtPath();
  GeneratedTextColumn _constructAlbumArtPath() {
    return GeneratedTextColumn(
      'album_art_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _trackNumberMeta =
      const VerificationMeta('trackNumber');
  GeneratedIntColumn _trackNumber;
  @override
  GeneratedIntColumn get trackNumber =>
      _trackNumber ??= _constructTrackNumber();
  GeneratedIntColumn _constructTrackNumber() {
    return GeneratedIntColumn(
      'track_number',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [title, album, artist, path, albumArtPath, trackNumber];
  @override
  $SongsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'songs';
  @override
  final String actualTableName = 'songs';
  @override
  VerificationContext validateIntegrity(SongsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.album.present) {
      context.handle(
          _albumMeta, album.isAcceptableValue(d.album.value, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (d.artist.present) {
      context.handle(
          _artistMeta, artist.isAcceptableValue(d.artist.value, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (d.path.present) {
      context.handle(
          _pathMeta, path.isAcceptableValue(d.path.value, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (d.albumArtPath.present) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableValue(
              d.albumArtPath.value, _albumArtPathMeta));
    }
    if (d.trackNumber.present) {
      context.handle(_trackNumberMeta,
          trackNumber.isAcceptableValue(d.trackNumber.value, _trackNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  MoorSong map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorSong.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SongsCompanion d) {
    final map = <String, Variable>{};
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.album.present) {
      map['album'] = Variable<String, StringType>(d.album.value);
    }
    if (d.artist.present) {
      map['artist'] = Variable<String, StringType>(d.artist.value);
    }
    if (d.path.present) {
      map['path'] = Variable<String, StringType>(d.path.value);
    }
    if (d.albumArtPath.present) {
      map['album_art_path'] =
          Variable<String, StringType>(d.albumArtPath.value);
    }
    if (d.trackNumber.present) {
      map['track_number'] = Variable<int, IntType>(d.trackNumber.value);
    }
    return map;
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(_db, alias);
  }
}

abstract class _$MoorMusicDataSource extends GeneratedDatabase {
  _$MoorMusicDataSource(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $AlbumsTable _albums;
  $AlbumsTable get albums => _albums ??= $AlbumsTable(this);
  $SongsTable _songs;
  $SongsTable get songs => _songs ??= $SongsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [albums, songs];
}
