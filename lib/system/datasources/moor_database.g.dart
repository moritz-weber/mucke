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
  final String? albumArtPath;
  final int? year;
  MoorAlbum(
      {required this.id,
      required this.title,
      required this.artist,
      this.albumArtPath,
      this.year});
  factory MoorAlbum.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorAlbum(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      artist: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist'])!,
      albumArtPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    if (!nullToAbsent || albumArtPath != null) {
      map['album_art_path'] = Variable<String?>(albumArtPath);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int?>(year);
    }
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      albumArtPath: albumArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtPath),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
    );
  }

  factory MoorAlbum.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorAlbum(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      albumArtPath: serializer.fromJson<String?>(json['albumArtPath']),
      year: serializer.fromJson<int?>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'albumArtPath': serializer.toJson<String?>(albumArtPath),
      'year': serializer.toJson<int?>(year),
    };
  }

  MoorAlbum copyWith(
          {int? id,
          String? title,
          String? artist,
          String? albumArtPath,
          int? year}) =>
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
  bool operator ==(Object other) =>
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
  final Value<String?> albumArtPath;
  final Value<int?> year;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  });
  AlbumsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    this.albumArtPath = const Value.absent(),
    this.year = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist);
  static Insertable<MoorAlbum> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String?>? albumArtPath,
    Expression<int?>? year,
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
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String?>? albumArtPath,
      Value<int?>? year}) {
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
      map['album_art_path'] = Variable<String?>(albumArtPath.value);
    }
    if (year.present) {
      map['year'] = Variable<int?>(year.value);
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
  final String? _alias;
  $AlbumsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedTextColumn artist = _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn(
      'artist',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  @override
  late final GeneratedTextColumn albumArtPath = _constructAlbumArtPath();
  GeneratedTextColumn _constructAlbumArtPath() {
    return GeneratedTextColumn(
      'album_art_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedIntColumn year = _constructYear();
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
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album_art_path')) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableOrUnknown(
              data['album_art_path']!, _albumArtPathMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorAlbum map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorAlbum.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(_db, alias);
  }
}

class MoorArtist extends DataClass implements Insertable<MoorArtist> {
  final String name;
  MoorArtist({required this.name});
  factory MoorArtist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorArtist(
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      name: Value(name),
    );
  }

  factory MoorArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorArtist(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  MoorArtist copyWith({String? name}) => MoorArtist(
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('MoorArtist(')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(name.hashCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorArtist && other.name == this.name);
}

class ArtistsCompanion extends UpdateCompanion<MoorArtist> {
  final Value<String> name;
  const ArtistsCompanion({
    this.name = const Value.absent(),
  });
  ArtistsCompanion.insert({
    required String name,
  }) : name = Value(name);
  static Insertable<MoorArtist> custom({
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
    });
  }

  ArtistsCompanion copyWith({Value<String>? name}) {
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
    return (StringBuffer('ArtistsCompanion(')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, MoorArtist> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ArtistsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
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
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  MoorArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorArtist.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(_db, alias);
  }
}

class LibraryFolder extends DataClass implements Insertable<LibraryFolder> {
  final String path;
  LibraryFolder({required this.path});
  factory LibraryFolder.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LibraryFolder(
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['path'] = Variable<String>(path);
    return map;
  }

  LibraryFoldersCompanion toCompanion(bool nullToAbsent) {
    return LibraryFoldersCompanion(
      path: Value(path),
    );
  }

  factory LibraryFolder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LibraryFolder(
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
    };
  }

  LibraryFolder copyWith({String? path}) => LibraryFolder(
        path: path ?? this.path,
      );
  @override
  String toString() {
    return (StringBuffer('LibraryFolder(')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(path.hashCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryFolder && other.path == this.path);
}

class LibraryFoldersCompanion extends UpdateCompanion<LibraryFolder> {
  final Value<String> path;
  const LibraryFoldersCompanion({
    this.path = const Value.absent(),
  });
  LibraryFoldersCompanion.insert({
    required String path,
  }) : path = Value(path);
  static Insertable<LibraryFolder> custom({
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
    });
  }

  LibraryFoldersCompanion copyWith({Value<String>? path}) {
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
  final String? _alias;
  $LibraryFoldersTable(this._db, [this._alias]);
  final VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedTextColumn path = _constructPath();
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
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  LibraryFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LibraryFolder.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
  final bool isAvailable;
  MoorQueueEntry(
      {required this.index,
      required this.path,
      required this.originalIndex,
      required this.type,
      required this.isAvailable});
  factory MoorQueueEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorQueueEntry(
      index: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}index'])!,
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
      originalIndex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}original_index'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      isAvailable: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_available'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['path'] = Variable<String>(path);
    map['original_index'] = Variable<int>(originalIndex);
    map['type'] = Variable<int>(type);
    map['is_available'] = Variable<bool>(isAvailable);
    return map;
  }

  QueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return QueueEntriesCompanion(
      index: Value(index),
      path: Value(path),
      originalIndex: Value(originalIndex),
      type: Value(type),
      isAvailable: Value(isAvailable),
    );
  }

  factory MoorQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorQueueEntry(
      index: serializer.fromJson<int>(json['index']),
      path: serializer.fromJson<String>(json['path']),
      originalIndex: serializer.fromJson<int>(json['originalIndex']),
      type: serializer.fromJson<int>(json['type']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'path': serializer.toJson<String>(path),
      'originalIndex': serializer.toJson<int>(originalIndex),
      'type': serializer.toJson<int>(type),
      'isAvailable': serializer.toJson<bool>(isAvailable),
    };
  }

  MoorQueueEntry copyWith(
          {int? index,
          String? path,
          int? originalIndex,
          int? type,
          bool? isAvailable}) =>
      MoorQueueEntry(
        index: index ?? this.index,
        path: path ?? this.path,
        originalIndex: originalIndex ?? this.originalIndex,
        type: type ?? this.type,
        isAvailable: isAvailable ?? this.isAvailable,
      );
  @override
  String toString() {
    return (StringBuffer('MoorQueueEntry(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      index.hashCode,
      $mrjc(
          path.hashCode,
          $mrjc(originalIndex.hashCode,
              $mrjc(type.hashCode, isAvailable.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorQueueEntry &&
          other.index == this.index &&
          other.path == this.path &&
          other.originalIndex == this.originalIndex &&
          other.type == this.type &&
          other.isAvailable == this.isAvailable);
}

class QueueEntriesCompanion extends UpdateCompanion<MoorQueueEntry> {
  final Value<int> index;
  final Value<String> path;
  final Value<int> originalIndex;
  final Value<int> type;
  final Value<bool> isAvailable;
  const QueueEntriesCompanion({
    this.index = const Value.absent(),
    this.path = const Value.absent(),
    this.originalIndex = const Value.absent(),
    this.type = const Value.absent(),
    this.isAvailable = const Value.absent(),
  });
  QueueEntriesCompanion.insert({
    this.index = const Value.absent(),
    required String path,
    required int originalIndex,
    required int type,
    required bool isAvailable,
  })  : path = Value(path),
        originalIndex = Value(originalIndex),
        type = Value(type),
        isAvailable = Value(isAvailable);
  static Insertable<MoorQueueEntry> custom({
    Expression<int>? index,
    Expression<String>? path,
    Expression<int>? originalIndex,
    Expression<int>? type,
    Expression<bool>? isAvailable,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (path != null) 'path': path,
      if (originalIndex != null) 'original_index': originalIndex,
      if (type != null) 'type': type,
      if (isAvailable != null) 'is_available': isAvailable,
    });
  }

  QueueEntriesCompanion copyWith(
      {Value<int>? index,
      Value<String>? path,
      Value<int>? originalIndex,
      Value<int>? type,
      Value<bool>? isAvailable}) {
    return QueueEntriesCompanion(
      index: index ?? this.index,
      path: path ?? this.path,
      originalIndex: originalIndex ?? this.originalIndex,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
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
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueEntriesCompanion(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }
}

class $QueueEntriesTable extends QueueEntries
    with TableInfo<$QueueEntriesTable, MoorQueueEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $QueueEntriesTable(this._db, [this._alias]);
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedIntColumn index = _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedTextColumn path = _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn(
      'path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _originalIndexMeta =
      const VerificationMeta('originalIndex');
  @override
  late final GeneratedIntColumn originalIndex = _constructOriginalIndex();
  GeneratedIntColumn _constructOriginalIndex() {
    return GeneratedIntColumn(
      'original_index',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedIntColumn type = _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedBoolColumn isAvailable = _constructIsAvailable();
  GeneratedBoolColumn _constructIsAvailable() {
    return GeneratedBoolColumn(
      'is_available',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [index, path, originalIndex, type, isAvailable];
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
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('original_index')) {
      context.handle(
          _originalIndexMeta,
          originalIndex.isAcceptableOrUnknown(
              data['original_index']!, _originalIndexMeta));
    } else if (isInserting) {
      context.missing(_originalIndexMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['is_available']!, _isAvailableMeta));
    } else if (isInserting) {
      context.missing(_isAvailableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  MoorQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorQueueEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $QueueEntriesTable createAlias(String alias) {
    return $QueueEntriesTable(_db, alias);
  }
}

class AvailableSongEntry extends DataClass
    implements Insertable<AvailableSongEntry> {
  final int index;
  final String path;
  final int originalIndex;
  final int type;
  final bool isAvailable;
  AvailableSongEntry(
      {required this.index,
      required this.path,
      required this.originalIndex,
      required this.type,
      required this.isAvailable});
  factory AvailableSongEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AvailableSongEntry(
      index: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}index'])!,
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
      originalIndex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}original_index'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      isAvailable: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_available'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['path'] = Variable<String>(path);
    map['original_index'] = Variable<int>(originalIndex);
    map['type'] = Variable<int>(type);
    map['is_available'] = Variable<bool>(isAvailable);
    return map;
  }

  AvailableSongEntriesCompanion toCompanion(bool nullToAbsent) {
    return AvailableSongEntriesCompanion(
      index: Value(index),
      path: Value(path),
      originalIndex: Value(originalIndex),
      type: Value(type),
      isAvailable: Value(isAvailable),
    );
  }

  factory AvailableSongEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AvailableSongEntry(
      index: serializer.fromJson<int>(json['index']),
      path: serializer.fromJson<String>(json['path']),
      originalIndex: serializer.fromJson<int>(json['originalIndex']),
      type: serializer.fromJson<int>(json['type']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'path': serializer.toJson<String>(path),
      'originalIndex': serializer.toJson<int>(originalIndex),
      'type': serializer.toJson<int>(type),
      'isAvailable': serializer.toJson<bool>(isAvailable),
    };
  }

  AvailableSongEntry copyWith(
          {int? index,
          String? path,
          int? originalIndex,
          int? type,
          bool? isAvailable}) =>
      AvailableSongEntry(
        index: index ?? this.index,
        path: path ?? this.path,
        originalIndex: originalIndex ?? this.originalIndex,
        type: type ?? this.type,
        isAvailable: isAvailable ?? this.isAvailable,
      );
  @override
  String toString() {
    return (StringBuffer('AvailableSongEntry(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      index.hashCode,
      $mrjc(
          path.hashCode,
          $mrjc(originalIndex.hashCode,
              $mrjc(type.hashCode, isAvailable.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvailableSongEntry &&
          other.index == this.index &&
          other.path == this.path &&
          other.originalIndex == this.originalIndex &&
          other.type == this.type &&
          other.isAvailable == this.isAvailable);
}

class AvailableSongEntriesCompanion
    extends UpdateCompanion<AvailableSongEntry> {
  final Value<int> index;
  final Value<String> path;
  final Value<int> originalIndex;
  final Value<int> type;
  final Value<bool> isAvailable;
  const AvailableSongEntriesCompanion({
    this.index = const Value.absent(),
    this.path = const Value.absent(),
    this.originalIndex = const Value.absent(),
    this.type = const Value.absent(),
    this.isAvailable = const Value.absent(),
  });
  AvailableSongEntriesCompanion.insert({
    this.index = const Value.absent(),
    required String path,
    required int originalIndex,
    required int type,
    required bool isAvailable,
  })  : path = Value(path),
        originalIndex = Value(originalIndex),
        type = Value(type),
        isAvailable = Value(isAvailable);
  static Insertable<AvailableSongEntry> custom({
    Expression<int>? index,
    Expression<String>? path,
    Expression<int>? originalIndex,
    Expression<int>? type,
    Expression<bool>? isAvailable,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (path != null) 'path': path,
      if (originalIndex != null) 'original_index': originalIndex,
      if (type != null) 'type': type,
      if (isAvailable != null) 'is_available': isAvailable,
    });
  }

  AvailableSongEntriesCompanion copyWith(
      {Value<int>? index,
      Value<String>? path,
      Value<int>? originalIndex,
      Value<int>? type,
      Value<bool>? isAvailable}) {
    return AvailableSongEntriesCompanion(
      index: index ?? this.index,
      path: path ?? this.path,
      originalIndex: originalIndex ?? this.originalIndex,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
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
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvailableSongEntriesCompanion(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }
}

class $AvailableSongEntriesTable extends AvailableSongEntries
    with TableInfo<$AvailableSongEntriesTable, AvailableSongEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AvailableSongEntriesTable(this._db, [this._alias]);
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedIntColumn index = _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedTextColumn path = _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn(
      'path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _originalIndexMeta =
      const VerificationMeta('originalIndex');
  @override
  late final GeneratedIntColumn originalIndex = _constructOriginalIndex();
  GeneratedIntColumn _constructOriginalIndex() {
    return GeneratedIntColumn(
      'original_index',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedIntColumn type = _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedBoolColumn isAvailable = _constructIsAvailable();
  GeneratedBoolColumn _constructIsAvailable() {
    return GeneratedBoolColumn(
      'is_available',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [index, path, originalIndex, type, isAvailable];
  @override
  $AvailableSongEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'available_song_entries';
  @override
  final String actualTableName = 'available_song_entries';
  @override
  VerificationContext validateIntegrity(Insertable<AvailableSongEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('original_index')) {
      context.handle(
          _originalIndexMeta,
          originalIndex.isAcceptableOrUnknown(
              data['original_index']!, _originalIndexMeta));
    } else if (isInserting) {
      context.missing(_originalIndexMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['is_available']!, _isAvailableMeta));
    } else if (isInserting) {
      context.missing(_isAvailableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  AvailableSongEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AvailableSongEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AvailableSongEntriesTable createAlias(String alias) {
    return $AvailableSongEntriesTable(_db, alias);
  }
}

class MoorSong extends DataClass implements Insertable<MoorSong> {
  final String title;
  final String albumTitle;
  final int albumId;
  final String artist;
  final String path;
  final int duration;
  final String? albumArtPath;
  final int discNumber;
  final int trackNumber;
  final int? year;
  final int blockLevel;
  final int likeCount;
  final int skipCount;
  final int playCount;
  final bool present;
  final DateTime timeAdded;
  final String previous;
  final String next;
  MoorSong(
      {required this.title,
      required this.albumTitle,
      required this.albumId,
      required this.artist,
      required this.path,
      required this.duration,
      this.albumArtPath,
      required this.discNumber,
      required this.trackNumber,
      this.year,
      required this.blockLevel,
      required this.likeCount,
      required this.skipCount,
      required this.playCount,
      required this.present,
      required this.timeAdded,
      required this.previous,
      required this.next});
  factory MoorSong.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorSong(
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      albumTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_title'])!,
      albumId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_id'])!,
      artist: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist'])!,
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
      duration: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration'])!,
      albumArtPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_art_path']),
      discNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}disc_number'])!,
      trackNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_number'])!,
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      blockLevel: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}block_level'])!,
      likeCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}like_count'])!,
      skipCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}skip_count'])!,
      playCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}play_count'])!,
      present: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}present'])!,
      timeAdded: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_added'])!,
      previous: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}previous'])!,
      next: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}next'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['album_title'] = Variable<String>(albumTitle);
    map['album_id'] = Variable<int>(albumId);
    map['artist'] = Variable<String>(artist);
    map['path'] = Variable<String>(path);
    map['duration'] = Variable<int>(duration);
    if (!nullToAbsent || albumArtPath != null) {
      map['album_art_path'] = Variable<String?>(albumArtPath);
    }
    map['disc_number'] = Variable<int>(discNumber);
    map['track_number'] = Variable<int>(trackNumber);
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int?>(year);
    }
    map['block_level'] = Variable<int>(blockLevel);
    map['like_count'] = Variable<int>(likeCount);
    map['skip_count'] = Variable<int>(skipCount);
    map['play_count'] = Variable<int>(playCount);
    map['present'] = Variable<bool>(present);
    map['time_added'] = Variable<DateTime>(timeAdded);
    map['previous'] = Variable<String>(previous);
    map['next'] = Variable<String>(next);
    return map;
  }

  SongsCompanion toCompanion(bool nullToAbsent) {
    return SongsCompanion(
      title: Value(title),
      albumTitle: Value(albumTitle),
      albumId: Value(albumId),
      artist: Value(artist),
      path: Value(path),
      duration: Value(duration),
      albumArtPath: albumArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtPath),
      discNumber: Value(discNumber),
      trackNumber: Value(trackNumber),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      blockLevel: Value(blockLevel),
      likeCount: Value(likeCount),
      skipCount: Value(skipCount),
      playCount: Value(playCount),
      present: Value(present),
      timeAdded: Value(timeAdded),
      previous: Value(previous),
      next: Value(next),
    );
  }

  factory MoorSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorSong(
      title: serializer.fromJson<String>(json['title']),
      albumTitle: serializer.fromJson<String>(json['albumTitle']),
      albumId: serializer.fromJson<int>(json['albumId']),
      artist: serializer.fromJson<String>(json['artist']),
      path: serializer.fromJson<String>(json['path']),
      duration: serializer.fromJson<int>(json['duration']),
      albumArtPath: serializer.fromJson<String?>(json['albumArtPath']),
      discNumber: serializer.fromJson<int>(json['discNumber']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
      year: serializer.fromJson<int?>(json['year']),
      blockLevel: serializer.fromJson<int>(json['blockLevel']),
      likeCount: serializer.fromJson<int>(json['likeCount']),
      skipCount: serializer.fromJson<int>(json['skipCount']),
      playCount: serializer.fromJson<int>(json['playCount']),
      present: serializer.fromJson<bool>(json['present']),
      timeAdded: serializer.fromJson<DateTime>(json['timeAdded']),
      previous: serializer.fromJson<String>(json['previous']),
      next: serializer.fromJson<String>(json['next']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'albumTitle': serializer.toJson<String>(albumTitle),
      'albumId': serializer.toJson<int>(albumId),
      'artist': serializer.toJson<String>(artist),
      'path': serializer.toJson<String>(path),
      'duration': serializer.toJson<int>(duration),
      'albumArtPath': serializer.toJson<String?>(albumArtPath),
      'discNumber': serializer.toJson<int>(discNumber),
      'trackNumber': serializer.toJson<int>(trackNumber),
      'year': serializer.toJson<int?>(year),
      'blockLevel': serializer.toJson<int>(blockLevel),
      'likeCount': serializer.toJson<int>(likeCount),
      'skipCount': serializer.toJson<int>(skipCount),
      'playCount': serializer.toJson<int>(playCount),
      'present': serializer.toJson<bool>(present),
      'timeAdded': serializer.toJson<DateTime>(timeAdded),
      'previous': serializer.toJson<String>(previous),
      'next': serializer.toJson<String>(next),
    };
  }

  MoorSong copyWith(
          {String? title,
          String? albumTitle,
          int? albumId,
          String? artist,
          String? path,
          int? duration,
          String? albumArtPath,
          int? discNumber,
          int? trackNumber,
          int? year,
          int? blockLevel,
          int? likeCount,
          int? skipCount,
          int? playCount,
          bool? present,
          DateTime? timeAdded,
          String? previous,
          String? next}) =>
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
        year: year ?? this.year,
        blockLevel: blockLevel ?? this.blockLevel,
        likeCount: likeCount ?? this.likeCount,
        skipCount: skipCount ?? this.skipCount,
        playCount: playCount ?? this.playCount,
        present: present ?? this.present,
        timeAdded: timeAdded ?? this.timeAdded,
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
          ..write('year: $year, ')
          ..write('blockLevel: $blockLevel, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('present: $present, ')
          ..write('timeAdded: $timeAdded, ')
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
                                          year.hashCode,
                                          $mrjc(
                                              blockLevel.hashCode,
                                              $mrjc(
                                                  likeCount.hashCode,
                                                  $mrjc(
                                                      skipCount.hashCode,
                                                      $mrjc(
                                                          playCount.hashCode,
                                                          $mrjc(
                                                              present.hashCode,
                                                              $mrjc(
                                                                  timeAdded
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      previous
                                                                          .hashCode,
                                                                      next.hashCode))))))))))))))))));
  @override
  bool operator ==(Object other) =>
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
          other.year == this.year &&
          other.blockLevel == this.blockLevel &&
          other.likeCount == this.likeCount &&
          other.skipCount == this.skipCount &&
          other.playCount == this.playCount &&
          other.present == this.present &&
          other.timeAdded == this.timeAdded &&
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
  final Value<String?> albumArtPath;
  final Value<int> discNumber;
  final Value<int> trackNumber;
  final Value<int?> year;
  final Value<int> blockLevel;
  final Value<int> likeCount;
  final Value<int> skipCount;
  final Value<int> playCount;
  final Value<bool> present;
  final Value<DateTime> timeAdded;
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
    this.year = const Value.absent(),
    this.blockLevel = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.present = const Value.absent(),
    this.timeAdded = const Value.absent(),
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
  });
  SongsCompanion.insert({
    required String title,
    required String albumTitle,
    required int albumId,
    required String artist,
    required String path,
    required int duration,
    this.albumArtPath = const Value.absent(),
    required int discNumber,
    required int trackNumber,
    this.year = const Value.absent(),
    this.blockLevel = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.present = const Value.absent(),
    this.timeAdded = const Value.absent(),
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
  })  : title = Value(title),
        albumTitle = Value(albumTitle),
        albumId = Value(albumId),
        artist = Value(artist),
        path = Value(path),
        duration = Value(duration),
        discNumber = Value(discNumber),
        trackNumber = Value(trackNumber);
  static Insertable<MoorSong> custom({
    Expression<String>? title,
    Expression<String>? albumTitle,
    Expression<int>? albumId,
    Expression<String>? artist,
    Expression<String>? path,
    Expression<int>? duration,
    Expression<String?>? albumArtPath,
    Expression<int>? discNumber,
    Expression<int>? trackNumber,
    Expression<int?>? year,
    Expression<int>? blockLevel,
    Expression<int>? likeCount,
    Expression<int>? skipCount,
    Expression<int>? playCount,
    Expression<bool>? present,
    Expression<DateTime>? timeAdded,
    Expression<String>? previous,
    Expression<String>? next,
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
      if (year != null) 'year': year,
      if (blockLevel != null) 'block_level': blockLevel,
      if (likeCount != null) 'like_count': likeCount,
      if (skipCount != null) 'skip_count': skipCount,
      if (playCount != null) 'play_count': playCount,
      if (present != null) 'present': present,
      if (timeAdded != null) 'time_added': timeAdded,
      if (previous != null) 'previous': previous,
      if (next != null) 'next': next,
    });
  }

  SongsCompanion copyWith(
      {Value<String>? title,
      Value<String>? albumTitle,
      Value<int>? albumId,
      Value<String>? artist,
      Value<String>? path,
      Value<int>? duration,
      Value<String?>? albumArtPath,
      Value<int>? discNumber,
      Value<int>? trackNumber,
      Value<int?>? year,
      Value<int>? blockLevel,
      Value<int>? likeCount,
      Value<int>? skipCount,
      Value<int>? playCount,
      Value<bool>? present,
      Value<DateTime>? timeAdded,
      Value<String>? previous,
      Value<String>? next}) {
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
      year: year ?? this.year,
      blockLevel: blockLevel ?? this.blockLevel,
      likeCount: likeCount ?? this.likeCount,
      skipCount: skipCount ?? this.skipCount,
      playCount: playCount ?? this.playCount,
      present: present ?? this.present,
      timeAdded: timeAdded ?? this.timeAdded,
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
      map['album_art_path'] = Variable<String?>(albumArtPath.value);
    }
    if (discNumber.present) {
      map['disc_number'] = Variable<int>(discNumber.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (year.present) {
      map['year'] = Variable<int?>(year.value);
    }
    if (blockLevel.present) {
      map['block_level'] = Variable<int>(blockLevel.value);
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
    if (present.present) {
      map['present'] = Variable<bool>(present.value);
    }
    if (timeAdded.present) {
      map['time_added'] = Variable<DateTime>(timeAdded.value);
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
          ..write('year: $year, ')
          ..write('blockLevel: $blockLevel, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('present: $present, ')
          ..write('timeAdded: $timeAdded, ')
          ..write('previous: $previous, ')
          ..write('next: $next')
          ..write(')'))
        .toString();
  }
}

class $SongsTable extends Songs with TableInfo<$SongsTable, MoorSong> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SongsTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumTitleMeta = const VerificationMeta('albumTitle');
  @override
  late final GeneratedTextColumn albumTitle = _constructAlbumTitle();
  GeneratedTextColumn _constructAlbumTitle() {
    return GeneratedTextColumn(
      'album_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  @override
  late final GeneratedIntColumn albumId = _constructAlbumId();
  GeneratedIntColumn _constructAlbumId() {
    return GeneratedIntColumn(
      'album_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedTextColumn artist = _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn(
      'artist',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedTextColumn path = _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn(
      'path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedIntColumn duration = _constructDuration();
  GeneratedIntColumn _constructDuration() {
    return GeneratedIntColumn(
      'duration',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  @override
  late final GeneratedTextColumn albumArtPath = _constructAlbumArtPath();
  GeneratedTextColumn _constructAlbumArtPath() {
    return GeneratedTextColumn(
      'album_art_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _discNumberMeta = const VerificationMeta('discNumber');
  @override
  late final GeneratedIntColumn discNumber = _constructDiscNumber();
  GeneratedIntColumn _constructDiscNumber() {
    return GeneratedIntColumn(
      'disc_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _trackNumberMeta =
      const VerificationMeta('trackNumber');
  @override
  late final GeneratedIntColumn trackNumber = _constructTrackNumber();
  GeneratedIntColumn _constructTrackNumber() {
    return GeneratedIntColumn(
      'track_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedIntColumn year = _constructYear();
  GeneratedIntColumn _constructYear() {
    return GeneratedIntColumn(
      'year',
      $tableName,
      true,
    );
  }

  final VerificationMeta _blockLevelMeta = const VerificationMeta('blockLevel');
  @override
  late final GeneratedIntColumn blockLevel = _constructBlockLevel();
  GeneratedIntColumn _constructBlockLevel() {
    return GeneratedIntColumn('block_level', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _likeCountMeta = const VerificationMeta('likeCount');
  @override
  late final GeneratedIntColumn likeCount = _constructLikeCount();
  GeneratedIntColumn _constructLikeCount() {
    return GeneratedIntColumn('like_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _skipCountMeta = const VerificationMeta('skipCount');
  @override
  late final GeneratedIntColumn skipCount = _constructSkipCount();
  GeneratedIntColumn _constructSkipCount() {
    return GeneratedIntColumn('skip_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _playCountMeta = const VerificationMeta('playCount');
  @override
  late final GeneratedIntColumn playCount = _constructPlayCount();
  GeneratedIntColumn _constructPlayCount() {
    return GeneratedIntColumn('play_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _presentMeta = const VerificationMeta('present');
  @override
  late final GeneratedBoolColumn present = _constructPresent();
  GeneratedBoolColumn _constructPresent() {
    return GeneratedBoolColumn('present', $tableName, false,
        defaultValue: const Constant(true));
  }

  final VerificationMeta _timeAddedMeta = const VerificationMeta('timeAdded');
  @override
  late final GeneratedDateTimeColumn timeAdded = _constructTimeAdded();
  GeneratedDateTimeColumn _constructTimeAdded() {
    return GeneratedDateTimeColumn('time_added', $tableName, false,
        defaultValue: currentDateAndTime);
  }

  final VerificationMeta _previousMeta = const VerificationMeta('previous');
  @override
  late final GeneratedTextColumn previous = _constructPrevious();
  GeneratedTextColumn _constructPrevious() {
    return GeneratedTextColumn('previous', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _nextMeta = const VerificationMeta('next');
  @override
  late final GeneratedTextColumn next = _constructNext();
  GeneratedTextColumn _constructNext() {
    return GeneratedTextColumn('next', $tableName, false,
        defaultValue: const Constant(''));
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
        year,
        blockLevel,
        likeCount,
        skipCount,
        playCount,
        present,
        timeAdded,
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
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('album_title')) {
      context.handle(
          _albumTitleMeta,
          albumTitle.isAcceptableOrUnknown(
              data['album_title']!, _albumTitleMeta));
    } else if (isInserting) {
      context.missing(_albumTitleMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('album_art_path')) {
      context.handle(
          _albumArtPathMeta,
          albumArtPath.isAcceptableOrUnknown(
              data['album_art_path']!, _albumArtPathMeta));
    }
    if (data.containsKey('disc_number')) {
      context.handle(
          _discNumberMeta,
          discNumber.isAcceptableOrUnknown(
              data['disc_number']!, _discNumberMeta));
    } else if (isInserting) {
      context.missing(_discNumberMeta);
    }
    if (data.containsKey('track_number')) {
      context.handle(
          _trackNumberMeta,
          trackNumber.isAcceptableOrUnknown(
              data['track_number']!, _trackNumberMeta));
    } else if (isInserting) {
      context.missing(_trackNumberMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    if (data.containsKey('block_level')) {
      context.handle(
          _blockLevelMeta,
          blockLevel.isAcceptableOrUnknown(
              data['block_level']!, _blockLevelMeta));
    }
    if (data.containsKey('like_count')) {
      context.handle(_likeCountMeta,
          likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta));
    }
    if (data.containsKey('skip_count')) {
      context.handle(_skipCountMeta,
          skipCount.isAcceptableOrUnknown(data['skip_count']!, _skipCountMeta));
    }
    if (data.containsKey('play_count')) {
      context.handle(_playCountMeta,
          playCount.isAcceptableOrUnknown(data['play_count']!, _playCountMeta));
    }
    if (data.containsKey('present')) {
      context.handle(_presentMeta,
          present.isAcceptableOrUnknown(data['present']!, _presentMeta));
    }
    if (data.containsKey('time_added')) {
      context.handle(_timeAddedMeta,
          timeAdded.isAcceptableOrUnknown(data['time_added']!, _timeAddedMeta));
    }
    if (data.containsKey('previous')) {
      context.handle(_previousMeta,
          previous.isAcceptableOrUnknown(data['previous']!, _previousMeta));
    }
    if (data.containsKey('next')) {
      context.handle(
          _nextMeta, next.isAcceptableOrUnknown(data['next']!, _nextMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  MoorSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorSong.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(_db, alias);
  }
}

class MoorAlbumOfDayData extends DataClass
    implements Insertable<MoorAlbumOfDayData> {
  final int albumId;
  final int milliSecSinceEpoch;
  MoorAlbumOfDayData({required this.albumId, required this.milliSecSinceEpoch});
  factory MoorAlbumOfDayData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorAlbumOfDayData(
      albumId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_id'])!,
      milliSecSinceEpoch: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}milli_sec_since_epoch'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<int>(albumId);
    map['milli_sec_since_epoch'] = Variable<int>(milliSecSinceEpoch);
    return map;
  }

  MoorAlbumOfDayCompanion toCompanion(bool nullToAbsent) {
    return MoorAlbumOfDayCompanion(
      albumId: Value(albumId),
      milliSecSinceEpoch: Value(milliSecSinceEpoch),
    );
  }

  factory MoorAlbumOfDayData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorAlbumOfDayData(
      albumId: serializer.fromJson<int>(json['albumId']),
      milliSecSinceEpoch: serializer.fromJson<int>(json['milliSecSinceEpoch']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'albumId': serializer.toJson<int>(albumId),
      'milliSecSinceEpoch': serializer.toJson<int>(milliSecSinceEpoch),
    };
  }

  MoorAlbumOfDayData copyWith({int? albumId, int? milliSecSinceEpoch}) =>
      MoorAlbumOfDayData(
        albumId: albumId ?? this.albumId,
        milliSecSinceEpoch: milliSecSinceEpoch ?? this.milliSecSinceEpoch,
      );
  @override
  String toString() {
    return (StringBuffer('MoorAlbumOfDayData(')
          ..write('albumId: $albumId, ')
          ..write('milliSecSinceEpoch: $milliSecSinceEpoch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(albumId.hashCode, milliSecSinceEpoch.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorAlbumOfDayData &&
          other.albumId == this.albumId &&
          other.milliSecSinceEpoch == this.milliSecSinceEpoch);
}

class MoorAlbumOfDayCompanion extends UpdateCompanion<MoorAlbumOfDayData> {
  final Value<int> albumId;
  final Value<int> milliSecSinceEpoch;
  const MoorAlbumOfDayCompanion({
    this.albumId = const Value.absent(),
    this.milliSecSinceEpoch = const Value.absent(),
  });
  MoorAlbumOfDayCompanion.insert({
    this.albumId = const Value.absent(),
    required int milliSecSinceEpoch,
  }) : milliSecSinceEpoch = Value(milliSecSinceEpoch);
  static Insertable<MoorAlbumOfDayData> custom({
    Expression<int>? albumId,
    Expression<int>? milliSecSinceEpoch,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (milliSecSinceEpoch != null)
        'milli_sec_since_epoch': milliSecSinceEpoch,
    });
  }

  MoorAlbumOfDayCompanion copyWith(
      {Value<int>? albumId, Value<int>? milliSecSinceEpoch}) {
    return MoorAlbumOfDayCompanion(
      albumId: albumId ?? this.albumId,
      milliSecSinceEpoch: milliSecSinceEpoch ?? this.milliSecSinceEpoch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (milliSecSinceEpoch.present) {
      map['milli_sec_since_epoch'] = Variable<int>(milliSecSinceEpoch.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoorAlbumOfDayCompanion(')
          ..write('albumId: $albumId, ')
          ..write('milliSecSinceEpoch: $milliSecSinceEpoch')
          ..write(')'))
        .toString();
  }
}

class $MoorAlbumOfDayTable extends MoorAlbumOfDay
    with TableInfo<$MoorAlbumOfDayTable, MoorAlbumOfDayData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MoorAlbumOfDayTable(this._db, [this._alias]);
  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  @override
  late final GeneratedIntColumn albumId = _constructAlbumId();
  GeneratedIntColumn _constructAlbumId() {
    return GeneratedIntColumn(
      'album_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _milliSecSinceEpochMeta =
      const VerificationMeta('milliSecSinceEpoch');
  @override
  late final GeneratedIntColumn milliSecSinceEpoch =
      _constructMilliSecSinceEpoch();
  GeneratedIntColumn _constructMilliSecSinceEpoch() {
    return GeneratedIntColumn(
      'milli_sec_since_epoch',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [albumId, milliSecSinceEpoch];
  @override
  $MoorAlbumOfDayTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_album_of_day';
  @override
  final String actualTableName = 'moor_album_of_day';
  @override
  VerificationContext validateIntegrity(Insertable<MoorAlbumOfDayData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    }
    if (data.containsKey('milli_sec_since_epoch')) {
      context.handle(
          _milliSecSinceEpochMeta,
          milliSecSinceEpoch.isAcceptableOrUnknown(
              data['milli_sec_since_epoch']!, _milliSecSinceEpochMeta));
    } else if (isInserting) {
      context.missing(_milliSecSinceEpochMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId};
  @override
  MoorAlbumOfDayData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorAlbumOfDayData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MoorAlbumOfDayTable createAlias(String alias) {
    return $MoorAlbumOfDayTable(_db, alias);
  }
}

class MoorSmartList extends DataClass implements Insertable<MoorSmartList> {
  final int id;
  final String name;
  final String? shuffleMode;
  final bool excludeArtists;
  final bool excludeBlocked;
  final int minLikeCount;
  final int maxLikeCount;
  final int? minPlayCount;
  final int? maxPlayCount;
  final int? minSkipCount;
  final int? maxSkipCount;
  final int? minYear;
  final int? maxYear;
  final int? limit;
  final String orderCriteria;
  final String orderDirections;
  MoorSmartList(
      {required this.id,
      required this.name,
      this.shuffleMode,
      required this.excludeArtists,
      required this.excludeBlocked,
      required this.minLikeCount,
      required this.maxLikeCount,
      this.minPlayCount,
      this.maxPlayCount,
      this.minSkipCount,
      this.maxSkipCount,
      this.minYear,
      this.maxYear,
      this.limit,
      required this.orderCriteria,
      required this.orderDirections});
  factory MoorSmartList.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorSmartList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      shuffleMode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}shuffle_mode']),
      excludeArtists: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exclude_artists'])!,
      excludeBlocked: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exclude_blocked'])!,
      minLikeCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_like_count'])!,
      maxLikeCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_like_count'])!,
      minPlayCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_play_count']),
      maxPlayCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_play_count']),
      minSkipCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_skip_count']),
      maxSkipCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_skip_count']),
      minYear: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_year']),
      maxYear: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_year']),
      limit: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}limit']),
      orderCriteria: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_criteria'])!,
      orderDirections: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_directions'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || shuffleMode != null) {
      map['shuffle_mode'] = Variable<String?>(shuffleMode);
    }
    map['exclude_artists'] = Variable<bool>(excludeArtists);
    map['exclude_blocked'] = Variable<bool>(excludeBlocked);
    map['min_like_count'] = Variable<int>(minLikeCount);
    map['max_like_count'] = Variable<int>(maxLikeCount);
    if (!nullToAbsent || minPlayCount != null) {
      map['min_play_count'] = Variable<int?>(minPlayCount);
    }
    if (!nullToAbsent || maxPlayCount != null) {
      map['max_play_count'] = Variable<int?>(maxPlayCount);
    }
    if (!nullToAbsent || minSkipCount != null) {
      map['min_skip_count'] = Variable<int?>(minSkipCount);
    }
    if (!nullToAbsent || maxSkipCount != null) {
      map['max_skip_count'] = Variable<int?>(maxSkipCount);
    }
    if (!nullToAbsent || minYear != null) {
      map['min_year'] = Variable<int?>(minYear);
    }
    if (!nullToAbsent || maxYear != null) {
      map['max_year'] = Variable<int?>(maxYear);
    }
    if (!nullToAbsent || limit != null) {
      map['limit'] = Variable<int?>(limit);
    }
    map['order_criteria'] = Variable<String>(orderCriteria);
    map['order_directions'] = Variable<String>(orderDirections);
    return map;
  }

  SmartListsCompanion toCompanion(bool nullToAbsent) {
    return SmartListsCompanion(
      id: Value(id),
      name: Value(name),
      shuffleMode: shuffleMode == null && nullToAbsent
          ? const Value.absent()
          : Value(shuffleMode),
      excludeArtists: Value(excludeArtists),
      excludeBlocked: Value(excludeBlocked),
      minLikeCount: Value(minLikeCount),
      maxLikeCount: Value(maxLikeCount),
      minPlayCount: minPlayCount == null && nullToAbsent
          ? const Value.absent()
          : Value(minPlayCount),
      maxPlayCount: maxPlayCount == null && nullToAbsent
          ? const Value.absent()
          : Value(maxPlayCount),
      minSkipCount: minSkipCount == null && nullToAbsent
          ? const Value.absent()
          : Value(minSkipCount),
      maxSkipCount: maxSkipCount == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSkipCount),
      minYear: minYear == null && nullToAbsent
          ? const Value.absent()
          : Value(minYear),
      maxYear: maxYear == null && nullToAbsent
          ? const Value.absent()
          : Value(maxYear),
      limit:
          limit == null && nullToAbsent ? const Value.absent() : Value(limit),
      orderCriteria: Value(orderCriteria),
      orderDirections: Value(orderDirections),
    );
  }

  factory MoorSmartList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorSmartList(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shuffleMode: serializer.fromJson<String?>(json['shuffleMode']),
      excludeArtists: serializer.fromJson<bool>(json['excludeArtists']),
      excludeBlocked: serializer.fromJson<bool>(json['excludeBlocked']),
      minLikeCount: serializer.fromJson<int>(json['minLikeCount']),
      maxLikeCount: serializer.fromJson<int>(json['maxLikeCount']),
      minPlayCount: serializer.fromJson<int?>(json['minPlayCount']),
      maxPlayCount: serializer.fromJson<int?>(json['maxPlayCount']),
      minSkipCount: serializer.fromJson<int?>(json['minSkipCount']),
      maxSkipCount: serializer.fromJson<int?>(json['maxSkipCount']),
      minYear: serializer.fromJson<int?>(json['minYear']),
      maxYear: serializer.fromJson<int?>(json['maxYear']),
      limit: serializer.fromJson<int?>(json['limit']),
      orderCriteria: serializer.fromJson<String>(json['orderCriteria']),
      orderDirections: serializer.fromJson<String>(json['orderDirections']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'shuffleMode': serializer.toJson<String?>(shuffleMode),
      'excludeArtists': serializer.toJson<bool>(excludeArtists),
      'excludeBlocked': serializer.toJson<bool>(excludeBlocked),
      'minLikeCount': serializer.toJson<int>(minLikeCount),
      'maxLikeCount': serializer.toJson<int>(maxLikeCount),
      'minPlayCount': serializer.toJson<int?>(minPlayCount),
      'maxPlayCount': serializer.toJson<int?>(maxPlayCount),
      'minSkipCount': serializer.toJson<int?>(minSkipCount),
      'maxSkipCount': serializer.toJson<int?>(maxSkipCount),
      'minYear': serializer.toJson<int?>(minYear),
      'maxYear': serializer.toJson<int?>(maxYear),
      'limit': serializer.toJson<int?>(limit),
      'orderCriteria': serializer.toJson<String>(orderCriteria),
      'orderDirections': serializer.toJson<String>(orderDirections),
    };
  }

  MoorSmartList copyWith(
          {int? id,
          String? name,
          String? shuffleMode,
          bool? excludeArtists,
          bool? excludeBlocked,
          int? minLikeCount,
          int? maxLikeCount,
          int? minPlayCount,
          int? maxPlayCount,
          int? minSkipCount,
          int? maxSkipCount,
          int? minYear,
          int? maxYear,
          int? limit,
          String? orderCriteria,
          String? orderDirections}) =>
      MoorSmartList(
        id: id ?? this.id,
        name: name ?? this.name,
        shuffleMode: shuffleMode ?? this.shuffleMode,
        excludeArtists: excludeArtists ?? this.excludeArtists,
        excludeBlocked: excludeBlocked ?? this.excludeBlocked,
        minLikeCount: minLikeCount ?? this.minLikeCount,
        maxLikeCount: maxLikeCount ?? this.maxLikeCount,
        minPlayCount: minPlayCount ?? this.minPlayCount,
        maxPlayCount: maxPlayCount ?? this.maxPlayCount,
        minSkipCount: minSkipCount ?? this.minSkipCount,
        maxSkipCount: maxSkipCount ?? this.maxSkipCount,
        minYear: minYear ?? this.minYear,
        maxYear: maxYear ?? this.maxYear,
        limit: limit ?? this.limit,
        orderCriteria: orderCriteria ?? this.orderCriteria,
        orderDirections: orderDirections ?? this.orderDirections,
      );
  @override
  String toString() {
    return (StringBuffer('MoorSmartList(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shuffleMode: $shuffleMode, ')
          ..write('excludeArtists: $excludeArtists, ')
          ..write('excludeBlocked: $excludeBlocked, ')
          ..write('minLikeCount: $minLikeCount, ')
          ..write('maxLikeCount: $maxLikeCount, ')
          ..write('minPlayCount: $minPlayCount, ')
          ..write('maxPlayCount: $maxPlayCount, ')
          ..write('minSkipCount: $minSkipCount, ')
          ..write('maxSkipCount: $maxSkipCount, ')
          ..write('minYear: $minYear, ')
          ..write('maxYear: $maxYear, ')
          ..write('limit: $limit, ')
          ..write('orderCriteria: $orderCriteria, ')
          ..write('orderDirections: $orderDirections')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              shuffleMode.hashCode,
              $mrjc(
                  excludeArtists.hashCode,
                  $mrjc(
                      excludeBlocked.hashCode,
                      $mrjc(
                          minLikeCount.hashCode,
                          $mrjc(
                              maxLikeCount.hashCode,
                              $mrjc(
                                  minPlayCount.hashCode,
                                  $mrjc(
                                      maxPlayCount.hashCode,
                                      $mrjc(
                                          minSkipCount.hashCode,
                                          $mrjc(
                                              maxSkipCount.hashCode,
                                              $mrjc(
                                                  minYear.hashCode,
                                                  $mrjc(
                                                      maxYear.hashCode,
                                                      $mrjc(
                                                          limit.hashCode,
                                                          $mrjc(
                                                              orderCriteria
                                                                  .hashCode,
                                                              orderDirections
                                                                  .hashCode))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorSmartList &&
          other.id == this.id &&
          other.name == this.name &&
          other.shuffleMode == this.shuffleMode &&
          other.excludeArtists == this.excludeArtists &&
          other.excludeBlocked == this.excludeBlocked &&
          other.minLikeCount == this.minLikeCount &&
          other.maxLikeCount == this.maxLikeCount &&
          other.minPlayCount == this.minPlayCount &&
          other.maxPlayCount == this.maxPlayCount &&
          other.minSkipCount == this.minSkipCount &&
          other.maxSkipCount == this.maxSkipCount &&
          other.minYear == this.minYear &&
          other.maxYear == this.maxYear &&
          other.limit == this.limit &&
          other.orderCriteria == this.orderCriteria &&
          other.orderDirections == this.orderDirections);
}

class SmartListsCompanion extends UpdateCompanion<MoorSmartList> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> shuffleMode;
  final Value<bool> excludeArtists;
  final Value<bool> excludeBlocked;
  final Value<int> minLikeCount;
  final Value<int> maxLikeCount;
  final Value<int?> minPlayCount;
  final Value<int?> maxPlayCount;
  final Value<int?> minSkipCount;
  final Value<int?> maxSkipCount;
  final Value<int?> minYear;
  final Value<int?> maxYear;
  final Value<int?> limit;
  final Value<String> orderCriteria;
  final Value<String> orderDirections;
  const SmartListsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shuffleMode = const Value.absent(),
    this.excludeArtists = const Value.absent(),
    this.excludeBlocked = const Value.absent(),
    this.minLikeCount = const Value.absent(),
    this.maxLikeCount = const Value.absent(),
    this.minPlayCount = const Value.absent(),
    this.maxPlayCount = const Value.absent(),
    this.minSkipCount = const Value.absent(),
    this.maxSkipCount = const Value.absent(),
    this.minYear = const Value.absent(),
    this.maxYear = const Value.absent(),
    this.limit = const Value.absent(),
    this.orderCriteria = const Value.absent(),
    this.orderDirections = const Value.absent(),
  });
  SmartListsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.shuffleMode = const Value.absent(),
    this.excludeArtists = const Value.absent(),
    this.excludeBlocked = const Value.absent(),
    this.minLikeCount = const Value.absent(),
    this.maxLikeCount = const Value.absent(),
    this.minPlayCount = const Value.absent(),
    this.maxPlayCount = const Value.absent(),
    this.minSkipCount = const Value.absent(),
    this.maxSkipCount = const Value.absent(),
    this.minYear = const Value.absent(),
    this.maxYear = const Value.absent(),
    this.limit = const Value.absent(),
    required String orderCriteria,
    required String orderDirections,
  })  : name = Value(name),
        orderCriteria = Value(orderCriteria),
        orderDirections = Value(orderDirections);
  static Insertable<MoorSmartList> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String?>? shuffleMode,
    Expression<bool>? excludeArtists,
    Expression<bool>? excludeBlocked,
    Expression<int>? minLikeCount,
    Expression<int>? maxLikeCount,
    Expression<int?>? minPlayCount,
    Expression<int?>? maxPlayCount,
    Expression<int?>? minSkipCount,
    Expression<int?>? maxSkipCount,
    Expression<int?>? minYear,
    Expression<int?>? maxYear,
    Expression<int?>? limit,
    Expression<String>? orderCriteria,
    Expression<String>? orderDirections,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shuffleMode != null) 'shuffle_mode': shuffleMode,
      if (excludeArtists != null) 'exclude_artists': excludeArtists,
      if (excludeBlocked != null) 'exclude_blocked': excludeBlocked,
      if (minLikeCount != null) 'min_like_count': minLikeCount,
      if (maxLikeCount != null) 'max_like_count': maxLikeCount,
      if (minPlayCount != null) 'min_play_count': minPlayCount,
      if (maxPlayCount != null) 'max_play_count': maxPlayCount,
      if (minSkipCount != null) 'min_skip_count': minSkipCount,
      if (maxSkipCount != null) 'max_skip_count': maxSkipCount,
      if (minYear != null) 'min_year': minYear,
      if (maxYear != null) 'max_year': maxYear,
      if (limit != null) 'limit': limit,
      if (orderCriteria != null) 'order_criteria': orderCriteria,
      if (orderDirections != null) 'order_directions': orderDirections,
    });
  }

  SmartListsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? shuffleMode,
      Value<bool>? excludeArtists,
      Value<bool>? excludeBlocked,
      Value<int>? minLikeCount,
      Value<int>? maxLikeCount,
      Value<int?>? minPlayCount,
      Value<int?>? maxPlayCount,
      Value<int?>? minSkipCount,
      Value<int?>? maxSkipCount,
      Value<int?>? minYear,
      Value<int?>? maxYear,
      Value<int?>? limit,
      Value<String>? orderCriteria,
      Value<String>? orderDirections}) {
    return SmartListsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shuffleMode: shuffleMode ?? this.shuffleMode,
      excludeArtists: excludeArtists ?? this.excludeArtists,
      excludeBlocked: excludeBlocked ?? this.excludeBlocked,
      minLikeCount: minLikeCount ?? this.minLikeCount,
      maxLikeCount: maxLikeCount ?? this.maxLikeCount,
      minPlayCount: minPlayCount ?? this.minPlayCount,
      maxPlayCount: maxPlayCount ?? this.maxPlayCount,
      minSkipCount: minSkipCount ?? this.minSkipCount,
      maxSkipCount: maxSkipCount ?? this.maxSkipCount,
      minYear: minYear ?? this.minYear,
      maxYear: maxYear ?? this.maxYear,
      limit: limit ?? this.limit,
      orderCriteria: orderCriteria ?? this.orderCriteria,
      orderDirections: orderDirections ?? this.orderDirections,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shuffleMode.present) {
      map['shuffle_mode'] = Variable<String?>(shuffleMode.value);
    }
    if (excludeArtists.present) {
      map['exclude_artists'] = Variable<bool>(excludeArtists.value);
    }
    if (excludeBlocked.present) {
      map['exclude_blocked'] = Variable<bool>(excludeBlocked.value);
    }
    if (minLikeCount.present) {
      map['min_like_count'] = Variable<int>(minLikeCount.value);
    }
    if (maxLikeCount.present) {
      map['max_like_count'] = Variable<int>(maxLikeCount.value);
    }
    if (minPlayCount.present) {
      map['min_play_count'] = Variable<int?>(minPlayCount.value);
    }
    if (maxPlayCount.present) {
      map['max_play_count'] = Variable<int?>(maxPlayCount.value);
    }
    if (minSkipCount.present) {
      map['min_skip_count'] = Variable<int?>(minSkipCount.value);
    }
    if (maxSkipCount.present) {
      map['max_skip_count'] = Variable<int?>(maxSkipCount.value);
    }
    if (minYear.present) {
      map['min_year'] = Variable<int?>(minYear.value);
    }
    if (maxYear.present) {
      map['max_year'] = Variable<int?>(maxYear.value);
    }
    if (limit.present) {
      map['limit'] = Variable<int?>(limit.value);
    }
    if (orderCriteria.present) {
      map['order_criteria'] = Variable<String>(orderCriteria.value);
    }
    if (orderDirections.present) {
      map['order_directions'] = Variable<String>(orderDirections.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartListsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shuffleMode: $shuffleMode, ')
          ..write('excludeArtists: $excludeArtists, ')
          ..write('excludeBlocked: $excludeBlocked, ')
          ..write('minLikeCount: $minLikeCount, ')
          ..write('maxLikeCount: $maxLikeCount, ')
          ..write('minPlayCount: $minPlayCount, ')
          ..write('maxPlayCount: $maxPlayCount, ')
          ..write('minSkipCount: $minSkipCount, ')
          ..write('maxSkipCount: $maxSkipCount, ')
          ..write('minYear: $minYear, ')
          ..write('maxYear: $maxYear, ')
          ..write('limit: $limit, ')
          ..write('orderCriteria: $orderCriteria, ')
          ..write('orderDirections: $orderDirections')
          ..write(')'))
        .toString();
  }
}

class $SmartListsTable extends SmartLists
    with TableInfo<$SmartListsTable, MoorSmartList> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SmartListsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _shuffleModeMeta =
      const VerificationMeta('shuffleMode');
  @override
  late final GeneratedTextColumn shuffleMode = _constructShuffleMode();
  GeneratedTextColumn _constructShuffleMode() {
    return GeneratedTextColumn(
      'shuffle_mode',
      $tableName,
      true,
    );
  }

  final VerificationMeta _excludeArtistsMeta =
      const VerificationMeta('excludeArtists');
  @override
  late final GeneratedBoolColumn excludeArtists = _constructExcludeArtists();
  GeneratedBoolColumn _constructExcludeArtists() {
    return GeneratedBoolColumn('exclude_artists', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _excludeBlockedMeta =
      const VerificationMeta('excludeBlocked');
  @override
  late final GeneratedBoolColumn excludeBlocked = _constructExcludeBlocked();
  GeneratedBoolColumn _constructExcludeBlocked() {
    return GeneratedBoolColumn('exclude_blocked', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _minLikeCountMeta =
      const VerificationMeta('minLikeCount');
  @override
  late final GeneratedIntColumn minLikeCount = _constructMinLikeCount();
  GeneratedIntColumn _constructMinLikeCount() {
    return GeneratedIntColumn('min_like_count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _maxLikeCountMeta =
      const VerificationMeta('maxLikeCount');
  @override
  late final GeneratedIntColumn maxLikeCount = _constructMaxLikeCount();
  GeneratedIntColumn _constructMaxLikeCount() {
    return GeneratedIntColumn('max_like_count', $tableName, false,
        defaultValue: const Constant(5));
  }

  final VerificationMeta _minPlayCountMeta =
      const VerificationMeta('minPlayCount');
  @override
  late final GeneratedIntColumn minPlayCount = _constructMinPlayCount();
  GeneratedIntColumn _constructMinPlayCount() {
    return GeneratedIntColumn(
      'min_play_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _maxPlayCountMeta =
      const VerificationMeta('maxPlayCount');
  @override
  late final GeneratedIntColumn maxPlayCount = _constructMaxPlayCount();
  GeneratedIntColumn _constructMaxPlayCount() {
    return GeneratedIntColumn(
      'max_play_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _minSkipCountMeta =
      const VerificationMeta('minSkipCount');
  @override
  late final GeneratedIntColumn minSkipCount = _constructMinSkipCount();
  GeneratedIntColumn _constructMinSkipCount() {
    return GeneratedIntColumn(
      'min_skip_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _maxSkipCountMeta =
      const VerificationMeta('maxSkipCount');
  @override
  late final GeneratedIntColumn maxSkipCount = _constructMaxSkipCount();
  GeneratedIntColumn _constructMaxSkipCount() {
    return GeneratedIntColumn(
      'max_skip_count',
      $tableName,
      true,
    );
  }

  final VerificationMeta _minYearMeta = const VerificationMeta('minYear');
  @override
  late final GeneratedIntColumn minYear = _constructMinYear();
  GeneratedIntColumn _constructMinYear() {
    return GeneratedIntColumn(
      'min_year',
      $tableName,
      true,
    );
  }

  final VerificationMeta _maxYearMeta = const VerificationMeta('maxYear');
  @override
  late final GeneratedIntColumn maxYear = _constructMaxYear();
  GeneratedIntColumn _constructMaxYear() {
    return GeneratedIntColumn(
      'max_year',
      $tableName,
      true,
    );
  }

  final VerificationMeta _limitMeta = const VerificationMeta('limit');
  @override
  late final GeneratedIntColumn limit = _constructLimit();
  GeneratedIntColumn _constructLimit() {
    return GeneratedIntColumn(
      'limit',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orderCriteriaMeta =
      const VerificationMeta('orderCriteria');
  @override
  late final GeneratedTextColumn orderCriteria = _constructOrderCriteria();
  GeneratedTextColumn _constructOrderCriteria() {
    return GeneratedTextColumn(
      'order_criteria',
      $tableName,
      false,
    );
  }

  final VerificationMeta _orderDirectionsMeta =
      const VerificationMeta('orderDirections');
  @override
  late final GeneratedTextColumn orderDirections = _constructOrderDirections();
  GeneratedTextColumn _constructOrderDirections() {
    return GeneratedTextColumn(
      'order_directions',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        shuffleMode,
        excludeArtists,
        excludeBlocked,
        minLikeCount,
        maxLikeCount,
        minPlayCount,
        maxPlayCount,
        minSkipCount,
        maxSkipCount,
        minYear,
        maxYear,
        limit,
        orderCriteria,
        orderDirections
      ];
  @override
  $SmartListsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'smart_lists';
  @override
  final String actualTableName = 'smart_lists';
  @override
  VerificationContext validateIntegrity(Insertable<MoorSmartList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('shuffle_mode')) {
      context.handle(
          _shuffleModeMeta,
          shuffleMode.isAcceptableOrUnknown(
              data['shuffle_mode']!, _shuffleModeMeta));
    }
    if (data.containsKey('exclude_artists')) {
      context.handle(
          _excludeArtistsMeta,
          excludeArtists.isAcceptableOrUnknown(
              data['exclude_artists']!, _excludeArtistsMeta));
    }
    if (data.containsKey('exclude_blocked')) {
      context.handle(
          _excludeBlockedMeta,
          excludeBlocked.isAcceptableOrUnknown(
              data['exclude_blocked']!, _excludeBlockedMeta));
    }
    if (data.containsKey('min_like_count')) {
      context.handle(
          _minLikeCountMeta,
          minLikeCount.isAcceptableOrUnknown(
              data['min_like_count']!, _minLikeCountMeta));
    }
    if (data.containsKey('max_like_count')) {
      context.handle(
          _maxLikeCountMeta,
          maxLikeCount.isAcceptableOrUnknown(
              data['max_like_count']!, _maxLikeCountMeta));
    }
    if (data.containsKey('min_play_count')) {
      context.handle(
          _minPlayCountMeta,
          minPlayCount.isAcceptableOrUnknown(
              data['min_play_count']!, _minPlayCountMeta));
    }
    if (data.containsKey('max_play_count')) {
      context.handle(
          _maxPlayCountMeta,
          maxPlayCount.isAcceptableOrUnknown(
              data['max_play_count']!, _maxPlayCountMeta));
    }
    if (data.containsKey('min_skip_count')) {
      context.handle(
          _minSkipCountMeta,
          minSkipCount.isAcceptableOrUnknown(
              data['min_skip_count']!, _minSkipCountMeta));
    }
    if (data.containsKey('max_skip_count')) {
      context.handle(
          _maxSkipCountMeta,
          maxSkipCount.isAcceptableOrUnknown(
              data['max_skip_count']!, _maxSkipCountMeta));
    }
    if (data.containsKey('min_year')) {
      context.handle(_minYearMeta,
          minYear.isAcceptableOrUnknown(data['min_year']!, _minYearMeta));
    }
    if (data.containsKey('max_year')) {
      context.handle(_maxYearMeta,
          maxYear.isAcceptableOrUnknown(data['max_year']!, _maxYearMeta));
    }
    if (data.containsKey('limit')) {
      context.handle(
          _limitMeta, limit.isAcceptableOrUnknown(data['limit']!, _limitMeta));
    }
    if (data.containsKey('order_criteria')) {
      context.handle(
          _orderCriteriaMeta,
          orderCriteria.isAcceptableOrUnknown(
              data['order_criteria']!, _orderCriteriaMeta));
    } else if (isInserting) {
      context.missing(_orderCriteriaMeta);
    }
    if (data.containsKey('order_directions')) {
      context.handle(
          _orderDirectionsMeta,
          orderDirections.isAcceptableOrUnknown(
              data['order_directions']!, _orderDirectionsMeta));
    } else if (isInserting) {
      context.missing(_orderDirectionsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorSmartList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorSmartList.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SmartListsTable createAlias(String alias) {
    return $SmartListsTable(_db, alias);
  }
}

class MoorSmartListArtist extends DataClass
    implements Insertable<MoorSmartListArtist> {
  final int smartListId;
  final String artistName;
  MoorSmartListArtist({required this.smartListId, required this.artistName});
  factory MoorSmartListArtist.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorSmartListArtist(
      smartListId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}smart_list_id'])!,
      artistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['smart_list_id'] = Variable<int>(smartListId);
    map['artist_name'] = Variable<String>(artistName);
    return map;
  }

  SmartListArtistsCompanion toCompanion(bool nullToAbsent) {
    return SmartListArtistsCompanion(
      smartListId: Value(smartListId),
      artistName: Value(artistName),
    );
  }

  factory MoorSmartListArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorSmartListArtist(
      smartListId: serializer.fromJson<int>(json['smartListId']),
      artistName: serializer.fromJson<String>(json['artistName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'smartListId': serializer.toJson<int>(smartListId),
      'artistName': serializer.toJson<String>(artistName),
    };
  }

  MoorSmartListArtist copyWith({int? smartListId, String? artistName}) =>
      MoorSmartListArtist(
        smartListId: smartListId ?? this.smartListId,
        artistName: artistName ?? this.artistName,
      );
  @override
  String toString() {
    return (StringBuffer('MoorSmartListArtist(')
          ..write('smartListId: $smartListId, ')
          ..write('artistName: $artistName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(smartListId.hashCode, artistName.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorSmartListArtist &&
          other.smartListId == this.smartListId &&
          other.artistName == this.artistName);
}

class SmartListArtistsCompanion extends UpdateCompanion<MoorSmartListArtist> {
  final Value<int> smartListId;
  final Value<String> artistName;
  const SmartListArtistsCompanion({
    this.smartListId = const Value.absent(),
    this.artistName = const Value.absent(),
  });
  SmartListArtistsCompanion.insert({
    required int smartListId,
    required String artistName,
  })  : smartListId = Value(smartListId),
        artistName = Value(artistName);
  static Insertable<MoorSmartListArtist> custom({
    Expression<int>? smartListId,
    Expression<String>? artistName,
  }) {
    return RawValuesInsertable({
      if (smartListId != null) 'smart_list_id': smartListId,
      if (artistName != null) 'artist_name': artistName,
    });
  }

  SmartListArtistsCompanion copyWith(
      {Value<int>? smartListId, Value<String>? artistName}) {
    return SmartListArtistsCompanion(
      smartListId: smartListId ?? this.smartListId,
      artistName: artistName ?? this.artistName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (smartListId.present) {
      map['smart_list_id'] = Variable<int>(smartListId.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String>(artistName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartListArtistsCompanion(')
          ..write('smartListId: $smartListId, ')
          ..write('artistName: $artistName')
          ..write(')'))
        .toString();
  }
}

class $SmartListArtistsTable extends SmartListArtists
    with TableInfo<$SmartListArtistsTable, MoorSmartListArtist> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SmartListArtistsTable(this._db, [this._alias]);
  final VerificationMeta _smartListIdMeta =
      const VerificationMeta('smartListId');
  @override
  late final GeneratedIntColumn smartListId = _constructSmartListId();
  GeneratedIntColumn _constructSmartListId() {
    return GeneratedIntColumn(
      'smart_list_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistNameMeta = const VerificationMeta('artistName');
  @override
  late final GeneratedTextColumn artistName = _constructArtistName();
  GeneratedTextColumn _constructArtistName() {
    return GeneratedTextColumn(
      'artist_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [smartListId, artistName];
  @override
  $SmartListArtistsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'smart_list_artists';
  @override
  final String actualTableName = 'smart_list_artists';
  @override
  VerificationContext validateIntegrity(
      Insertable<MoorSmartListArtist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('smart_list_id')) {
      context.handle(
          _smartListIdMeta,
          smartListId.isAcceptableOrUnknown(
              data['smart_list_id']!, _smartListIdMeta));
    } else if (isInserting) {
      context.missing(_smartListIdMeta);
    }
    if (data.containsKey('artist_name')) {
      context.handle(
          _artistNameMeta,
          artistName.isAcceptableOrUnknown(
              data['artist_name']!, _artistNameMeta));
    } else if (isInserting) {
      context.missing(_artistNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  MoorSmartListArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorSmartListArtist.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SmartListArtistsTable createAlias(String alias) {
    return $SmartListArtistsTable(_db, alias);
  }
}

class MoorPlaylist extends DataClass implements Insertable<MoorPlaylist> {
  final int id;
  final String name;
  MoorPlaylist({required this.id, required this.name});
  factory MoorPlaylist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorPlaylist(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory MoorPlaylist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorPlaylist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  MoorPlaylist copyWith({int? id, String? name}) => MoorPlaylist(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('MoorPlaylist(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorPlaylist && other.id == this.id && other.name == this.name);
}

class PlaylistsCompanion extends UpdateCompanion<MoorPlaylist> {
  final Value<int> id;
  final Value<String> name;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<MoorPlaylist> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PlaylistsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, MoorPlaylist> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PlaylistsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $PlaylistsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'playlists';
  @override
  final String actualTableName = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<MoorPlaylist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorPlaylist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorPlaylist.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(_db, alias);
  }
}

class MoorPlaylistEntry extends DataClass
    implements Insertable<MoorPlaylistEntry> {
  final int playlistId;
  final String songPath;
  final int position;
  MoorPlaylistEntry(
      {required this.playlistId,
      required this.songPath,
      required this.position});
  factory MoorPlaylistEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorPlaylistEntry(
      playlistId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      songPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song_path'])!,
      position: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}position'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<int>(playlistId);
    map['song_path'] = Variable<String>(songPath);
    map['position'] = Variable<int>(position);
    return map;
  }

  PlaylistEntriesCompanion toCompanion(bool nullToAbsent) {
    return PlaylistEntriesCompanion(
      playlistId: Value(playlistId),
      songPath: Value(songPath),
      position: Value(position),
    );
  }

  factory MoorPlaylistEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorPlaylistEntry(
      playlistId: serializer.fromJson<int>(json['playlistId']),
      songPath: serializer.fromJson<String>(json['songPath']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<int>(playlistId),
      'songPath': serializer.toJson<String>(songPath),
      'position': serializer.toJson<int>(position),
    };
  }

  MoorPlaylistEntry copyWith(
          {int? playlistId, String? songPath, int? position}) =>
      MoorPlaylistEntry(
        playlistId: playlistId ?? this.playlistId,
        songPath: songPath ?? this.songPath,
        position: position ?? this.position,
      );
  @override
  String toString() {
    return (StringBuffer('MoorPlaylistEntry(')
          ..write('playlistId: $playlistId, ')
          ..write('songPath: $songPath, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(playlistId.hashCode, $mrjc(songPath.hashCode, position.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorPlaylistEntry &&
          other.playlistId == this.playlistId &&
          other.songPath == this.songPath &&
          other.position == this.position);
}

class PlaylistEntriesCompanion extends UpdateCompanion<MoorPlaylistEntry> {
  final Value<int> playlistId;
  final Value<String> songPath;
  final Value<int> position;
  const PlaylistEntriesCompanion({
    this.playlistId = const Value.absent(),
    this.songPath = const Value.absent(),
    this.position = const Value.absent(),
  });
  PlaylistEntriesCompanion.insert({
    required int playlistId,
    required String songPath,
    required int position,
  })  : playlistId = Value(playlistId),
        songPath = Value(songPath),
        position = Value(position);
  static Insertable<MoorPlaylistEntry> custom({
    Expression<int>? playlistId,
    Expression<String>? songPath,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (songPath != null) 'song_path': songPath,
      if (position != null) 'position': position,
    });
  }

  PlaylistEntriesCompanion copyWith(
      {Value<int>? playlistId, Value<String>? songPath, Value<int>? position}) {
    return PlaylistEntriesCompanion(
      playlistId: playlistId ?? this.playlistId,
      songPath: songPath ?? this.songPath,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (songPath.present) {
      map['song_path'] = Variable<String>(songPath.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistEntriesCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('songPath: $songPath, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $PlaylistEntriesTable extends PlaylistEntries
    with TableInfo<$PlaylistEntriesTable, MoorPlaylistEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PlaylistEntriesTable(this._db, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedIntColumn playlistId = _constructPlaylistId();
  GeneratedIntColumn _constructPlaylistId() {
    return GeneratedIntColumn(
      'playlist_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _songPathMeta = const VerificationMeta('songPath');
  @override
  late final GeneratedTextColumn songPath = _constructSongPath();
  GeneratedTextColumn _constructSongPath() {
    return GeneratedTextColumn(
      'song_path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _positionMeta = const VerificationMeta('position');
  @override
  late final GeneratedIntColumn position = _constructPosition();
  GeneratedIntColumn _constructPosition() {
    return GeneratedIntColumn(
      'position',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [playlistId, songPath, position];
  @override
  $PlaylistEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'playlist_entries';
  @override
  final String actualTableName = 'playlist_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MoorPlaylistEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('song_path')) {
      context.handle(_songPathMeta,
          songPath.isAcceptableOrUnknown(data['song_path']!, _songPathMeta));
    } else if (isInserting) {
      context.missing(_songPathMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  MoorPlaylistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MoorPlaylistEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlaylistEntriesTable createAlias(String alias) {
    return $PlaylistEntriesTable(_db, alias);
  }
}

class KeyValueEntry extends DataClass implements Insertable<KeyValueEntry> {
  final String key;
  final String value;
  KeyValueEntry({required this.key, required this.value});
  factory KeyValueEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return KeyValueEntry(
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValueEntriesCompanion toCompanion(bool nullToAbsent) {
    return KeyValueEntriesCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory KeyValueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return KeyValueEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValueEntry copyWith({String? key, String? value}) => KeyValueEntry(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('KeyValueEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(key.hashCode, value.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValueEntriesCompanion extends UpdateCompanion<KeyValueEntry> {
  final Value<String> key;
  final Value<String> value;
  const KeyValueEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  KeyValueEntriesCompanion.insert({
    required String key,
    required String value,
  })  : key = Value(key),
        value = Value(value);
  static Insertable<KeyValueEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  KeyValueEntriesCompanion copyWith(
      {Value<String>? key, Value<String>? value}) {
    return KeyValueEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $KeyValueEntriesTable extends KeyValueEntries
    with TableInfo<$KeyValueEntriesTable, KeyValueEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $KeyValueEntriesTable(this._db, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedTextColumn key = _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedTextColumn value = _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn(
      'value',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  $KeyValueEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'key_value_entries';
  @override
  final String actualTableName = 'key_value_entries';
  @override
  VerificationContext validateIntegrity(Insertable<KeyValueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return KeyValueEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $KeyValueEntriesTable createAlias(String alias) {
    return $KeyValueEntriesTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$MoorDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $ArtistsTable artists = $ArtistsTable(this);
  late final $LibraryFoldersTable libraryFolders = $LibraryFoldersTable(this);
  late final $QueueEntriesTable queueEntries = $QueueEntriesTable(this);
  late final $AvailableSongEntriesTable availableSongEntries =
      $AvailableSongEntriesTable(this);
  late final $SongsTable songs = $SongsTable(this);
  late final $MoorAlbumOfDayTable moorAlbumOfDay = $MoorAlbumOfDayTable(this);
  late final $SmartListsTable smartLists = $SmartListsTable(this);
  late final $SmartListArtistsTable smartListArtists =
      $SmartListArtistsTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistEntriesTable playlistEntries =
      $PlaylistEntriesTable(this);
  late final $KeyValueEntriesTable keyValueEntries =
      $KeyValueEntriesTable(this);
  late final PersistentStateDao persistentStateDao =
      PersistentStateDao(this as MoorDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as MoorDatabase);
  late final MusicDataDao musicDataDao = MusicDataDao(this as MoorDatabase);
  late final PlaylistDao playlistDao = PlaylistDao(this as MoorDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        albums,
        artists,
        libraryFolders,
        queueEntries,
        availableSongEntries,
        songs,
        moorAlbumOfDay,
        smartLists,
        smartListArtists,
        playlists,
        playlistEntries,
        keyValueEntries
      ];
}
