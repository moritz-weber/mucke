// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorAlbum extends DataClass implements Insertable<MoorAlbum> {
  final int id;
  final String title;
  final String artist;
  final String albumArtPath;
  final int year;
  MoorAlbum(
      {@required this.id,
      @required this.title,
      @required this.artist,
      this.albumArtPath,
      this.year});
  factory MoorAlbum.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MoorAlbum(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      albumArtPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      year: intType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || albumArtPath != null) {
      map['album_art_path'] = Variable<String>(albumArtPath);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
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

  factory MoorAlbum.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorAlbum(
      id: serializer.fromJson<int>(json['id']),
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
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'albumArtPath': serializer.toJson<String>(albumArtPath),
      'year': serializer.toJson<int>(year),
    };
  }

  MoorAlbum copyWith(
          {int id,
          String title,
          String artist,
          String albumArtPath,
          int year}) =>
      MoorAlbum(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        year: year ?? this.year,
      );
  @override
  String toString() {
    return (StringBuffer('MoorAlbum(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              artist.hashCode, $mrjc(albumArtPath.hashCode, year.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorAlbum &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.albumArtPath == this.albumArtPath &&
          other.year == this.year);
}

class AlbumsCompanion extends UpdateCompanion<MoorAlbum> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> albumArtPath;
  final Value<int> year;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  });
  AlbumsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String artist,
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist);
  static Insertable<MoorAlbum> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> artist,
    Expression<String> albumArtPath,
    Expression<int> year,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (albumArtPath != null) 'album_art_path': albumArtPath,
      if (year != null) 'year': year,
    });
  }

  AlbumsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> artist,
      Value<String> albumArtPath,
      Value<int> year}) {
    return AlbumsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      year: year ?? this.year,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (albumArtPath.present) {
      map['album_art_path'] = Variable<String>(albumArtPath.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, MoorAlbum> {
  final GeneratedDatabase _db;
  final String _alias;
  $AlbumsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

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
  List<GeneratedColumn> get $columns => [id, title, artist, albumArtPath, year];
  @override
  $AlbumsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'albums';
  @override
  final String actualTableName = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<MoorAlbum> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist'], _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album_art_path')) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableOrUnknown(
              data['album_art_path'], _albumArtPathMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorAlbum map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorAlbum.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(_db, alias);
  }
}

class MoorArtist extends DataClass implements Insertable<MoorArtist> {
  final String name;
  MoorArtist({@required this.name});
  factory MoorArtist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MoorArtist(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory MoorArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorArtist(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  MoorArtist copyWith({String name}) => MoorArtist(
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('MoorArtist(')..write('name: $name')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(name.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorArtist && other.name == this.name);
}

class ArtistsCompanion extends UpdateCompanion<MoorArtist> {
  final Value<String> name;
  const ArtistsCompanion({
    this.name = const Value.absent(),
  });
  ArtistsCompanion.insert({
    @required String name,
  }) : name = Value(name);
  static Insertable<MoorArtist> custom({
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
    });
  }

  ArtistsCompanion copyWith({Value<String> name}) {
    return ArtistsCompanion(
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistsCompanion(')..write('name: $name')..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, MoorArtist> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtistsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name];
  @override
  $ArtistsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artists';
  @override
  final String actualTableName = 'artists';
  @override
  VerificationContext validateIntegrity(Insertable<MoorArtist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  MoorArtist map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorArtist.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(_db, alias);
  }
}

class LibraryFolder extends DataClass implements Insertable<LibraryFolder> {
  final String path;
  LibraryFolder({@required this.path});
  factory LibraryFolder.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return LibraryFolder(
      path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    return map;
  }

  LibraryFoldersCompanion toCompanion(bool nullToAbsent) {
    return LibraryFoldersCompanion(
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
    );
  }

  factory LibraryFolder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LibraryFolder(
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
    };
  }

  LibraryFolder copyWith({String path}) => LibraryFolder(
        path: path ?? this.path,
      );
  @override
  String toString() {
    return (StringBuffer('LibraryFolder(')..write('path: $path')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(path.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is LibraryFolder && other.path == this.path);
}

class LibraryFoldersCompanion extends UpdateCompanion<LibraryFolder> {
  final Value<String> path;
  const LibraryFoldersCompanion({
    this.path = const Value.absent(),
  });
  LibraryFoldersCompanion.insert({
    @required String path,
  }) : path = Value(path);
  static Insertable<LibraryFolder> custom({
    Expression<String> path,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
    });
  }

  LibraryFoldersCompanion copyWith({Value<String> path}) {
    return LibraryFoldersCompanion(
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryFoldersCompanion(')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $LibraryFoldersTable extends LibraryFolders
    with TableInfo<$LibraryFoldersTable, LibraryFolder> {
  final GeneratedDatabase _db;
  final String _alias;
  $LibraryFoldersTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [path];
  @override
  $LibraryFoldersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'library_folders';
  @override
  final String actualTableName = 'library_folders';
  @override
  VerificationContext validateIntegrity(Insertable<LibraryFolder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path'], _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  LibraryFolder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LibraryFolder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $LibraryFoldersTable createAlias(String alias) {
    return $LibraryFoldersTable(_db, alias);
  }
}

class MoorQueueEntry extends DataClass implements Insertable<MoorQueueEntry> {
  final int index;
  final String path;
  final int originalIndex;
  final int type;
  MoorQueueEntry(
      {@required this.index,
      @required this.path,
      @required this.originalIndex,
      @required this.type});
  factory MoorQueueEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MoorQueueEntry(
      index: intType.mapFromDatabaseResponse(data['${effectivePrefix}index']),
      path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
      originalIndex: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}original_index']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || originalIndex != null) {
      map['original_index'] = Variable<int>(originalIndex);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<int>(type);
    }
    return map;
  }

  QueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return QueueEntriesCompanion(
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      originalIndex: originalIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(originalIndex),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory MoorQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorQueueEntry(
      index: serializer.fromJson<int>(json['index']),
      path: serializer.fromJson<String>(json['path']),
      originalIndex: serializer.fromJson<int>(json['originalIndex']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'path': serializer.toJson<String>(path),
      'originalIndex': serializer.toJson<int>(originalIndex),
      'type': serializer.toJson<int>(type),
    };
  }

  MoorQueueEntry copyWith(
          {int index, String path, int originalIndex, int type}) =>
      MoorQueueEntry(
        index: index ?? this.index,
        path: path ?? this.path,
        originalIndex: originalIndex ?? this.originalIndex,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('MoorQueueEntry(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(index.hashCode,
      $mrjc(path.hashCode, $mrjc(originalIndex.hashCode, type.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorQueueEntry &&
          other.index == this.index &&
          other.path == this.path &&
          other.originalIndex == this.originalIndex &&
          other.type == this.type);
}

class QueueEntriesCompanion extends UpdateCompanion<MoorQueueEntry> {
  final Value<int> index;
  final Value<String> path;
  final Value<int> originalIndex;
  final Value<int> type;
  const QueueEntriesCompanion({
    this.index = const Value.absent(),
    this.path = const Value.absent(),
    this.originalIndex = const Value.absent(),
    this.type = const Value.absent(),
  });
  QueueEntriesCompanion.insert({
    this.index = const Value.absent(),
    @required String path,
    @required int originalIndex,
    @required int type,
  })  : path = Value(path),
        originalIndex = Value(originalIndex),
        type = Value(type);
  static Insertable<MoorQueueEntry> custom({
    Expression<int> index,
    Expression<String> path,
    Expression<int> originalIndex,
    Expression<int> type,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (path != null) 'path': path,
      if (originalIndex != null) 'original_index': originalIndex,
      if (type != null) 'type': type,
    });
  }

  QueueEntriesCompanion copyWith(
      {Value<int> index,
      Value<String> path,
      Value<int> originalIndex,
      Value<int> type}) {
    return QueueEntriesCompanion(
      index: index ?? this.index,
      path: path ?? this.path,
      originalIndex: originalIndex ?? this.originalIndex,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (originalIndex.present) {
      map['original_index'] = Variable<int>(originalIndex.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueEntriesCompanion(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $QueueEntriesTable extends QueueEntries
    with TableInfo<$QueueEntriesTable, MoorQueueEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $QueueEntriesTable(this._db, [this._alias]);
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  GeneratedIntColumn _index;
  @override
  GeneratedIntColumn get index => _index ??= _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
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

  final VerificationMeta _originalIndexMeta =
      const VerificationMeta('originalIndex');
  GeneratedIntColumn _originalIndex;
  @override
  GeneratedIntColumn get originalIndex =>
      _originalIndex ??= _constructOriginalIndex();
  GeneratedIntColumn _constructOriginalIndex() {
    return GeneratedIntColumn(
      'original_index',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [index, path, originalIndex, type];
  @override
  $QueueEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'queue_entries';
  @override
  final String actualTableName = 'queue_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MoorQueueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index'], _indexMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path'], _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('original_index')) {
      context.handle(
          _originalIndexMeta,
          originalIndex.isAcceptableOrUnknown(
              data['original_index'], _originalIndexMeta));
    } else if (isInserting) {
      context.missing(_originalIndexMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  MoorQueueEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorQueueEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $QueueEntriesTable createAlias(String alias) {
    return $QueueEntriesTable(_db, alias);
  }
}

class PersistentIndexData extends DataClass
    implements Insertable<PersistentIndexData> {
  final int index;
  PersistentIndexData({this.index});
  factory PersistentIndexData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return PersistentIndexData(
      index: intType.mapFromDatabaseResponse(data['${effectivePrefix}index']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    return map;
  }

  PersistentIndexCompanion toCompanion(bool nullToAbsent) {
    return PersistentIndexCompanion(
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
    );
  }

  factory PersistentIndexData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PersistentIndexData(
      index: serializer.fromJson<int>(json['index']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
    };
  }

  PersistentIndexData copyWith({int index}) => PersistentIndexData(
        index: index ?? this.index,
      );
  @override
  String toString() {
    return (StringBuffer('PersistentIndexData(')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(index.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PersistentIndexData && other.index == this.index);
}

class PersistentIndexCompanion extends UpdateCompanion<PersistentIndexData> {
  final Value<int> index;
  const PersistentIndexCompanion({
    this.index = const Value.absent(),
  });
  PersistentIndexCompanion.insert({
    this.index = const Value.absent(),
  });
  static Insertable<PersistentIndexData> custom({
    Expression<int> index,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
    });
  }

  PersistentIndexCompanion copyWith({Value<int> index}) {
    return PersistentIndexCompanion(
      index: index ?? this.index,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersistentIndexCompanion(')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }
}

class $PersistentIndexTable extends PersistentIndex
    with TableInfo<$PersistentIndexTable, PersistentIndexData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PersistentIndexTable(this._db, [this._alias]);
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  GeneratedIntColumn _index;
  @override
  GeneratedIntColumn get index => _index ??= _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [index];
  @override
  $PersistentIndexTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'persistent_index';
  @override
  final String actualTableName = 'persistent_index';
  @override
  VerificationContext validateIntegrity(
      Insertable<PersistentIndexData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index'], _indexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PersistentIndexData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PersistentIndexData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PersistentIndexTable createAlias(String alias) {
    return $PersistentIndexTable(_db, alias);
  }
}

class PersistentLoopModeData extends DataClass
    implements Insertable<PersistentLoopModeData> {
  final int loopMode;
  PersistentLoopModeData({@required this.loopMode});
  factory PersistentLoopModeData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return PersistentLoopModeData(
      loopMode:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}loop_mode']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || loopMode != null) {
      map['loop_mode'] = Variable<int>(loopMode);
    }
    return map;
  }

  PersistentLoopModeCompanion toCompanion(bool nullToAbsent) {
    return PersistentLoopModeCompanion(
      loopMode: loopMode == null && nullToAbsent
          ? const Value.absent()
          : Value(loopMode),
    );
  }

  factory PersistentLoopModeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PersistentLoopModeData(
      loopMode: serializer.fromJson<int>(json['loopMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'loopMode': serializer.toJson<int>(loopMode),
    };
  }

  PersistentLoopModeData copyWith({int loopMode}) => PersistentLoopModeData(
        loopMode: loopMode ?? this.loopMode,
      );
  @override
  String toString() {
    return (StringBuffer('PersistentLoopModeData(')
          ..write('loopMode: $loopMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(loopMode.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PersistentLoopModeData && other.loopMode == this.loopMode);
}

class PersistentLoopModeCompanion
    extends UpdateCompanion<PersistentLoopModeData> {
  final Value<int> loopMode;
  const PersistentLoopModeCompanion({
    this.loopMode = const Value.absent(),
  });
  PersistentLoopModeCompanion.insert({
    this.loopMode = const Value.absent(),
  });
  static Insertable<PersistentLoopModeData> custom({
    Expression<int> loopMode,
  }) {
    return RawValuesInsertable({
      if (loopMode != null) 'loop_mode': loopMode,
    });
  }

  PersistentLoopModeCompanion copyWith({Value<int> loopMode}) {
    return PersistentLoopModeCompanion(
      loopMode: loopMode ?? this.loopMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (loopMode.present) {
      map['loop_mode'] = Variable<int>(loopMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersistentLoopModeCompanion(')
          ..write('loopMode: $loopMode')
          ..write(')'))
        .toString();
  }
}

class $PersistentLoopModeTable extends PersistentLoopMode
    with TableInfo<$PersistentLoopModeTable, PersistentLoopModeData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PersistentLoopModeTable(this._db, [this._alias]);
  final VerificationMeta _loopModeMeta = const VerificationMeta('loopMode');
  GeneratedIntColumn _loopMode;
  @override
  GeneratedIntColumn get loopMode => _loopMode ??= _constructLoopMode();
  GeneratedIntColumn _constructLoopMode() {
    return GeneratedIntColumn('loop_mode', $tableName, false,
        defaultValue: const Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [loopMode];
  @override
  $PersistentLoopModeTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'persistent_loop_mode';
  @override
  final String actualTableName = 'persistent_loop_mode';
  @override
  VerificationContext validateIntegrity(
      Insertable<PersistentLoopModeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('loop_mode')) {
      context.handle(_loopModeMeta,
          loopMode.isAcceptableOrUnknown(data['loop_mode'], _loopModeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PersistentLoopModeData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PersistentLoopModeData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PersistentLoopModeTable createAlias(String alias) {
    return $PersistentLoopModeTable(_db, alias);
  }
}

class PersistentShuffleModeData extends DataClass
    implements Insertable<PersistentShuffleModeData> {
  final int shuffleMode;
  PersistentShuffleModeData({@required this.shuffleMode});
  factory PersistentShuffleModeData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return PersistentShuffleModeData(
      shuffleMode: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}shuffle_mode']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || shuffleMode != null) {
      map['shuffle_mode'] = Variable<int>(shuffleMode);
    }
    return map;
  }

  PersistentShuffleModeCompanion toCompanion(bool nullToAbsent) {
    return PersistentShuffleModeCompanion(
      shuffleMode: shuffleMode == null && nullToAbsent
          ? const Value.absent()
          : Value(shuffleMode),
    );
  }

  factory PersistentShuffleModeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PersistentShuffleModeData(
      shuffleMode: serializer.fromJson<int>(json['shuffleMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shuffleMode': serializer.toJson<int>(shuffleMode),
    };
  }

  PersistentShuffleModeData copyWith({int shuffleMode}) =>
      PersistentShuffleModeData(
        shuffleMode: shuffleMode ?? this.shuffleMode,
      );
  @override
  String toString() {
    return (StringBuffer('PersistentShuffleModeData(')
          ..write('shuffleMode: $shuffleMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(shuffleMode.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PersistentShuffleModeData &&
          other.shuffleMode == this.shuffleMode);
}

class PersistentShuffleModeCompanion
    extends UpdateCompanion<PersistentShuffleModeData> {
  final Value<int> shuffleMode;
  const PersistentShuffleModeCompanion({
    this.shuffleMode = const Value.absent(),
  });
  PersistentShuffleModeCompanion.insert({
    this.shuffleMode = const Value.absent(),
  });
  static Insertable<PersistentShuffleModeData> custom({
    Expression<int> shuffleMode,
  }) {
    return RawValuesInsertable({
      if (shuffleMode != null) 'shuffle_mode': shuffleMode,
    });
  }

  PersistentShuffleModeCompanion copyWith({Value<int> shuffleMode}) {
    return PersistentShuffleModeCompanion(
      shuffleMode: shuffleMode ?? this.shuffleMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shuffleMode.present) {
      map['shuffle_mode'] = Variable<int>(shuffleMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersistentShuffleModeCompanion(')
          ..write('shuffleMode: $shuffleMode')
          ..write(')'))
        .toString();
  }
}

class $PersistentShuffleModeTable extends PersistentShuffleMode
    with TableInfo<$PersistentShuffleModeTable, PersistentShuffleModeData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PersistentShuffleModeTable(this._db, [this._alias]);
  final VerificationMeta _shuffleModeMeta =
      const VerificationMeta('shuffleMode');
  GeneratedIntColumn _shuffleMode;
  @override
  GeneratedIntColumn get shuffleMode =>
      _shuffleMode ??= _constructShuffleMode();
  GeneratedIntColumn _constructShuffleMode() {
    return GeneratedIntColumn('shuffle_mode', $tableName, false,
        defaultValue: const Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [shuffleMode];
  @override
  $PersistentShuffleModeTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'persistent_shuffle_mode';
  @override
  final String actualTableName = 'persistent_shuffle_mode';
  @override
  VerificationContext validateIntegrity(
      Insertable<PersistentShuffleModeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shuffle_mode')) {
      context.handle(
          _shuffleModeMeta,
          shuffleMode.isAcceptableOrUnknown(
              data['shuffle_mode'], _shuffleModeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PersistentShuffleModeData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PersistentShuffleModeData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  $PersistentShuffleModeTable createAlias(String alias) {
    return $PersistentShuffleModeTable(_db, alias);
  }
}

class MoorSong extends DataClass implements Insertable<MoorSong> {
  final String title;
  final String albumTitle;
  final int albumId;
  final String artist;
  final String path;
  final int duration;
  final String albumArtPath;
  final int discNumber;
  final int trackNumber;
  final bool blocked;
  final bool present;
  final int likeCount;
  final int skipCount;
  final int playCount;
  final String previous;
  final String next;
  MoorSong(
      {@required this.title,
      @required this.albumTitle,
      @required this.albumId,
      @required this.artist,
      @required this.path,
      this.duration,
      this.albumArtPath,
      this.discNumber,
      this.trackNumber,
      @required this.blocked,
      @required this.present,
      @required this.likeCount,
      @required this.skipCount,
      @required this.playCount,
      this.previous,
      this.next});
  factory MoorSong.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MoorSong(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      albumTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_title']),
      albumId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}album_id']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
      duration:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      albumArtPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      discNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}disc_number']),
      trackNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}track_number']),
      blocked:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}blocked']),
      present:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}present']),
      likeCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}like_count']),
      skipCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}skip_count']),
      playCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}play_count']),
      previous: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}previous']),
      next: stringType.mapFromDatabaseResponse(data['${effectivePrefix}next']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || albumTitle != null) {
      map['album_title'] = Variable<String>(albumTitle);
    }
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<int>(albumId);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || albumArtPath != null) {
      map['album_art_path'] = Variable<String>(albumArtPath);
    }
    if (!nullToAbsent || discNumber != null) {
      map['disc_number'] = Variable<int>(discNumber);
    }
    if (!nullToAbsent || trackNumber != null) {
      map['track_number'] = Variable<int>(trackNumber);
    }
    if (!nullToAbsent || blocked != null) {
      map['blocked'] = Variable<bool>(blocked);
    }
    if (!nullToAbsent || present != null) {
      map['present'] = Variable<bool>(present);
    }
    if (!nullToAbsent || likeCount != null) {
      map['like_count'] = Variable<int>(likeCount);
    }
    if (!nullToAbsent || skipCount != null) {
      map['skip_count'] = Variable<int>(skipCount);
    }
    if (!nullToAbsent || playCount != null) {
      map['play_count'] = Variable<int>(playCount);
    }
    if (!nullToAbsent || previous != null) {
      map['previous'] = Variable<String>(previous);
    }
    if (!nullToAbsent || next != null) {
      map['next'] = Variable<String>(next);
    }
    return map;
  }

  SongsCompanion toCompanion(bool nullToAbsent) {
    return SongsCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      albumTitle: albumTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(albumTitle),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      albumArtPath: albumArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtPath),
      discNumber: discNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(discNumber),
      trackNumber: trackNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNumber),
      blocked: blocked == null && nullToAbsent
          ? const Value.absent()
          : Value(blocked),
      present: present == null && nullToAbsent
          ? const Value.absent()
          : Value(present),
      likeCount: likeCount == null && nullToAbsent
          ? const Value.absent()
          : Value(likeCount),
      skipCount: skipCount == null && nullToAbsent
          ? const Value.absent()
          : Value(skipCount),
      playCount: playCount == null && nullToAbsent
          ? const Value.absent()
          : Value(playCount),
      previous: previous == null && nullToAbsent
          ? const Value.absent()
          : Value(previous),
      next: next == null && nullToAbsent ? const Value.absent() : Value(next),
    );
  }

  factory MoorSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorSong(
      title: serializer.fromJson<String>(json['title']),
      albumTitle: serializer.fromJson<String>(json['albumTitle']),
      albumId: serializer.fromJson<int>(json['albumId']),
      artist: serializer.fromJson<String>(json['artist']),
      path: serializer.fromJson<String>(json['path']),
      duration: serializer.fromJson<int>(json['duration']),
      albumArtPath: serializer.fromJson<String>(json['albumArtPath']),
      discNumber: serializer.fromJson<int>(json['discNumber']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
      blocked: serializer.fromJson<bool>(json['blocked']),
      present: serializer.fromJson<bool>(json['present']),
      likeCount: serializer.fromJson<int>(json['likeCount']),
      skipCount: serializer.fromJson<int>(json['skipCount']),
      playCount: serializer.fromJson<int>(json['playCount']),
      previous: serializer.fromJson<String>(json['previous']),
      next: serializer.fromJson<String>(json['next']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'albumTitle': serializer.toJson<String>(albumTitle),
      'albumId': serializer.toJson<int>(albumId),
      'artist': serializer.toJson<String>(artist),
      'path': serializer.toJson<String>(path),
      'duration': serializer.toJson<int>(duration),
      'albumArtPath': serializer.toJson<String>(albumArtPath),
      'discNumber': serializer.toJson<int>(discNumber),
      'trackNumber': serializer.toJson<int>(trackNumber),
      'blocked': serializer.toJson<bool>(blocked),
      'present': serializer.toJson<bool>(present),
      'likeCount': serializer.toJson<int>(likeCount),
      'skipCount': serializer.toJson<int>(skipCount),
      'playCount': serializer.toJson<int>(playCount),
      'previous': serializer.toJson<String>(previous),
      'next': serializer.toJson<String>(next),
    };
  }

  MoorSong copyWith(
          {String title,
          String albumTitle,
          int albumId,
          String artist,
          String path,
          int duration,
          String albumArtPath,
          int discNumber,
          int trackNumber,
          bool blocked,
          bool present,
          int likeCount,
          int skipCount,
          int playCount,
          String previous,
          String next}) =>
      MoorSong(
        title: title ?? this.title,
        albumTitle: albumTitle ?? this.albumTitle,
        albumId: albumId ?? this.albumId,
        artist: artist ?? this.artist,
        path: path ?? this.path,
        duration: duration ?? this.duration,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        discNumber: discNumber ?? this.discNumber,
        trackNumber: trackNumber ?? this.trackNumber,
        blocked: blocked ?? this.blocked,
        present: present ?? this.present,
        likeCount: likeCount ?? this.likeCount,
        skipCount: skipCount ?? this.skipCount,
        playCount: playCount ?? this.playCount,
        previous: previous ?? this.previous,
        next: next ?? this.next,
      );
  @override
  String toString() {
    return (StringBuffer('MoorSong(')
          ..write('title: $title, ')
          ..write('albumTitle: $albumTitle, ')
          ..write('albumId: $albumId, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('duration: $duration, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('discNumber: $discNumber, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('blocked: $blocked, ')
          ..write('present: $present, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('previous: $previous, ')
          ..write('next: $next')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      title.hashCode,
      $mrjc(
          albumTitle.hashCode,
          $mrjc(
              albumId.hashCode,
              $mrjc(
                  artist.hashCode,
                  $mrjc(
                      path.hashCode,
                      $mrjc(
                          duration.hashCode,
                          $mrjc(
                              albumArtPath.hashCode,
                              $mrjc(
                                  discNumber.hashCode,
                                  $mrjc(
                                      trackNumber.hashCode,
                                      $mrjc(
                                          blocked.hashCode,
                                          $mrjc(
                                              present.hashCode,
                                              $mrjc(
                                                  likeCount.hashCode,
                                                  $mrjc(
                                                      skipCount.hashCode,
                                                      $mrjc(
                                                          playCount.hashCode,
                                                          $mrjc(
                                                              previous.hashCode,
                                                              next.hashCode))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorSong &&
          other.title == this.title &&
          other.albumTitle == this.albumTitle &&
          other.albumId == this.albumId &&
          other.artist == this.artist &&
          other.path == this.path &&
          other.duration == this.duration &&
          other.albumArtPath == this.albumArtPath &&
          other.discNumber == this.discNumber &&
          other.trackNumber == this.trackNumber &&
          other.blocked == this.blocked &&
          other.present == this.present &&
          other.likeCount == this.likeCount &&
          other.skipCount == this.skipCount &&
          other.playCount == this.playCount &&
          other.previous == this.previous &&
          other.next == this.next);
}

class SongsCompanion extends UpdateCompanion<MoorSong> {
  final Value<String> title;
  final Value<String> albumTitle;
  final Value<int> albumId;
  final Value<String> artist;
  final Value<String> path;
  final Value<int> duration;
  final Value<String> albumArtPath;
  final Value<int> discNumber;
  final Value<int> trackNumber;
  final Value<bool> blocked;
  final Value<bool> present;
  final Value<int> likeCount;
  final Value<int> skipCount;
  final Value<int> playCount;
  final Value<String> previous;
  final Value<String> next;
  const SongsCompanion({
    this.title = const Value.absent(),
    this.albumTitle = const Value.absent(),
    this.albumId = const Value.absent(),
    this.artist = const Value.absent(),
    this.path = const Value.absent(),
    this.duration = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.discNumber = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.blocked = const Value.absent(),
    this.present = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
  });
  SongsCompanion.insert({
    @required String title,
    @required String albumTitle,
    @required int albumId,
    @required String artist,
    @required String path,
    this.duration = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.discNumber = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.blocked = const Value.absent(),
    this.present = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
  })  : title = Value(title),
        albumTitle = Value(albumTitle),
        albumId = Value(albumId),
        artist = Value(artist),
        path = Value(path);
  static Insertable<MoorSong> custom({
    Expression<String> title,
    Expression<String> albumTitle,
    Expression<int> albumId,
    Expression<String> artist,
    Expression<String> path,
    Expression<int> duration,
    Expression<String> albumArtPath,
    Expression<int> discNumber,
    Expression<int> trackNumber,
    Expression<bool> blocked,
    Expression<bool> present,
    Expression<int> likeCount,
    Expression<int> skipCount,
    Expression<int> playCount,
    Expression<String> previous,
    Expression<String> next,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (albumTitle != null) 'album_title': albumTitle,
      if (albumId != null) 'album_id': albumId,
      if (artist != null) 'artist': artist,
      if (path != null) 'path': path,
      if (duration != null) 'duration': duration,
      if (albumArtPath != null) 'album_art_path': albumArtPath,
      if (discNumber != null) 'disc_number': discNumber,
      if (trackNumber != null) 'track_number': trackNumber,
      if (blocked != null) 'blocked': blocked,
      if (present != null) 'present': present,
      if (likeCount != null) 'like_count': likeCount,
      if (skipCount != null) 'skip_count': skipCount,
      if (playCount != null) 'play_count': playCount,
      if (previous != null) 'previous': previous,
      if (next != null) 'next': next,
    });
  }

  SongsCompanion copyWith(
      {Value<String> title,
      Value<String> albumTitle,
      Value<int> albumId,
      Value<String> artist,
      Value<String> path,
      Value<int> duration,
      Value<String> albumArtPath,
      Value<int> discNumber,
      Value<int> trackNumber,
      Value<bool> blocked,
      Value<bool> present,
      Value<int> likeCount,
      Value<int> skipCount,
      Value<int> playCount,
      Value<String> previous,
      Value<String> next}) {
    return SongsCompanion(
      title: title ?? this.title,
      albumTitle: albumTitle ?? this.albumTitle,
      albumId: albumId ?? this.albumId,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      duration: duration ?? this.duration,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      discNumber: discNumber ?? this.discNumber,
      trackNumber: trackNumber ?? this.trackNumber,
      blocked: blocked ?? this.blocked,
      present: present ?? this.present,
      likeCount: likeCount ?? this.likeCount,
      skipCount: skipCount ?? this.skipCount,
      playCount: playCount ?? this.playCount,
      previous: previous ?? this.previous,
      next: next ?? this.next,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (albumTitle.present) {
      map['album_title'] = Variable<String>(albumTitle.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (albumArtPath.present) {
      map['album_art_path'] = Variable<String>(albumArtPath.value);
    }
    if (discNumber.present) {
      map['disc_number'] = Variable<int>(discNumber.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (blocked.present) {
      map['blocked'] = Variable<bool>(blocked.value);
    }
    if (present.present) {
      map['present'] = Variable<bool>(present.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (skipCount.present) {
      map['skip_count'] = Variable<int>(skipCount.value);
    }
    if (playCount.present) {
      map['play_count'] = Variable<int>(playCount.value);
    }
    if (previous.present) {
      map['previous'] = Variable<String>(previous.value);
    }
    if (next.present) {
      map['next'] = Variable<String>(next.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsCompanion(')
          ..write('title: $title, ')
          ..write('albumTitle: $albumTitle, ')
          ..write('albumId: $albumId, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('duration: $duration, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('discNumber: $discNumber, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('blocked: $blocked, ')
          ..write('present: $present, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('previous: $previous, ')
          ..write('next: $next')
          ..write(')'))
        .toString();
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

  final VerificationMeta _albumTitleMeta = const VerificationMeta('albumTitle');
  GeneratedTextColumn _albumTitle;
  @override
  GeneratedTextColumn get albumTitle => _albumTitle ??= _constructAlbumTitle();
  GeneratedTextColumn _constructAlbumTitle() {
    return GeneratedTextColumn(
      'album_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  GeneratedIntColumn _albumId;
  @override
  GeneratedIntColumn get albumId => _albumId ??= _constructAlbumId();
  GeneratedIntColumn _constructAlbumId() {
    return GeneratedIntColumn(
      'album_id',
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

  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedIntColumn _duration;
  @override
  GeneratedIntColumn get duration => _duration ??= _constructDuration();
  GeneratedIntColumn _constructDuration() {
    return GeneratedIntColumn(
      'duration',
      $tableName,
      true,
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

  final VerificationMeta _discNumberMeta = const VerificationMeta('discNumber');
  GeneratedIntColumn _discNumber;
  @override
  GeneratedIntColumn get discNumber => _discNumber ??= _constructDiscNumber();
  GeneratedIntColumn _constructDiscNumber() {
    return GeneratedIntColumn(
      'disc_number',
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

  final VerificationMeta _blockedMeta = const VerificationMeta('blocked');
  GeneratedBoolColumn _blocked;
  @override
  GeneratedBoolColumn get blocked => _blocked ??= _constructBlocked();
  GeneratedBoolColumn _constructBlocked() {
    return GeneratedBoolColumn('blocked', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _presentMeta = const VerificationMeta('present');
  GeneratedBoolColumn _present;
  @override
  GeneratedBoolColumn get present => _present ??= _constructPresent();
  GeneratedBoolColumn _constructPresent() {
    return GeneratedBoolColumn('present', $tableName, false,
        defaultValue: const Constant(true));
  }

  final VerificationMeta _likeCountMeta = const VerificationMeta('likeCount');
  GeneratedIntColumn _likeCount;
  @override
  GeneratedIntColumn get likeCount => _likeCount ??= _constructLikeCount();
  GeneratedIntColumn _constructLikeCount() {
    return GeneratedIntColumn('like_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _skipCountMeta = const VerificationMeta('skipCount');
  GeneratedIntColumn _skipCount;
  @override
  GeneratedIntColumn get skipCount => _skipCount ??= _constructSkipCount();
  GeneratedIntColumn _constructSkipCount() {
    return GeneratedIntColumn('skip_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _playCountMeta = const VerificationMeta('playCount');
  GeneratedIntColumn _playCount;
  @override
  GeneratedIntColumn get playCount => _playCount ??= _constructPlayCount();
  GeneratedIntColumn _constructPlayCount() {
    return GeneratedIntColumn('play_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _previousMeta = const VerificationMeta('previous');
  GeneratedTextColumn _previous;
  @override
  GeneratedTextColumn get previous => _previous ??= _constructPrevious();
  GeneratedTextColumn _constructPrevious() {
    return GeneratedTextColumn(
      'previous',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nextMeta = const VerificationMeta('next');
  GeneratedTextColumn _next;
  @override
  GeneratedTextColumn get next => _next ??= _constructNext();
  GeneratedTextColumn _constructNext() {
    return GeneratedTextColumn(
      'next',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        title,
        albumTitle,
        albumId,
        artist,
        path,
        duration,
        albumArtPath,
        discNumber,
        trackNumber,
        blocked,
        present,
        likeCount,
        skipCount,
        playCount,
        previous,
        next
      ];
  @override
  $SongsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'songs';
  @override
  final String actualTableName = 'songs';
  @override
  VerificationContext validateIntegrity(Insertable<MoorSong> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('album_title')) {
      context.handle(
          _albumTitleMeta,
          albumTitle.isAcceptableOrUnknown(
              data['album_title'], _albumTitleMeta));
    } else if (isInserting) {
      context.missing(_albumTitleMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id'], _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist'], _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path'], _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    }
    if (data.containsKey('album_art_path')) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableOrUnknown(
              data['album_art_path'], _albumArtPathMeta));
    }
    if (data.containsKey('disc_number')) {
      context.handle(
          _discNumberMeta,
          discNumber.isAcceptableOrUnknown(
              data['disc_number'], _discNumberMeta));
    }
    if (data.containsKey('track_number')) {
      context.handle(
          _trackNumberMeta,
          trackNumber.isAcceptableOrUnknown(
              data['track_number'], _trackNumberMeta));
    }
    if (data.containsKey('blocked')) {
      context.handle(_blockedMeta,
          blocked.isAcceptableOrUnknown(data['blocked'], _blockedMeta));
    }
    if (data.containsKey('present')) {
      context.handle(_presentMeta,
          present.isAcceptableOrUnknown(data['present'], _presentMeta));
    }
    if (data.containsKey('like_count')) {
      context.handle(_likeCountMeta,
          likeCount.isAcceptableOrUnknown(data['like_count'], _likeCountMeta));
    }
    if (data.containsKey('skip_count')) {
      context.handle(_skipCountMeta,
          skipCount.isAcceptableOrUnknown(data['skip_count'], _skipCountMeta));
    }
    if (data.containsKey('play_count')) {
      context.handle(_playCountMeta,
          playCount.isAcceptableOrUnknown(data['play_count'], _playCountMeta));
    }
    if (data.containsKey('previous')) {
      context.handle(_previousMeta,
          previous.isAcceptableOrUnknown(data['previous'], _previousMeta));
    }
    if (data.containsKey('next')) {
      context.handle(
          _nextMeta, next.isAcceptableOrUnknown(data['next'], _nextMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  MoorSong map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorSong.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$MoorDatabase.connect(DatabaseConnection c) : super.connect(c);
  $AlbumsTable _albums;
  $AlbumsTable get albums => _albums ??= $AlbumsTable(this);
  $ArtistsTable _artists;
  $ArtistsTable get artists => _artists ??= $ArtistsTable(this);
  $LibraryFoldersTable _libraryFolders;
  $LibraryFoldersTable get libraryFolders =>
      _libraryFolders ??= $LibraryFoldersTable(this);
  $QueueEntriesTable _queueEntries;
  $QueueEntriesTable get queueEntries =>
      _queueEntries ??= $QueueEntriesTable(this);
  $PersistentIndexTable _persistentIndex;
  $PersistentIndexTable get persistentIndex =>
      _persistentIndex ??= $PersistentIndexTable(this);
  $PersistentLoopModeTable _persistentLoopMode;
  $PersistentLoopModeTable get persistentLoopMode =>
      _persistentLoopMode ??= $PersistentLoopModeTable(this);
  $PersistentShuffleModeTable _persistentShuffleMode;
  $PersistentShuffleModeTable get persistentShuffleMode =>
      _persistentShuffleMode ??= $PersistentShuffleModeTable(this);
  $SongsTable _songs;
  $SongsTable get songs => _songs ??= $SongsTable(this);
  PlayerStateDao _playerStateDao;
  PlayerStateDao get playerStateDao =>
      _playerStateDao ??= PlayerStateDao(this as MoorDatabase);
  SettingsDao _settingsDao;
  SettingsDao get settingsDao =>
      _settingsDao ??= SettingsDao(this as MoorDatabase);
  MusicDataDao _musicDataDao;
  MusicDataDao get musicDataDao =>
      _musicDataDao ??= MusicDataDao(this as MoorDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        albums,
        artists,
        libraryFolders,
        queueEntries,
        persistentIndex,
        persistentLoopMode,
        persistentShuffleMode,
        songs
      ];
}
