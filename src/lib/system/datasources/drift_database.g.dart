// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, DriftAlbum> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  @override
  late final GeneratedColumn<String> albumArtPath = GeneratedColumn<String>(
      'album_art_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, artist, albumArtPath, color, year];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<DriftAlbum> instance,
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
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
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
  DriftAlbum map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftAlbum(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      albumArtPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_art_path']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class DriftAlbum extends DataClass implements Insertable<DriftAlbum> {
  final int id;
  final String title;
  final String artist;
  final String? albumArtPath;
  final int? color;
  final int? year;
  const DriftAlbum(
      {required this.id,
      required this.title,
      required this.artist,
      this.albumArtPath,
      this.color,
      this.year});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    if (!nullToAbsent || albumArtPath != null) {
      map['album_art_path'] = Variable<String>(albumArtPath);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
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
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
    );
  }

  factory DriftAlbum.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftAlbum(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      albumArtPath: serializer.fromJson<String?>(json['albumArtPath']),
      color: serializer.fromJson<int?>(json['color']),
      year: serializer.fromJson<int?>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'albumArtPath': serializer.toJson<String?>(albumArtPath),
      'color': serializer.toJson<int?>(color),
      'year': serializer.toJson<int?>(year),
    };
  }

  DriftAlbum copyWith(
          {int? id,
          String? title,
          String? artist,
          Value<String?> albumArtPath = const Value.absent(),
          Value<int?> color = const Value.absent(),
          Value<int?> year = const Value.absent()}) =>
      DriftAlbum(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        albumArtPath:
            albumArtPath.present ? albumArtPath.value : this.albumArtPath,
        color: color.present ? color.value : this.color,
        year: year.present ? year.value : this.year,
      );
  DriftAlbum copyWithCompanion(AlbumsCompanion data) {
    return DriftAlbum(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      albumArtPath: data.albumArtPath.present
          ? data.albumArtPath.value
          : this.albumArtPath,
      color: data.color.present ? data.color.value : this.color,
      year: data.year.present ? data.year.value : this.year,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftAlbum(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('color: $color, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, artist, albumArtPath, color, year);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftAlbum &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.albumArtPath == this.albumArtPath &&
          other.color == this.color &&
          other.year == this.year);
}

class AlbumsCompanion extends UpdateCompanion<DriftAlbum> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String?> albumArtPath;
  final Value<int?> color;
  final Value<int?> year;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.color = const Value.absent(),
    this.year = const Value.absent(),
  });
  AlbumsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    this.albumArtPath = const Value.absent(),
    this.color = const Value.absent(),
    this.year = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist);
  static Insertable<DriftAlbum> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? albumArtPath,
    Expression<int>? color,
    Expression<int>? year,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (albumArtPath != null) 'album_art_path': albumArtPath,
      if (color != null) 'color': color,
      if (year != null) 'year': year,
    });
  }

  AlbumsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String?>? albumArtPath,
      Value<int?>? color,
      Value<int?>? year}) {
    return AlbumsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      color: color ?? this.color,
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
    if (color.present) {
      map['color'] = Variable<int>(color.value);
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
          ..write('color: $color, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, DriftArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artists';
  @override
  VerificationContext validateIntegrity(Insertable<DriftArtist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftArtist(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(attachedDatabase, alias);
  }
}

class DriftArtist extends DataClass implements Insertable<DriftArtist> {
  final String name;
  final int id;
  const DriftArtist({required this.name, required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['id'] = Variable<int>(id);
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      name: Value(name),
      id: Value(id),
    );
  }

  factory DriftArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftArtist(
      name: serializer.fromJson<String>(json['name']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'id': serializer.toJson<int>(id),
    };
  }

  DriftArtist copyWith({String? name, int? id}) => DriftArtist(
        name: name ?? this.name,
        id: id ?? this.id,
      );
  DriftArtist copyWithCompanion(ArtistsCompanion data) {
    return DriftArtist(
      name: data.name.present ? data.name.value : this.name,
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftArtist(')
          ..write('name: $name, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftArtist && other.name == this.name && other.id == this.id);
}

class ArtistsCompanion extends UpdateCompanion<DriftArtist> {
  final Value<String> name;
  final Value<int> id;
  const ArtistsCompanion({
    this.name = const Value.absent(),
    this.id = const Value.absent(),
  });
  ArtistsCompanion.insert({
    required String name,
    this.id = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DriftArtist> custom({
    Expression<String>? name,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (id != null) 'id': id,
    });
  }

  ArtistsCompanion copyWith({Value<String>? name, Value<int>? id}) {
    return ArtistsCompanion(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistsCompanion(')
          ..write('name: $name, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $LibraryFoldersTable extends LibraryFolders
    with TableInfo<$LibraryFoldersTable, LibraryFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_folders';
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LibraryFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryFolder(
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
    );
  }

  @override
  $LibraryFoldersTable createAlias(String alias) {
    return $LibraryFoldersTable(attachedDatabase, alias);
  }
}

class LibraryFolder extends DataClass implements Insertable<LibraryFolder> {
  final String path;
  const LibraryFolder({required this.path});
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryFolder(
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
    };
  }

  LibraryFolder copyWith({String? path}) => LibraryFolder(
        path: path ?? this.path,
      );
  LibraryFolder copyWithCompanion(LibraryFoldersCompanion data) {
    return LibraryFolder(
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryFolder(')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => path.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryFolder && other.path == this.path);
}

class LibraryFoldersCompanion extends UpdateCompanion<LibraryFolder> {
  final Value<String> path;
  final Value<int> rowid;
  const LibraryFoldersCompanion({
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LibraryFoldersCompanion.insert({
    required String path,
    this.rowid = const Value.absent(),
  }) : path = Value(path);
  static Insertable<LibraryFolder> custom({
    Expression<String>? path,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LibraryFoldersCompanion copyWith({Value<String>? path, Value<int>? rowid}) {
    return LibraryFoldersCompanion(
      path: path ?? this.path,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryFoldersCompanion(')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueueEntriesTable extends QueueEntries
    with TableInfo<$QueueEntriesTable, DriftQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originalIndexMeta =
      const VerificationMeta('originalIndex');
  @override
  late final GeneratedColumn<int> originalIndex = GeneratedColumn<int>(
      'original_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
      'is_available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_available" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [index, path, originalIndex, type, isAvailable];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queue_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DriftQueueEntry> instance,
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
  DriftQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftQueueEntry(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      originalIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}original_index'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
    );
  }

  @override
  $QueueEntriesTable createAlias(String alias) {
    return $QueueEntriesTable(attachedDatabase, alias);
  }
}

class DriftQueueEntry extends DataClass implements Insertable<DriftQueueEntry> {
  final int index;
  final String path;
  final int originalIndex;
  final int type;
  final bool isAvailable;
  const DriftQueueEntry(
      {required this.index,
      required this.path,
      required this.originalIndex,
      required this.type,
      required this.isAvailable});
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

  factory DriftQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftQueueEntry(
      index: serializer.fromJson<int>(json['index']),
      path: serializer.fromJson<String>(json['path']),
      originalIndex: serializer.fromJson<int>(json['originalIndex']),
      type: serializer.fromJson<int>(json['type']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'path': serializer.toJson<String>(path),
      'originalIndex': serializer.toJson<int>(originalIndex),
      'type': serializer.toJson<int>(type),
      'isAvailable': serializer.toJson<bool>(isAvailable),
    };
  }

  DriftQueueEntry copyWith(
          {int? index,
          String? path,
          int? originalIndex,
          int? type,
          bool? isAvailable}) =>
      DriftQueueEntry(
        index: index ?? this.index,
        path: path ?? this.path,
        originalIndex: originalIndex ?? this.originalIndex,
        type: type ?? this.type,
        isAvailable: isAvailable ?? this.isAvailable,
      );
  DriftQueueEntry copyWithCompanion(QueueEntriesCompanion data) {
    return DriftQueueEntry(
      index: data.index.present ? data.index.value : this.index,
      path: data.path.present ? data.path.value : this.path,
      originalIndex: data.originalIndex.present
          ? data.originalIndex.value
          : this.originalIndex,
      type: data.type.present ? data.type.value : this.type,
      isAvailable:
          data.isAvailable.present ? data.isAvailable.value : this.isAvailable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftQueueEntry(')
          ..write('index: $index, ')
          ..write('path: $path, ')
          ..write('originalIndex: $originalIndex, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(index, path, originalIndex, type, isAvailable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftQueueEntry &&
          other.index == this.index &&
          other.path == this.path &&
          other.originalIndex == this.originalIndex &&
          other.type == this.type &&
          other.isAvailable == this.isAvailable);
}

class QueueEntriesCompanion extends UpdateCompanion<DriftQueueEntry> {
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
  static Insertable<DriftQueueEntry> custom({
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

class $AvailableSongEntriesTable extends AvailableSongEntries
    with TableInfo<$AvailableSongEntriesTable, AvailableSongEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvailableSongEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originalIndexMeta =
      const VerificationMeta('originalIndex');
  @override
  late final GeneratedColumn<int> originalIndex = GeneratedColumn<int>(
      'original_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
      'is_available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_available" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [index, path, originalIndex, type, isAvailable];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'available_song_entries';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvailableSongEntry(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      originalIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}original_index'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
    );
  }

  @override
  $AvailableSongEntriesTable createAlias(String alias) {
    return $AvailableSongEntriesTable(attachedDatabase, alias);
  }
}

class AvailableSongEntry extends DataClass
    implements Insertable<AvailableSongEntry> {
  final int index;
  final String path;
  final int originalIndex;
  final int type;
  final bool isAvailable;
  const AvailableSongEntry(
      {required this.index,
      required this.path,
      required this.originalIndex,
      required this.type,
      required this.isAvailable});
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  AvailableSongEntry copyWithCompanion(AvailableSongEntriesCompanion data) {
    return AvailableSongEntry(
      index: data.index.present ? data.index.value : this.index,
      path: data.path.present ? data.path.value : this.path,
      originalIndex: data.originalIndex.present
          ? data.originalIndex.value
          : this.originalIndex,
      type: data.type.present ? data.type.value : this.type,
      isAvailable:
          data.isAvailable.present ? data.isAvailable.value : this.isAvailable,
    );
  }

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
  int get hashCode =>
      Object.hash(index, path, originalIndex, type, isAvailable);
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

class $SongsTable extends Songs with TableInfo<$SongsTable, DriftSong> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumTitleMeta =
      const VerificationMeta('albumTitle');
  @override
  late final GeneratedColumn<String> albumTitle = GeneratedColumn<String>(
      'album_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<int> albumId = GeneratedColumn<int>(
      'album_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _albumArtPathMeta =
      const VerificationMeta('albumArtPath');
  @override
  late final GeneratedColumn<String> albumArtPath = GeneratedColumn<String>(
      'album_art_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _discNumberMeta =
      const VerificationMeta('discNumber');
  @override
  late final GeneratedColumn<int> discNumber = GeneratedColumn<int>(
      'disc_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _trackNumberMeta =
      const VerificationMeta('trackNumber');
  @override
  late final GeneratedColumn<int> trackNumber = GeneratedColumn<int>(
      'track_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _blockLevelMeta =
      const VerificationMeta('blockLevel');
  @override
  late final GeneratedColumn<int> blockLevel = GeneratedColumn<int>(
      'block_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _likeCountMeta =
      const VerificationMeta('likeCount');
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
      'like_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _skipCountMeta =
      const VerificationMeta('skipCount');
  @override
  late final GeneratedColumn<int> skipCount = GeneratedColumn<int>(
      'skip_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _playCountMeta =
      const VerificationMeta('playCount');
  @override
  late final GeneratedColumn<int> playCount = GeneratedColumn<int>(
      'play_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _presentMeta =
      const VerificationMeta('present');
  @override
  late final GeneratedColumn<bool> present = GeneratedColumn<bool>(
      'present', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("present" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _timeAddedMeta =
      const VerificationMeta('timeAdded');
  @override
  late final GeneratedColumn<DateTime> timeAdded = GeneratedColumn<DateTime>(
      'time_added', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _previousMeta =
      const VerificationMeta('previous');
  @override
  late final GeneratedColumn<bool> previous = GeneratedColumn<bool>(
      'previous', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("previous" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nextMeta = const VerificationMeta('next');
  @override
  late final GeneratedColumn<bool> next = GeneratedColumn<bool>(
      'next', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("next" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        title,
        albumTitle,
        albumId,
        artist,
        path,
        duration,
        albumArtPath,
        color,
        discNumber,
        trackNumber,
        year,
        blockLevel,
        likeCount,
        skipCount,
        playCount,
        present,
        timeAdded,
        lastModified,
        previous,
        next
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'songs';
  @override
  VerificationContext validateIntegrity(Insertable<DriftSong> instance,
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
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
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
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
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
  DriftSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftSong(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      albumTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_title'])!,
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}album_id'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      albumArtPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_art_path']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      discNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}disc_number'])!,
      trackNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}track_number'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
      blockLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_level'])!,
      likeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}like_count'])!,
      skipCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}skip_count'])!,
      playCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}play_count'])!,
      present: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}present'])!,
      timeAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_added'])!,
      lastModified: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified'])!,
      previous: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}previous'])!,
      next: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}next'])!,
    );
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(attachedDatabase, alias);
  }
}

class DriftSong extends DataClass implements Insertable<DriftSong> {
  final String title;
  final String albumTitle;
  final int albumId;
  final String artist;
  final String path;
  final int duration;
  final String? albumArtPath;
  final int? color;
  final int discNumber;
  final int trackNumber;
  final int? year;
  final int blockLevel;
  final int likeCount;
  final int skipCount;
  final int playCount;
  final bool present;
  final DateTime timeAdded;
  final DateTime lastModified;
  final bool previous;
  final bool next;
  const DriftSong(
      {required this.title,
      required this.albumTitle,
      required this.albumId,
      required this.artist,
      required this.path,
      required this.duration,
      this.albumArtPath,
      this.color,
      required this.discNumber,
      required this.trackNumber,
      this.year,
      required this.blockLevel,
      required this.likeCount,
      required this.skipCount,
      required this.playCount,
      required this.present,
      required this.timeAdded,
      required this.lastModified,
      required this.previous,
      required this.next});
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
      map['album_art_path'] = Variable<String>(albumArtPath);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['disc_number'] = Variable<int>(discNumber);
    map['track_number'] = Variable<int>(trackNumber);
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    map['block_level'] = Variable<int>(blockLevel);
    map['like_count'] = Variable<int>(likeCount);
    map['skip_count'] = Variable<int>(skipCount);
    map['play_count'] = Variable<int>(playCount);
    map['present'] = Variable<bool>(present);
    map['time_added'] = Variable<DateTime>(timeAdded);
    map['last_modified'] = Variable<DateTime>(lastModified);
    map['previous'] = Variable<bool>(previous);
    map['next'] = Variable<bool>(next);
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
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      discNumber: Value(discNumber),
      trackNumber: Value(trackNumber),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      blockLevel: Value(blockLevel),
      likeCount: Value(likeCount),
      skipCount: Value(skipCount),
      playCount: Value(playCount),
      present: Value(present),
      timeAdded: Value(timeAdded),
      lastModified: Value(lastModified),
      previous: Value(previous),
      next: Value(next),
    );
  }

  factory DriftSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftSong(
      title: serializer.fromJson<String>(json['title']),
      albumTitle: serializer.fromJson<String>(json['albumTitle']),
      albumId: serializer.fromJson<int>(json['albumId']),
      artist: serializer.fromJson<String>(json['artist']),
      path: serializer.fromJson<String>(json['path']),
      duration: serializer.fromJson<int>(json['duration']),
      albumArtPath: serializer.fromJson<String?>(json['albumArtPath']),
      color: serializer.fromJson<int?>(json['color']),
      discNumber: serializer.fromJson<int>(json['discNumber']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
      year: serializer.fromJson<int?>(json['year']),
      blockLevel: serializer.fromJson<int>(json['blockLevel']),
      likeCount: serializer.fromJson<int>(json['likeCount']),
      skipCount: serializer.fromJson<int>(json['skipCount']),
      playCount: serializer.fromJson<int>(json['playCount']),
      present: serializer.fromJson<bool>(json['present']),
      timeAdded: serializer.fromJson<DateTime>(json['timeAdded']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
      previous: serializer.fromJson<bool>(json['previous']),
      next: serializer.fromJson<bool>(json['next']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'albumTitle': serializer.toJson<String>(albumTitle),
      'albumId': serializer.toJson<int>(albumId),
      'artist': serializer.toJson<String>(artist),
      'path': serializer.toJson<String>(path),
      'duration': serializer.toJson<int>(duration),
      'albumArtPath': serializer.toJson<String?>(albumArtPath),
      'color': serializer.toJson<int?>(color),
      'discNumber': serializer.toJson<int>(discNumber),
      'trackNumber': serializer.toJson<int>(trackNumber),
      'year': serializer.toJson<int?>(year),
      'blockLevel': serializer.toJson<int>(blockLevel),
      'likeCount': serializer.toJson<int>(likeCount),
      'skipCount': serializer.toJson<int>(skipCount),
      'playCount': serializer.toJson<int>(playCount),
      'present': serializer.toJson<bool>(present),
      'timeAdded': serializer.toJson<DateTime>(timeAdded),
      'lastModified': serializer.toJson<DateTime>(lastModified),
      'previous': serializer.toJson<bool>(previous),
      'next': serializer.toJson<bool>(next),
    };
  }

  DriftSong copyWith(
          {String? title,
          String? albumTitle,
          int? albumId,
          String? artist,
          String? path,
          int? duration,
          Value<String?> albumArtPath = const Value.absent(),
          Value<int?> color = const Value.absent(),
          int? discNumber,
          int? trackNumber,
          Value<int?> year = const Value.absent(),
          int? blockLevel,
          int? likeCount,
          int? skipCount,
          int? playCount,
          bool? present,
          DateTime? timeAdded,
          DateTime? lastModified,
          bool? previous,
          bool? next}) =>
      DriftSong(
        title: title ?? this.title,
        albumTitle: albumTitle ?? this.albumTitle,
        albumId: albumId ?? this.albumId,
        artist: artist ?? this.artist,
        path: path ?? this.path,
        duration: duration ?? this.duration,
        albumArtPath:
            albumArtPath.present ? albumArtPath.value : this.albumArtPath,
        color: color.present ? color.value : this.color,
        discNumber: discNumber ?? this.discNumber,
        trackNumber: trackNumber ?? this.trackNumber,
        year: year.present ? year.value : this.year,
        blockLevel: blockLevel ?? this.blockLevel,
        likeCount: likeCount ?? this.likeCount,
        skipCount: skipCount ?? this.skipCount,
        playCount: playCount ?? this.playCount,
        present: present ?? this.present,
        timeAdded: timeAdded ?? this.timeAdded,
        lastModified: lastModified ?? this.lastModified,
        previous: previous ?? this.previous,
        next: next ?? this.next,
      );
  DriftSong copyWithCompanion(SongsCompanion data) {
    return DriftSong(
      title: data.title.present ? data.title.value : this.title,
      albumTitle:
          data.albumTitle.present ? data.albumTitle.value : this.albumTitle,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      artist: data.artist.present ? data.artist.value : this.artist,
      path: data.path.present ? data.path.value : this.path,
      duration: data.duration.present ? data.duration.value : this.duration,
      albumArtPath: data.albumArtPath.present
          ? data.albumArtPath.value
          : this.albumArtPath,
      color: data.color.present ? data.color.value : this.color,
      discNumber:
          data.discNumber.present ? data.discNumber.value : this.discNumber,
      trackNumber:
          data.trackNumber.present ? data.trackNumber.value : this.trackNumber,
      year: data.year.present ? data.year.value : this.year,
      blockLevel:
          data.blockLevel.present ? data.blockLevel.value : this.blockLevel,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      skipCount: data.skipCount.present ? data.skipCount.value : this.skipCount,
      playCount: data.playCount.present ? data.playCount.value : this.playCount,
      present: data.present.present ? data.present.value : this.present,
      timeAdded: data.timeAdded.present ? data.timeAdded.value : this.timeAdded,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      previous: data.previous.present ? data.previous.value : this.previous,
      next: data.next.present ? data.next.value : this.next,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftSong(')
          ..write('title: $title, ')
          ..write('albumTitle: $albumTitle, ')
          ..write('albumId: $albumId, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('duration: $duration, ')
          ..write('albumArtPath: $albumArtPath, ')
          ..write('color: $color, ')
          ..write('discNumber: $discNumber, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('year: $year, ')
          ..write('blockLevel: $blockLevel, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('present: $present, ')
          ..write('timeAdded: $timeAdded, ')
          ..write('lastModified: $lastModified, ')
          ..write('previous: $previous, ')
          ..write('next: $next')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      title,
      albumTitle,
      albumId,
      artist,
      path,
      duration,
      albumArtPath,
      color,
      discNumber,
      trackNumber,
      year,
      blockLevel,
      likeCount,
      skipCount,
      playCount,
      present,
      timeAdded,
      lastModified,
      previous,
      next);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftSong &&
          other.title == this.title &&
          other.albumTitle == this.albumTitle &&
          other.albumId == this.albumId &&
          other.artist == this.artist &&
          other.path == this.path &&
          other.duration == this.duration &&
          other.albumArtPath == this.albumArtPath &&
          other.color == this.color &&
          other.discNumber == this.discNumber &&
          other.trackNumber == this.trackNumber &&
          other.year == this.year &&
          other.blockLevel == this.blockLevel &&
          other.likeCount == this.likeCount &&
          other.skipCount == this.skipCount &&
          other.playCount == this.playCount &&
          other.present == this.present &&
          other.timeAdded == this.timeAdded &&
          other.lastModified == this.lastModified &&
          other.previous == this.previous &&
          other.next == this.next);
}

class SongsCompanion extends UpdateCompanion<DriftSong> {
  final Value<String> title;
  final Value<String> albumTitle;
  final Value<int> albumId;
  final Value<String> artist;
  final Value<String> path;
  final Value<int> duration;
  final Value<String?> albumArtPath;
  final Value<int?> color;
  final Value<int> discNumber;
  final Value<int> trackNumber;
  final Value<int?> year;
  final Value<int> blockLevel;
  final Value<int> likeCount;
  final Value<int> skipCount;
  final Value<int> playCount;
  final Value<bool> present;
  final Value<DateTime> timeAdded;
  final Value<DateTime> lastModified;
  final Value<bool> previous;
  final Value<bool> next;
  final Value<int> rowid;
  const SongsCompanion({
    this.title = const Value.absent(),
    this.albumTitle = const Value.absent(),
    this.albumId = const Value.absent(),
    this.artist = const Value.absent(),
    this.path = const Value.absent(),
    this.duration = const Value.absent(),
    this.albumArtPath = const Value.absent(),
    this.color = const Value.absent(),
    this.discNumber = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.year = const Value.absent(),
    this.blockLevel = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.present = const Value.absent(),
    this.timeAdded = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SongsCompanion.insert({
    required String title,
    required String albumTitle,
    required int albumId,
    required String artist,
    required String path,
    required int duration,
    this.albumArtPath = const Value.absent(),
    this.color = const Value.absent(),
    required int discNumber,
    required int trackNumber,
    this.year = const Value.absent(),
    this.blockLevel = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.playCount = const Value.absent(),
    this.present = const Value.absent(),
    this.timeAdded = const Value.absent(),
    required DateTime lastModified,
    this.previous = const Value.absent(),
    this.next = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        albumTitle = Value(albumTitle),
        albumId = Value(albumId),
        artist = Value(artist),
        path = Value(path),
        duration = Value(duration),
        discNumber = Value(discNumber),
        trackNumber = Value(trackNumber),
        lastModified = Value(lastModified);
  static Insertable<DriftSong> custom({
    Expression<String>? title,
    Expression<String>? albumTitle,
    Expression<int>? albumId,
    Expression<String>? artist,
    Expression<String>? path,
    Expression<int>? duration,
    Expression<String>? albumArtPath,
    Expression<int>? color,
    Expression<int>? discNumber,
    Expression<int>? trackNumber,
    Expression<int>? year,
    Expression<int>? blockLevel,
    Expression<int>? likeCount,
    Expression<int>? skipCount,
    Expression<int>? playCount,
    Expression<bool>? present,
    Expression<DateTime>? timeAdded,
    Expression<DateTime>? lastModified,
    Expression<bool>? previous,
    Expression<bool>? next,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (albumTitle != null) 'album_title': albumTitle,
      if (albumId != null) 'album_id': albumId,
      if (artist != null) 'artist': artist,
      if (path != null) 'path': path,
      if (duration != null) 'duration': duration,
      if (albumArtPath != null) 'album_art_path': albumArtPath,
      if (color != null) 'color': color,
      if (discNumber != null) 'disc_number': discNumber,
      if (trackNumber != null) 'track_number': trackNumber,
      if (year != null) 'year': year,
      if (blockLevel != null) 'block_level': blockLevel,
      if (likeCount != null) 'like_count': likeCount,
      if (skipCount != null) 'skip_count': skipCount,
      if (playCount != null) 'play_count': playCount,
      if (present != null) 'present': present,
      if (timeAdded != null) 'time_added': timeAdded,
      if (lastModified != null) 'last_modified': lastModified,
      if (previous != null) 'previous': previous,
      if (next != null) 'next': next,
      if (rowid != null) 'rowid': rowid,
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
      Value<int?>? color,
      Value<int>? discNumber,
      Value<int>? trackNumber,
      Value<int?>? year,
      Value<int>? blockLevel,
      Value<int>? likeCount,
      Value<int>? skipCount,
      Value<int>? playCount,
      Value<bool>? present,
      Value<DateTime>? timeAdded,
      Value<DateTime>? lastModified,
      Value<bool>? previous,
      Value<bool>? next,
      Value<int>? rowid}) {
    return SongsCompanion(
      title: title ?? this.title,
      albumTitle: albumTitle ?? this.albumTitle,
      albumId: albumId ?? this.albumId,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      duration: duration ?? this.duration,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      color: color ?? this.color,
      discNumber: discNumber ?? this.discNumber,
      trackNumber: trackNumber ?? this.trackNumber,
      year: year ?? this.year,
      blockLevel: blockLevel ?? this.blockLevel,
      likeCount: likeCount ?? this.likeCount,
      skipCount: skipCount ?? this.skipCount,
      playCount: playCount ?? this.playCount,
      present: present ?? this.present,
      timeAdded: timeAdded ?? this.timeAdded,
      lastModified: lastModified ?? this.lastModified,
      previous: previous ?? this.previous,
      next: next ?? this.next,
      rowid: rowid ?? this.rowid,
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
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (discNumber.present) {
      map['disc_number'] = Variable<int>(discNumber.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
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
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    if (previous.present) {
      map['previous'] = Variable<bool>(previous.value);
    }
    if (next.present) {
      map['next'] = Variable<bool>(next.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('color: $color, ')
          ..write('discNumber: $discNumber, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('year: $year, ')
          ..write('blockLevel: $blockLevel, ')
          ..write('likeCount: $likeCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('playCount: $playCount, ')
          ..write('present: $present, ')
          ..write('timeAdded: $timeAdded, ')
          ..write('lastModified: $lastModified, ')
          ..write('previous: $previous, ')
          ..write('next: $next, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmartListsTable extends SmartLists
    with TableInfo<$SmartListsTable, DriftSmartList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shuffleModeMeta =
      const VerificationMeta('shuffleMode');
  @override
  late final GeneratedColumn<String> shuffleMode = GeneratedColumn<String>(
      'shuffle_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('auto_awesome_rounded'));
  static const VerificationMeta _gradientMeta =
      const VerificationMeta('gradient');
  @override
  late final GeneratedColumn<String> gradient = GeneratedColumn<String>(
      'gradient', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('sanguine'));
  static const VerificationMeta _timeCreatedMeta =
      const VerificationMeta('timeCreated');
  @override
  late final GeneratedColumn<DateTime> timeCreated = GeneratedColumn<DateTime>(
      'time_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _timeChangedMeta =
      const VerificationMeta('timeChanged');
  @override
  late final GeneratedColumn<DateTime> timeChanged = GeneratedColumn<DateTime>(
      'time_changed', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _timeLastPlayedMeta =
      const VerificationMeta('timeLastPlayed');
  @override
  late final GeneratedColumn<DateTime> timeLastPlayed =
      GeneratedColumn<DateTime>('time_last_played', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.fromMillisecondsSinceEpoch(0)));
  static const VerificationMeta _excludeArtistsMeta =
      const VerificationMeta('excludeArtists');
  @override
  late final GeneratedColumn<bool> excludeArtists = GeneratedColumn<bool>(
      'exclude_artists', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("exclude_artists" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _blockLevelMeta =
      const VerificationMeta('blockLevel');
  @override
  late final GeneratedColumn<int> blockLevel = GeneratedColumn<int>(
      'block_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minLikeCountMeta =
      const VerificationMeta('minLikeCount');
  @override
  late final GeneratedColumn<int> minLikeCount = GeneratedColumn<int>(
      'min_like_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxLikeCountMeta =
      const VerificationMeta('maxLikeCount');
  @override
  late final GeneratedColumn<int> maxLikeCount = GeneratedColumn<int>(
      'max_like_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _minPlayCountMeta =
      const VerificationMeta('minPlayCount');
  @override
  late final GeneratedColumn<int> minPlayCount = GeneratedColumn<int>(
      'min_play_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxPlayCountMeta =
      const VerificationMeta('maxPlayCount');
  @override
  late final GeneratedColumn<int> maxPlayCount = GeneratedColumn<int>(
      'max_play_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _minSkipCountMeta =
      const VerificationMeta('minSkipCount');
  @override
  late final GeneratedColumn<int> minSkipCount = GeneratedColumn<int>(
      'min_skip_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxSkipCountMeta =
      const VerificationMeta('maxSkipCount');
  @override
  late final GeneratedColumn<int> maxSkipCount = GeneratedColumn<int>(
      'max_skip_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _minYearMeta =
      const VerificationMeta('minYear');
  @override
  late final GeneratedColumn<int> minYear = GeneratedColumn<int>(
      'min_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxYearMeta =
      const VerificationMeta('maxYear');
  @override
  late final GeneratedColumn<int> maxYear = GeneratedColumn<int>(
      'max_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _limitMeta = const VerificationMeta('limit');
  @override
  late final GeneratedColumn<int> limit = GeneratedColumn<int>(
      'limit', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderCriteriaMeta =
      const VerificationMeta('orderCriteria');
  @override
  late final GeneratedColumn<String> orderCriteria = GeneratedColumn<String>(
      'order_criteria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderDirectionsMeta =
      const VerificationMeta('orderDirections');
  @override
  late final GeneratedColumn<String> orderDirections = GeneratedColumn<String>(
      'order_directions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        shuffleMode,
        icon,
        gradient,
        timeCreated,
        timeChanged,
        timeLastPlayed,
        excludeArtists,
        blockLevel,
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_lists';
  @override
  VerificationContext validateIntegrity(Insertable<DriftSmartList> instance,
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
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('gradient')) {
      context.handle(_gradientMeta,
          gradient.isAcceptableOrUnknown(data['gradient']!, _gradientMeta));
    }
    if (data.containsKey('time_created')) {
      context.handle(
          _timeCreatedMeta,
          timeCreated.isAcceptableOrUnknown(
              data['time_created']!, _timeCreatedMeta));
    }
    if (data.containsKey('time_changed')) {
      context.handle(
          _timeChangedMeta,
          timeChanged.isAcceptableOrUnknown(
              data['time_changed']!, _timeChangedMeta));
    }
    if (data.containsKey('time_last_played')) {
      context.handle(
          _timeLastPlayedMeta,
          timeLastPlayed.isAcceptableOrUnknown(
              data['time_last_played']!, _timeLastPlayedMeta));
    }
    if (data.containsKey('exclude_artists')) {
      context.handle(
          _excludeArtistsMeta,
          excludeArtists.isAcceptableOrUnknown(
              data['exclude_artists']!, _excludeArtistsMeta));
    }
    if (data.containsKey('block_level')) {
      context.handle(
          _blockLevelMeta,
          blockLevel.isAcceptableOrUnknown(
              data['block_level']!, _blockLevelMeta));
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
  DriftSmartList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftSmartList(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      shuffleMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shuffle_mode']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      gradient: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gradient'])!,
      timeCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_created'])!,
      timeChanged: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_changed'])!,
      timeLastPlayed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}time_last_played'])!,
      excludeArtists: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}exclude_artists'])!,
      blockLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_level'])!,
      minLikeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_like_count'])!,
      maxLikeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_like_count'])!,
      minPlayCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_play_count']),
      maxPlayCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_play_count']),
      minSkipCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_skip_count']),
      maxSkipCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_skip_count']),
      minYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_year']),
      maxYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_year']),
      limit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}limit']),
      orderCriteria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_criteria'])!,
      orderDirections: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}order_directions'])!,
    );
  }

  @override
  $SmartListsTable createAlias(String alias) {
    return $SmartListsTable(attachedDatabase, alias);
  }
}

class DriftSmartList extends DataClass implements Insertable<DriftSmartList> {
  final int id;
  final String name;
  final String? shuffleMode;
  final String icon;
  final String gradient;
  final DateTime timeCreated;
  final DateTime timeChanged;
  final DateTime timeLastPlayed;
  final bool excludeArtists;
  final int blockLevel;
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
  const DriftSmartList(
      {required this.id,
      required this.name,
      this.shuffleMode,
      required this.icon,
      required this.gradient,
      required this.timeCreated,
      required this.timeChanged,
      required this.timeLastPlayed,
      required this.excludeArtists,
      required this.blockLevel,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || shuffleMode != null) {
      map['shuffle_mode'] = Variable<String>(shuffleMode);
    }
    map['icon'] = Variable<String>(icon);
    map['gradient'] = Variable<String>(gradient);
    map['time_created'] = Variable<DateTime>(timeCreated);
    map['time_changed'] = Variable<DateTime>(timeChanged);
    map['time_last_played'] = Variable<DateTime>(timeLastPlayed);
    map['exclude_artists'] = Variable<bool>(excludeArtists);
    map['block_level'] = Variable<int>(blockLevel);
    map['min_like_count'] = Variable<int>(minLikeCount);
    map['max_like_count'] = Variable<int>(maxLikeCount);
    if (!nullToAbsent || minPlayCount != null) {
      map['min_play_count'] = Variable<int>(minPlayCount);
    }
    if (!nullToAbsent || maxPlayCount != null) {
      map['max_play_count'] = Variable<int>(maxPlayCount);
    }
    if (!nullToAbsent || minSkipCount != null) {
      map['min_skip_count'] = Variable<int>(minSkipCount);
    }
    if (!nullToAbsent || maxSkipCount != null) {
      map['max_skip_count'] = Variable<int>(maxSkipCount);
    }
    if (!nullToAbsent || minYear != null) {
      map['min_year'] = Variable<int>(minYear);
    }
    if (!nullToAbsent || maxYear != null) {
      map['max_year'] = Variable<int>(maxYear);
    }
    if (!nullToAbsent || limit != null) {
      map['limit'] = Variable<int>(limit);
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
      icon: Value(icon),
      gradient: Value(gradient),
      timeCreated: Value(timeCreated),
      timeChanged: Value(timeChanged),
      timeLastPlayed: Value(timeLastPlayed),
      excludeArtists: Value(excludeArtists),
      blockLevel: Value(blockLevel),
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

  factory DriftSmartList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftSmartList(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shuffleMode: serializer.fromJson<String?>(json['shuffleMode']),
      icon: serializer.fromJson<String>(json['icon']),
      gradient: serializer.fromJson<String>(json['gradient']),
      timeCreated: serializer.fromJson<DateTime>(json['timeCreated']),
      timeChanged: serializer.fromJson<DateTime>(json['timeChanged']),
      timeLastPlayed: serializer.fromJson<DateTime>(json['timeLastPlayed']),
      excludeArtists: serializer.fromJson<bool>(json['excludeArtists']),
      blockLevel: serializer.fromJson<int>(json['blockLevel']),
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'shuffleMode': serializer.toJson<String?>(shuffleMode),
      'icon': serializer.toJson<String>(icon),
      'gradient': serializer.toJson<String>(gradient),
      'timeCreated': serializer.toJson<DateTime>(timeCreated),
      'timeChanged': serializer.toJson<DateTime>(timeChanged),
      'timeLastPlayed': serializer.toJson<DateTime>(timeLastPlayed),
      'excludeArtists': serializer.toJson<bool>(excludeArtists),
      'blockLevel': serializer.toJson<int>(blockLevel),
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

  DriftSmartList copyWith(
          {int? id,
          String? name,
          Value<String?> shuffleMode = const Value.absent(),
          String? icon,
          String? gradient,
          DateTime? timeCreated,
          DateTime? timeChanged,
          DateTime? timeLastPlayed,
          bool? excludeArtists,
          int? blockLevel,
          int? minLikeCount,
          int? maxLikeCount,
          Value<int?> minPlayCount = const Value.absent(),
          Value<int?> maxPlayCount = const Value.absent(),
          Value<int?> minSkipCount = const Value.absent(),
          Value<int?> maxSkipCount = const Value.absent(),
          Value<int?> minYear = const Value.absent(),
          Value<int?> maxYear = const Value.absent(),
          Value<int?> limit = const Value.absent(),
          String? orderCriteria,
          String? orderDirections}) =>
      DriftSmartList(
        id: id ?? this.id,
        name: name ?? this.name,
        shuffleMode: shuffleMode.present ? shuffleMode.value : this.shuffleMode,
        icon: icon ?? this.icon,
        gradient: gradient ?? this.gradient,
        timeCreated: timeCreated ?? this.timeCreated,
        timeChanged: timeChanged ?? this.timeChanged,
        timeLastPlayed: timeLastPlayed ?? this.timeLastPlayed,
        excludeArtists: excludeArtists ?? this.excludeArtists,
        blockLevel: blockLevel ?? this.blockLevel,
        minLikeCount: minLikeCount ?? this.minLikeCount,
        maxLikeCount: maxLikeCount ?? this.maxLikeCount,
        minPlayCount:
            minPlayCount.present ? minPlayCount.value : this.minPlayCount,
        maxPlayCount:
            maxPlayCount.present ? maxPlayCount.value : this.maxPlayCount,
        minSkipCount:
            minSkipCount.present ? minSkipCount.value : this.minSkipCount,
        maxSkipCount:
            maxSkipCount.present ? maxSkipCount.value : this.maxSkipCount,
        minYear: minYear.present ? minYear.value : this.minYear,
        maxYear: maxYear.present ? maxYear.value : this.maxYear,
        limit: limit.present ? limit.value : this.limit,
        orderCriteria: orderCriteria ?? this.orderCriteria,
        orderDirections: orderDirections ?? this.orderDirections,
      );
  DriftSmartList copyWithCompanion(SmartListsCompanion data) {
    return DriftSmartList(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shuffleMode:
          data.shuffleMode.present ? data.shuffleMode.value : this.shuffleMode,
      icon: data.icon.present ? data.icon.value : this.icon,
      gradient: data.gradient.present ? data.gradient.value : this.gradient,
      timeCreated:
          data.timeCreated.present ? data.timeCreated.value : this.timeCreated,
      timeChanged:
          data.timeChanged.present ? data.timeChanged.value : this.timeChanged,
      timeLastPlayed: data.timeLastPlayed.present
          ? data.timeLastPlayed.value
          : this.timeLastPlayed,
      excludeArtists: data.excludeArtists.present
          ? data.excludeArtists.value
          : this.excludeArtists,
      blockLevel:
          data.blockLevel.present ? data.blockLevel.value : this.blockLevel,
      minLikeCount: data.minLikeCount.present
          ? data.minLikeCount.value
          : this.minLikeCount,
      maxLikeCount: data.maxLikeCount.present
          ? data.maxLikeCount.value
          : this.maxLikeCount,
      minPlayCount: data.minPlayCount.present
          ? data.minPlayCount.value
          : this.minPlayCount,
      maxPlayCount: data.maxPlayCount.present
          ? data.maxPlayCount.value
          : this.maxPlayCount,
      minSkipCount: data.minSkipCount.present
          ? data.minSkipCount.value
          : this.minSkipCount,
      maxSkipCount: data.maxSkipCount.present
          ? data.maxSkipCount.value
          : this.maxSkipCount,
      minYear: data.minYear.present ? data.minYear.value : this.minYear,
      maxYear: data.maxYear.present ? data.maxYear.value : this.maxYear,
      limit: data.limit.present ? data.limit.value : this.limit,
      orderCriteria: data.orderCriteria.present
          ? data.orderCriteria.value
          : this.orderCriteria,
      orderDirections: data.orderDirections.present
          ? data.orderDirections.value
          : this.orderDirections,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftSmartList(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shuffleMode: $shuffleMode, ')
          ..write('icon: $icon, ')
          ..write('gradient: $gradient, ')
          ..write('timeCreated: $timeCreated, ')
          ..write('timeChanged: $timeChanged, ')
          ..write('timeLastPlayed: $timeLastPlayed, ')
          ..write('excludeArtists: $excludeArtists, ')
          ..write('blockLevel: $blockLevel, ')
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
  int get hashCode => Object.hashAll([
        id,
        name,
        shuffleMode,
        icon,
        gradient,
        timeCreated,
        timeChanged,
        timeLastPlayed,
        excludeArtists,
        blockLevel,
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
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftSmartList &&
          other.id == this.id &&
          other.name == this.name &&
          other.shuffleMode == this.shuffleMode &&
          other.icon == this.icon &&
          other.gradient == this.gradient &&
          other.timeCreated == this.timeCreated &&
          other.timeChanged == this.timeChanged &&
          other.timeLastPlayed == this.timeLastPlayed &&
          other.excludeArtists == this.excludeArtists &&
          other.blockLevel == this.blockLevel &&
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

class SmartListsCompanion extends UpdateCompanion<DriftSmartList> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> shuffleMode;
  final Value<String> icon;
  final Value<String> gradient;
  final Value<DateTime> timeCreated;
  final Value<DateTime> timeChanged;
  final Value<DateTime> timeLastPlayed;
  final Value<bool> excludeArtists;
  final Value<int> blockLevel;
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
    this.icon = const Value.absent(),
    this.gradient = const Value.absent(),
    this.timeCreated = const Value.absent(),
    this.timeChanged = const Value.absent(),
    this.timeLastPlayed = const Value.absent(),
    this.excludeArtists = const Value.absent(),
    this.blockLevel = const Value.absent(),
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
    this.icon = const Value.absent(),
    this.gradient = const Value.absent(),
    this.timeCreated = const Value.absent(),
    this.timeChanged = const Value.absent(),
    this.timeLastPlayed = const Value.absent(),
    this.excludeArtists = const Value.absent(),
    this.blockLevel = const Value.absent(),
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
  static Insertable<DriftSmartList> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? shuffleMode,
    Expression<String>? icon,
    Expression<String>? gradient,
    Expression<DateTime>? timeCreated,
    Expression<DateTime>? timeChanged,
    Expression<DateTime>? timeLastPlayed,
    Expression<bool>? excludeArtists,
    Expression<int>? blockLevel,
    Expression<int>? minLikeCount,
    Expression<int>? maxLikeCount,
    Expression<int>? minPlayCount,
    Expression<int>? maxPlayCount,
    Expression<int>? minSkipCount,
    Expression<int>? maxSkipCount,
    Expression<int>? minYear,
    Expression<int>? maxYear,
    Expression<int>? limit,
    Expression<String>? orderCriteria,
    Expression<String>? orderDirections,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shuffleMode != null) 'shuffle_mode': shuffleMode,
      if (icon != null) 'icon': icon,
      if (gradient != null) 'gradient': gradient,
      if (timeCreated != null) 'time_created': timeCreated,
      if (timeChanged != null) 'time_changed': timeChanged,
      if (timeLastPlayed != null) 'time_last_played': timeLastPlayed,
      if (excludeArtists != null) 'exclude_artists': excludeArtists,
      if (blockLevel != null) 'block_level': blockLevel,
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
      Value<String>? icon,
      Value<String>? gradient,
      Value<DateTime>? timeCreated,
      Value<DateTime>? timeChanged,
      Value<DateTime>? timeLastPlayed,
      Value<bool>? excludeArtists,
      Value<int>? blockLevel,
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
      icon: icon ?? this.icon,
      gradient: gradient ?? this.gradient,
      timeCreated: timeCreated ?? this.timeCreated,
      timeChanged: timeChanged ?? this.timeChanged,
      timeLastPlayed: timeLastPlayed ?? this.timeLastPlayed,
      excludeArtists: excludeArtists ?? this.excludeArtists,
      blockLevel: blockLevel ?? this.blockLevel,
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
      map['shuffle_mode'] = Variable<String>(shuffleMode.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (gradient.present) {
      map['gradient'] = Variable<String>(gradient.value);
    }
    if (timeCreated.present) {
      map['time_created'] = Variable<DateTime>(timeCreated.value);
    }
    if (timeChanged.present) {
      map['time_changed'] = Variable<DateTime>(timeChanged.value);
    }
    if (timeLastPlayed.present) {
      map['time_last_played'] = Variable<DateTime>(timeLastPlayed.value);
    }
    if (excludeArtists.present) {
      map['exclude_artists'] = Variable<bool>(excludeArtists.value);
    }
    if (blockLevel.present) {
      map['block_level'] = Variable<int>(blockLevel.value);
    }
    if (minLikeCount.present) {
      map['min_like_count'] = Variable<int>(minLikeCount.value);
    }
    if (maxLikeCount.present) {
      map['max_like_count'] = Variable<int>(maxLikeCount.value);
    }
    if (minPlayCount.present) {
      map['min_play_count'] = Variable<int>(minPlayCount.value);
    }
    if (maxPlayCount.present) {
      map['max_play_count'] = Variable<int>(maxPlayCount.value);
    }
    if (minSkipCount.present) {
      map['min_skip_count'] = Variable<int>(minSkipCount.value);
    }
    if (maxSkipCount.present) {
      map['max_skip_count'] = Variable<int>(maxSkipCount.value);
    }
    if (minYear.present) {
      map['min_year'] = Variable<int>(minYear.value);
    }
    if (maxYear.present) {
      map['max_year'] = Variable<int>(maxYear.value);
    }
    if (limit.present) {
      map['limit'] = Variable<int>(limit.value);
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
          ..write('icon: $icon, ')
          ..write('gradient: $gradient, ')
          ..write('timeCreated: $timeCreated, ')
          ..write('timeChanged: $timeChanged, ')
          ..write('timeLastPlayed: $timeLastPlayed, ')
          ..write('excludeArtists: $excludeArtists, ')
          ..write('blockLevel: $blockLevel, ')
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

class $SmartListArtistsTable extends SmartListArtists
    with TableInfo<$SmartListArtistsTable, DriftSmartListArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartListArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _smartListIdMeta =
      const VerificationMeta('smartListId');
  @override
  late final GeneratedColumn<int> smartListId = GeneratedColumn<int>(
      'smart_list_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _artistNameMeta =
      const VerificationMeta('artistName');
  @override
  late final GeneratedColumn<String> artistName = GeneratedColumn<String>(
      'artist_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [smartListId, artistName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_list_artists';
  @override
  VerificationContext validateIntegrity(
      Insertable<DriftSmartListArtist> instance,
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DriftSmartListArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftSmartListArtist(
      smartListId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}smart_list_id'])!,
      artistName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist_name'])!,
    );
  }

  @override
  $SmartListArtistsTable createAlias(String alias) {
    return $SmartListArtistsTable(attachedDatabase, alias);
  }
}

class DriftSmartListArtist extends DataClass
    implements Insertable<DriftSmartListArtist> {
  final int smartListId;
  final String artistName;
  const DriftSmartListArtist(
      {required this.smartListId, required this.artistName});
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

  factory DriftSmartListArtist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftSmartListArtist(
      smartListId: serializer.fromJson<int>(json['smartListId']),
      artistName: serializer.fromJson<String>(json['artistName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'smartListId': serializer.toJson<int>(smartListId),
      'artistName': serializer.toJson<String>(artistName),
    };
  }

  DriftSmartListArtist copyWith({int? smartListId, String? artistName}) =>
      DriftSmartListArtist(
        smartListId: smartListId ?? this.smartListId,
        artistName: artistName ?? this.artistName,
      );
  DriftSmartListArtist copyWithCompanion(SmartListArtistsCompanion data) {
    return DriftSmartListArtist(
      smartListId:
          data.smartListId.present ? data.smartListId.value : this.smartListId,
      artistName:
          data.artistName.present ? data.artistName.value : this.artistName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftSmartListArtist(')
          ..write('smartListId: $smartListId, ')
          ..write('artistName: $artistName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(smartListId, artistName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftSmartListArtist &&
          other.smartListId == this.smartListId &&
          other.artistName == this.artistName);
}

class SmartListArtistsCompanion extends UpdateCompanion<DriftSmartListArtist> {
  final Value<int> smartListId;
  final Value<String> artistName;
  final Value<int> rowid;
  const SmartListArtistsCompanion({
    this.smartListId = const Value.absent(),
    this.artistName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmartListArtistsCompanion.insert({
    required int smartListId,
    required String artistName,
    this.rowid = const Value.absent(),
  })  : smartListId = Value(smartListId),
        artistName = Value(artistName);
  static Insertable<DriftSmartListArtist> custom({
    Expression<int>? smartListId,
    Expression<String>? artistName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (smartListId != null) 'smart_list_id': smartListId,
      if (artistName != null) 'artist_name': artistName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmartListArtistsCompanion copyWith(
      {Value<int>? smartListId, Value<String>? artistName, Value<int>? rowid}) {
    return SmartListArtistsCompanion(
      smartListId: smartListId ?? this.smartListId,
      artistName: artistName ?? this.artistName,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartListArtistsCompanion(')
          ..write('smartListId: $smartListId, ')
          ..write('artistName: $artistName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, DriftPlaylist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shuffleModeMeta =
      const VerificationMeta('shuffleMode');
  @override
  late final GeneratedColumn<String> shuffleMode = GeneratedColumn<String>(
      'shuffle_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('queue_music_rounded'));
  static const VerificationMeta _gradientMeta =
      const VerificationMeta('gradient');
  @override
  late final GeneratedColumn<String> gradient = GeneratedColumn<String>(
      'gradient', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('oceanblue'));
  static const VerificationMeta _timeCreatedMeta =
      const VerificationMeta('timeCreated');
  @override
  late final GeneratedColumn<DateTime> timeCreated = GeneratedColumn<DateTime>(
      'time_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _timeChangedMeta =
      const VerificationMeta('timeChanged');
  @override
  late final GeneratedColumn<DateTime> timeChanged = GeneratedColumn<DateTime>(
      'time_changed', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _timeLastPlayedMeta =
      const VerificationMeta('timeLastPlayed');
  @override
  late final GeneratedColumn<DateTime> timeLastPlayed =
      GeneratedColumn<DateTime>('time_last_played', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.fromMillisecondsSinceEpoch(0)));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        shuffleMode,
        icon,
        gradient,
        timeCreated,
        timeChanged,
        timeLastPlayed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<DriftPlaylist> instance,
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
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('gradient')) {
      context.handle(_gradientMeta,
          gradient.isAcceptableOrUnknown(data['gradient']!, _gradientMeta));
    }
    if (data.containsKey('time_created')) {
      context.handle(
          _timeCreatedMeta,
          timeCreated.isAcceptableOrUnknown(
              data['time_created']!, _timeCreatedMeta));
    }
    if (data.containsKey('time_changed')) {
      context.handle(
          _timeChangedMeta,
          timeChanged.isAcceptableOrUnknown(
              data['time_changed']!, _timeChangedMeta));
    }
    if (data.containsKey('time_last_played')) {
      context.handle(
          _timeLastPlayedMeta,
          timeLastPlayed.isAcceptableOrUnknown(
              data['time_last_played']!, _timeLastPlayedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftPlaylist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftPlaylist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      shuffleMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shuffle_mode']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      gradient: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gradient'])!,
      timeCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_created'])!,
      timeChanged: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_changed'])!,
      timeLastPlayed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}time_last_played'])!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class DriftPlaylist extends DataClass implements Insertable<DriftPlaylist> {
  final int id;
  final String name;
  final String? shuffleMode;
  final String icon;
  final String gradient;
  final DateTime timeCreated;
  final DateTime timeChanged;
  final DateTime timeLastPlayed;
  const DriftPlaylist(
      {required this.id,
      required this.name,
      this.shuffleMode,
      required this.icon,
      required this.gradient,
      required this.timeCreated,
      required this.timeChanged,
      required this.timeLastPlayed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || shuffleMode != null) {
      map['shuffle_mode'] = Variable<String>(shuffleMode);
    }
    map['icon'] = Variable<String>(icon);
    map['gradient'] = Variable<String>(gradient);
    map['time_created'] = Variable<DateTime>(timeCreated);
    map['time_changed'] = Variable<DateTime>(timeChanged);
    map['time_last_played'] = Variable<DateTime>(timeLastPlayed);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      shuffleMode: shuffleMode == null && nullToAbsent
          ? const Value.absent()
          : Value(shuffleMode),
      icon: Value(icon),
      gradient: Value(gradient),
      timeCreated: Value(timeCreated),
      timeChanged: Value(timeChanged),
      timeLastPlayed: Value(timeLastPlayed),
    );
  }

  factory DriftPlaylist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftPlaylist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shuffleMode: serializer.fromJson<String?>(json['shuffleMode']),
      icon: serializer.fromJson<String>(json['icon']),
      gradient: serializer.fromJson<String>(json['gradient']),
      timeCreated: serializer.fromJson<DateTime>(json['timeCreated']),
      timeChanged: serializer.fromJson<DateTime>(json['timeChanged']),
      timeLastPlayed: serializer.fromJson<DateTime>(json['timeLastPlayed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'shuffleMode': serializer.toJson<String?>(shuffleMode),
      'icon': serializer.toJson<String>(icon),
      'gradient': serializer.toJson<String>(gradient),
      'timeCreated': serializer.toJson<DateTime>(timeCreated),
      'timeChanged': serializer.toJson<DateTime>(timeChanged),
      'timeLastPlayed': serializer.toJson<DateTime>(timeLastPlayed),
    };
  }

  DriftPlaylist copyWith(
          {int? id,
          String? name,
          Value<String?> shuffleMode = const Value.absent(),
          String? icon,
          String? gradient,
          DateTime? timeCreated,
          DateTime? timeChanged,
          DateTime? timeLastPlayed}) =>
      DriftPlaylist(
        id: id ?? this.id,
        name: name ?? this.name,
        shuffleMode: shuffleMode.present ? shuffleMode.value : this.shuffleMode,
        icon: icon ?? this.icon,
        gradient: gradient ?? this.gradient,
        timeCreated: timeCreated ?? this.timeCreated,
        timeChanged: timeChanged ?? this.timeChanged,
        timeLastPlayed: timeLastPlayed ?? this.timeLastPlayed,
      );
  DriftPlaylist copyWithCompanion(PlaylistsCompanion data) {
    return DriftPlaylist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shuffleMode:
          data.shuffleMode.present ? data.shuffleMode.value : this.shuffleMode,
      icon: data.icon.present ? data.icon.value : this.icon,
      gradient: data.gradient.present ? data.gradient.value : this.gradient,
      timeCreated:
          data.timeCreated.present ? data.timeCreated.value : this.timeCreated,
      timeChanged:
          data.timeChanged.present ? data.timeChanged.value : this.timeChanged,
      timeLastPlayed: data.timeLastPlayed.present
          ? data.timeLastPlayed.value
          : this.timeLastPlayed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftPlaylist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shuffleMode: $shuffleMode, ')
          ..write('icon: $icon, ')
          ..write('gradient: $gradient, ')
          ..write('timeCreated: $timeCreated, ')
          ..write('timeChanged: $timeChanged, ')
          ..write('timeLastPlayed: $timeLastPlayed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, shuffleMode, icon, gradient,
      timeCreated, timeChanged, timeLastPlayed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftPlaylist &&
          other.id == this.id &&
          other.name == this.name &&
          other.shuffleMode == this.shuffleMode &&
          other.icon == this.icon &&
          other.gradient == this.gradient &&
          other.timeCreated == this.timeCreated &&
          other.timeChanged == this.timeChanged &&
          other.timeLastPlayed == this.timeLastPlayed);
}

class PlaylistsCompanion extends UpdateCompanion<DriftPlaylist> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> shuffleMode;
  final Value<String> icon;
  final Value<String> gradient;
  final Value<DateTime> timeCreated;
  final Value<DateTime> timeChanged;
  final Value<DateTime> timeLastPlayed;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shuffleMode = const Value.absent(),
    this.icon = const Value.absent(),
    this.gradient = const Value.absent(),
    this.timeCreated = const Value.absent(),
    this.timeChanged = const Value.absent(),
    this.timeLastPlayed = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.shuffleMode = const Value.absent(),
    this.icon = const Value.absent(),
    this.gradient = const Value.absent(),
    this.timeCreated = const Value.absent(),
    this.timeChanged = const Value.absent(),
    this.timeLastPlayed = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DriftPlaylist> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? shuffleMode,
    Expression<String>? icon,
    Expression<String>? gradient,
    Expression<DateTime>? timeCreated,
    Expression<DateTime>? timeChanged,
    Expression<DateTime>? timeLastPlayed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shuffleMode != null) 'shuffle_mode': shuffleMode,
      if (icon != null) 'icon': icon,
      if (gradient != null) 'gradient': gradient,
      if (timeCreated != null) 'time_created': timeCreated,
      if (timeChanged != null) 'time_changed': timeChanged,
      if (timeLastPlayed != null) 'time_last_played': timeLastPlayed,
    });
  }

  PlaylistsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? shuffleMode,
      Value<String>? icon,
      Value<String>? gradient,
      Value<DateTime>? timeCreated,
      Value<DateTime>? timeChanged,
      Value<DateTime>? timeLastPlayed}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shuffleMode: shuffleMode ?? this.shuffleMode,
      icon: icon ?? this.icon,
      gradient: gradient ?? this.gradient,
      timeCreated: timeCreated ?? this.timeCreated,
      timeChanged: timeChanged ?? this.timeChanged,
      timeLastPlayed: timeLastPlayed ?? this.timeLastPlayed,
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
      map['shuffle_mode'] = Variable<String>(shuffleMode.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (gradient.present) {
      map['gradient'] = Variable<String>(gradient.value);
    }
    if (timeCreated.present) {
      map['time_created'] = Variable<DateTime>(timeCreated.value);
    }
    if (timeChanged.present) {
      map['time_changed'] = Variable<DateTime>(timeChanged.value);
    }
    if (timeLastPlayed.present) {
      map['time_last_played'] = Variable<DateTime>(timeLastPlayed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shuffleMode: $shuffleMode, ')
          ..write('icon: $icon, ')
          ..write('gradient: $gradient, ')
          ..write('timeCreated: $timeCreated, ')
          ..write('timeChanged: $timeChanged, ')
          ..write('timeLastPlayed: $timeLastPlayed')
          ..write(')'))
        .toString();
  }
}

class $PlaylistEntriesTable extends PlaylistEntries
    with TableInfo<$PlaylistEntriesTable, DriftPlaylistEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _songPathMeta =
      const VerificationMeta('songPath');
  @override
  late final GeneratedColumn<String> songPath = GeneratedColumn<String>(
      'song_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [playlistId, songPath, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DriftPlaylistEntry> instance,
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DriftPlaylistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftPlaylistEntry(
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}playlist_id'])!,
      songPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_path'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $PlaylistEntriesTable createAlias(String alias) {
    return $PlaylistEntriesTable(attachedDatabase, alias);
  }
}

class DriftPlaylistEntry extends DataClass
    implements Insertable<DriftPlaylistEntry> {
  final int playlistId;
  final String songPath;
  final int position;
  const DriftPlaylistEntry(
      {required this.playlistId,
      required this.songPath,
      required this.position});
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

  factory DriftPlaylistEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftPlaylistEntry(
      playlistId: serializer.fromJson<int>(json['playlistId']),
      songPath: serializer.fromJson<String>(json['songPath']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<int>(playlistId),
      'songPath': serializer.toJson<String>(songPath),
      'position': serializer.toJson<int>(position),
    };
  }

  DriftPlaylistEntry copyWith(
          {int? playlistId, String? songPath, int? position}) =>
      DriftPlaylistEntry(
        playlistId: playlistId ?? this.playlistId,
        songPath: songPath ?? this.songPath,
        position: position ?? this.position,
      );
  DriftPlaylistEntry copyWithCompanion(PlaylistEntriesCompanion data) {
    return DriftPlaylistEntry(
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      songPath: data.songPath.present ? data.songPath.value : this.songPath,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftPlaylistEntry(')
          ..write('playlistId: $playlistId, ')
          ..write('songPath: $songPath, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, songPath, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftPlaylistEntry &&
          other.playlistId == this.playlistId &&
          other.songPath == this.songPath &&
          other.position == this.position);
}

class PlaylistEntriesCompanion extends UpdateCompanion<DriftPlaylistEntry> {
  final Value<int> playlistId;
  final Value<String> songPath;
  final Value<int> position;
  final Value<int> rowid;
  const PlaylistEntriesCompanion({
    this.playlistId = const Value.absent(),
    this.songPath = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistEntriesCompanion.insert({
    required int playlistId,
    required String songPath,
    required int position,
    this.rowid = const Value.absent(),
  })  : playlistId = Value(playlistId),
        songPath = Value(songPath),
        position = Value(position);
  static Insertable<DriftPlaylistEntry> custom({
    Expression<int>? playlistId,
    Expression<String>? songPath,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (songPath != null) 'song_path': songPath,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistEntriesCompanion copyWith(
      {Value<int>? playlistId,
      Value<String>? songPath,
      Value<int>? position,
      Value<int>? rowid}) {
    return PlaylistEntriesCompanion(
      playlistId: playlistId ?? this.playlistId,
      songPath: songPath ?? this.songPath,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistEntriesCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('songPath: $songPath, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KeyValueEntriesTable extends KeyValueEntries
    with TableInfo<$KeyValueEntriesTable, KeyValueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_value_entries';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueEntry(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $KeyValueEntriesTable createAlias(String alias) {
    return $KeyValueEntriesTable(attachedDatabase, alias);
  }
}

class KeyValueEntry extends DataClass implements Insertable<KeyValueEntry> {
  final String key;
  final String value;
  const KeyValueEntry({required this.key, required this.value});
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValueEntry copyWith({String? key, String? value}) => KeyValueEntry(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  KeyValueEntry copyWithCompanion(KeyValueEntriesCompanion data) {
    return KeyValueEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
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
  final Value<int> rowid;
  const KeyValueEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueEntriesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<KeyValueEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValueEntriesCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return KeyValueEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HomeWidgetsTable extends HomeWidgets
    with TableInfo<$HomeWidgetsTable, DriftHomeWidget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeWidgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [position, type, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_widgets';
  @override
  VerificationContext validateIntegrity(Insertable<DriftHomeWidget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {position};
  @override
  DriftHomeWidget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftHomeWidget(
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $HomeWidgetsTable createAlias(String alias) {
    return $HomeWidgetsTable(attachedDatabase, alias);
  }
}

class DriftHomeWidget extends DataClass implements Insertable<DriftHomeWidget> {
  final int position;
  final String type;
  final String data;
  const DriftHomeWidget(
      {required this.position, required this.type, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['position'] = Variable<int>(position);
    map['type'] = Variable<String>(type);
    map['data'] = Variable<String>(data);
    return map;
  }

  HomeWidgetsCompanion toCompanion(bool nullToAbsent) {
    return HomeWidgetsCompanion(
      position: Value(position),
      type: Value(type),
      data: Value(data),
    );
  }

  factory DriftHomeWidget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftHomeWidget(
      position: serializer.fromJson<int>(json['position']),
      type: serializer.fromJson<String>(json['type']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'type': serializer.toJson<String>(type),
      'data': serializer.toJson<String>(data),
    };
  }

  DriftHomeWidget copyWith({int? position, String? type, String? data}) =>
      DriftHomeWidget(
        position: position ?? this.position,
        type: type ?? this.type,
        data: data ?? this.data,
      );
  DriftHomeWidget copyWithCompanion(HomeWidgetsCompanion data) {
    return DriftHomeWidget(
      position: data.position.present ? data.position.value : this.position,
      type: data.type.present ? data.type.value : this.type,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftHomeWidget(')
          ..write('position: $position, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(position, type, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftHomeWidget &&
          other.position == this.position &&
          other.type == this.type &&
          other.data == this.data);
}

class HomeWidgetsCompanion extends UpdateCompanion<DriftHomeWidget> {
  final Value<int> position;
  final Value<String> type;
  final Value<String> data;
  const HomeWidgetsCompanion({
    this.position = const Value.absent(),
    this.type = const Value.absent(),
    this.data = const Value.absent(),
  });
  HomeWidgetsCompanion.insert({
    this.position = const Value.absent(),
    required String type,
    this.data = const Value.absent(),
  }) : type = Value(type);
  static Insertable<DriftHomeWidget> custom({
    Expression<int>? position,
    Expression<String>? type,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (type != null) 'type': type,
      if (data != null) 'data': data,
    });
  }

  HomeWidgetsCompanion copyWith(
      {Value<int>? position, Value<String>? type, Value<String>? data}) {
    return HomeWidgetsCompanion(
      position: position ?? this.position,
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeWidgetsCompanion(')
          ..write('position: $position, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $HistoryEntriesTable extends HistoryEntries
    with TableInfo<$HistoryEntriesTable, DriftHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _identifierMeta =
      const VerificationMeta('identifier');
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
      'identifier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [time, type, identifier];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DriftHistoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('identifier')) {
      context.handle(
          _identifierMeta,
          identifier.isAcceptableOrUnknown(
              data['identifier']!, _identifierMeta));
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DriftHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftHistoryEntry(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      identifier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}identifier'])!,
    );
  }

  @override
  $HistoryEntriesTable createAlias(String alias) {
    return $HistoryEntriesTable(attachedDatabase, alias);
  }
}

class DriftHistoryEntry extends DataClass
    implements Insertable<DriftHistoryEntry> {
  final DateTime time;
  final String type;
  final String identifier;
  const DriftHistoryEntry(
      {required this.time, required this.type, required this.identifier});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['type'] = Variable<String>(type);
    map['identifier'] = Variable<String>(identifier);
    return map;
  }

  HistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return HistoryEntriesCompanion(
      time: Value(time),
      type: Value(type),
      identifier: Value(identifier),
    );
  }

  factory DriftHistoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftHistoryEntry(
      time: serializer.fromJson<DateTime>(json['time']),
      type: serializer.fromJson<String>(json['type']),
      identifier: serializer.fromJson<String>(json['identifier']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'type': serializer.toJson<String>(type),
      'identifier': serializer.toJson<String>(identifier),
    };
  }

  DriftHistoryEntry copyWith(
          {DateTime? time, String? type, String? identifier}) =>
      DriftHistoryEntry(
        time: time ?? this.time,
        type: type ?? this.type,
        identifier: identifier ?? this.identifier,
      );
  DriftHistoryEntry copyWithCompanion(HistoryEntriesCompanion data) {
    return DriftHistoryEntry(
      time: data.time.present ? data.time.value : this.time,
      type: data.type.present ? data.type.value : this.type,
      identifier:
          data.identifier.present ? data.identifier.value : this.identifier,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftHistoryEntry(')
          ..write('time: $time, ')
          ..write('type: $type, ')
          ..write('identifier: $identifier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(time, type, identifier);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftHistoryEntry &&
          other.time == this.time &&
          other.type == this.type &&
          other.identifier == this.identifier);
}

class HistoryEntriesCompanion extends UpdateCompanion<DriftHistoryEntry> {
  final Value<DateTime> time;
  final Value<String> type;
  final Value<String> identifier;
  final Value<int> rowid;
  const HistoryEntriesCompanion({
    this.time = const Value.absent(),
    this.type = const Value.absent(),
    this.identifier = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistoryEntriesCompanion.insert({
    this.time = const Value.absent(),
    required String type,
    required String identifier,
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        identifier = Value(identifier);
  static Insertable<DriftHistoryEntry> custom({
    Expression<DateTime>? time,
    Expression<String>? type,
    Expression<String>? identifier,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (type != null) 'type': type,
      if (identifier != null) 'identifier': identifier,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistoryEntriesCompanion copyWith(
      {Value<DateTime>? time,
      Value<String>? type,
      Value<String>? identifier,
      Value<int>? rowid}) {
    return HistoryEntriesCompanion(
      time: time ?? this.time,
      type: type ?? this.type,
      identifier: identifier ?? this.identifier,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntriesCompanion(')
          ..write('time: $time, ')
          ..write('type: $type, ')
          ..write('identifier: $identifier, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlockedFilesTable extends BlockedFiles
    with TableInfo<$BlockedFilesTable, BlockedFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockedFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocked_files';
  @override
  VerificationContext validateIntegrity(Insertable<BlockedFile> instance,
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
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  BlockedFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockedFile(
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
    );
  }

  @override
  $BlockedFilesTable createAlias(String alias) {
    return $BlockedFilesTable(attachedDatabase, alias);
  }
}

class BlockedFile extends DataClass implements Insertable<BlockedFile> {
  final String path;
  const BlockedFile({required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['path'] = Variable<String>(path);
    return map;
  }

  BlockedFilesCompanion toCompanion(bool nullToAbsent) {
    return BlockedFilesCompanion(
      path: Value(path),
    );
  }

  factory BlockedFile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockedFile(
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
    };
  }

  BlockedFile copyWith({String? path}) => BlockedFile(
        path: path ?? this.path,
      );
  BlockedFile copyWithCompanion(BlockedFilesCompanion data) {
    return BlockedFile(
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockedFile(')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => path.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockedFile && other.path == this.path);
}

class BlockedFilesCompanion extends UpdateCompanion<BlockedFile> {
  final Value<String> path;
  final Value<int> rowid;
  const BlockedFilesCompanion({
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlockedFilesCompanion.insert({
    required String path,
    this.rowid = const Value.absent(),
  }) : path = Value(path);
  static Insertable<BlockedFile> custom({
    Expression<String>? path,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlockedFilesCompanion copyWith({Value<String>? path, Value<int>? rowid}) {
    return BlockedFilesCompanion(
      path: path ?? this.path,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockedFilesCompanion(')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MainDatabase extends GeneratedDatabase {
  _$MainDatabase(QueryExecutor e) : super(e);
  $MainDatabaseManager get managers => $MainDatabaseManager(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $ArtistsTable artists = $ArtistsTable(this);
  late final $LibraryFoldersTable libraryFolders = $LibraryFoldersTable(this);
  late final $QueueEntriesTable queueEntries = $QueueEntriesTable(this);
  late final $AvailableSongEntriesTable availableSongEntries =
      $AvailableSongEntriesTable(this);
  late final $SongsTable songs = $SongsTable(this);
  late final $SmartListsTable smartLists = $SmartListsTable(this);
  late final $SmartListArtistsTable smartListArtists =
      $SmartListArtistsTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistEntriesTable playlistEntries =
      $PlaylistEntriesTable(this);
  late final $KeyValueEntriesTable keyValueEntries =
      $KeyValueEntriesTable(this);
  late final $HomeWidgetsTable homeWidgets = $HomeWidgetsTable(this);
  late final $HistoryEntriesTable historyEntries = $HistoryEntriesTable(this);
  late final $BlockedFilesTable blockedFiles = $BlockedFilesTable(this);
  late final PersistentStateDao persistentStateDao =
      PersistentStateDao(this as MainDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as MainDatabase);
  late final MusicDataDao musicDataDao = MusicDataDao(this as MainDatabase);
  late final PlaylistDao playlistDao = PlaylistDao(this as MainDatabase);
  late final HomeWidgetDao homeWidgetDao = HomeWidgetDao(this as MainDatabase);
  late final HistoryDao historyDao = HistoryDao(this as MainDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        albums,
        artists,
        libraryFolders,
        queueEntries,
        availableSongEntries,
        songs,
        smartLists,
        smartListArtists,
        playlists,
        playlistEntries,
        keyValueEntries,
        homeWidgets,
        historyEntries,
        blockedFiles
      ];
}

typedef $$AlbumsTableCreateCompanionBuilder = AlbumsCompanion Function({
  Value<int> id,
  required String title,
  required String artist,
  Value<String?> albumArtPath,
  Value<int?> color,
  Value<int?> year,
});
typedef $$AlbumsTableUpdateCompanionBuilder = AlbumsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String?> albumArtPath,
  Value<int?> color,
  Value<int?> year,
});

class $$AlbumsTableFilterComposer
    extends Composer<_$MainDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));
}

class $$AlbumsTableOrderingComposer
    extends Composer<_$MainDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));
}

class $$AlbumsTableAnnotationComposer
    extends Composer<_$MainDatabase, $AlbumsTable> {
  $$AlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);
}

class $$AlbumsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $AlbumsTable,
    DriftAlbum,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (DriftAlbum, BaseReferences<_$MainDatabase, $AlbumsTable, DriftAlbum>),
    DriftAlbum,
    PrefetchHooks Function()> {
  $$AlbumsTableTableManager(_$MainDatabase db, $AlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String?> albumArtPath = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<int?> year = const Value.absent(),
          }) =>
              AlbumsCompanion(
            id: id,
            title: title,
            artist: artist,
            albumArtPath: albumArtPath,
            color: color,
            year: year,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            Value<String?> albumArtPath = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<int?> year = const Value.absent(),
          }) =>
              AlbumsCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            albumArtPath: albumArtPath,
            color: color,
            year: year,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlbumsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $AlbumsTable,
    DriftAlbum,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (DriftAlbum, BaseReferences<_$MainDatabase, $AlbumsTable, DriftAlbum>),
    DriftAlbum,
    PrefetchHooks Function()>;
typedef $$ArtistsTableCreateCompanionBuilder = ArtistsCompanion Function({
  required String name,
  Value<int> id,
});
typedef $$ArtistsTableUpdateCompanionBuilder = ArtistsCompanion Function({
  Value<String> name,
  Value<int> id,
});

class $$ArtistsTableFilterComposer
    extends Composer<_$MainDatabase, $ArtistsTable> {
  $$ArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));
}

class $$ArtistsTableOrderingComposer
    extends Composer<_$MainDatabase, $ArtistsTable> {
  $$ArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));
}

class $$ArtistsTableAnnotationComposer
    extends Composer<_$MainDatabase, $ArtistsTable> {
  $$ArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$ArtistsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $ArtistsTable,
    DriftArtist,
    $$ArtistsTableFilterComposer,
    $$ArtistsTableOrderingComposer,
    $$ArtistsTableAnnotationComposer,
    $$ArtistsTableCreateCompanionBuilder,
    $$ArtistsTableUpdateCompanionBuilder,
    (DriftArtist, BaseReferences<_$MainDatabase, $ArtistsTable, DriftArtist>),
    DriftArtist,
    PrefetchHooks Function()> {
  $$ArtistsTableTableManager(_$MainDatabase db, $ArtistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<int> id = const Value.absent(),
          }) =>
              ArtistsCompanion(
            name: name,
            id: id,
          ),
          createCompanionCallback: ({
            required String name,
            Value<int> id = const Value.absent(),
          }) =>
              ArtistsCompanion.insert(
            name: name,
            id: id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArtistsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $ArtistsTable,
    DriftArtist,
    $$ArtistsTableFilterComposer,
    $$ArtistsTableOrderingComposer,
    $$ArtistsTableAnnotationComposer,
    $$ArtistsTableCreateCompanionBuilder,
    $$ArtistsTableUpdateCompanionBuilder,
    (DriftArtist, BaseReferences<_$MainDatabase, $ArtistsTable, DriftArtist>),
    DriftArtist,
    PrefetchHooks Function()>;
typedef $$LibraryFoldersTableCreateCompanionBuilder = LibraryFoldersCompanion
    Function({
  required String path,
  Value<int> rowid,
});
typedef $$LibraryFoldersTableUpdateCompanionBuilder = LibraryFoldersCompanion
    Function({
  Value<String> path,
  Value<int> rowid,
});

class $$LibraryFoldersTableFilterComposer
    extends Composer<_$MainDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));
}

class $$LibraryFoldersTableOrderingComposer
    extends Composer<_$MainDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));
}

class $$LibraryFoldersTableAnnotationComposer
    extends Composer<_$MainDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$LibraryFoldersTableTableManager extends RootTableManager<
    _$MainDatabase,
    $LibraryFoldersTable,
    LibraryFolder,
    $$LibraryFoldersTableFilterComposer,
    $$LibraryFoldersTableOrderingComposer,
    $$LibraryFoldersTableAnnotationComposer,
    $$LibraryFoldersTableCreateCompanionBuilder,
    $$LibraryFoldersTableUpdateCompanionBuilder,
    (
      LibraryFolder,
      BaseReferences<_$MainDatabase, $LibraryFoldersTable, LibraryFolder>
    ),
    LibraryFolder,
    PrefetchHooks Function()> {
  $$LibraryFoldersTableTableManager(
      _$MainDatabase db, $LibraryFoldersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> path = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryFoldersCompanion(
            path: path,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String path,
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryFoldersCompanion.insert(
            path: path,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LibraryFoldersTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $LibraryFoldersTable,
    LibraryFolder,
    $$LibraryFoldersTableFilterComposer,
    $$LibraryFoldersTableOrderingComposer,
    $$LibraryFoldersTableAnnotationComposer,
    $$LibraryFoldersTableCreateCompanionBuilder,
    $$LibraryFoldersTableUpdateCompanionBuilder,
    (
      LibraryFolder,
      BaseReferences<_$MainDatabase, $LibraryFoldersTable, LibraryFolder>
    ),
    LibraryFolder,
    PrefetchHooks Function()>;
typedef $$QueueEntriesTableCreateCompanionBuilder = QueueEntriesCompanion
    Function({
  Value<int> index,
  required String path,
  required int originalIndex,
  required int type,
  required bool isAvailable,
});
typedef $$QueueEntriesTableUpdateCompanionBuilder = QueueEntriesCompanion
    Function({
  Value<int> index,
  Value<String> path,
  Value<int> originalIndex,
  Value<int> type,
  Value<bool> isAvailable,
});

class $$QueueEntriesTableFilterComposer
    extends Composer<_$MainDatabase, $QueueEntriesTable> {
  $$QueueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnFilters(column));
}

class $$QueueEntriesTableOrderingComposer
    extends Composer<_$MainDatabase, $QueueEntriesTable> {
  $$QueueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnOrderings(column));
}

class $$QueueEntriesTableAnnotationComposer
    extends Composer<_$MainDatabase, $QueueEntriesTable> {
  $$QueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => column);
}

class $$QueueEntriesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $QueueEntriesTable,
    DriftQueueEntry,
    $$QueueEntriesTableFilterComposer,
    $$QueueEntriesTableOrderingComposer,
    $$QueueEntriesTableAnnotationComposer,
    $$QueueEntriesTableCreateCompanionBuilder,
    $$QueueEntriesTableUpdateCompanionBuilder,
    (
      DriftQueueEntry,
      BaseReferences<_$MainDatabase, $QueueEntriesTable, DriftQueueEntry>
    ),
    DriftQueueEntry,
    PrefetchHooks Function()> {
  $$QueueEntriesTableTableManager(_$MainDatabase db, $QueueEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueueEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueueEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> index = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> originalIndex = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<bool> isAvailable = const Value.absent(),
          }) =>
              QueueEntriesCompanion(
            index: index,
            path: path,
            originalIndex: originalIndex,
            type: type,
            isAvailable: isAvailable,
          ),
          createCompanionCallback: ({
            Value<int> index = const Value.absent(),
            required String path,
            required int originalIndex,
            required int type,
            required bool isAvailable,
          }) =>
              QueueEntriesCompanion.insert(
            index: index,
            path: path,
            originalIndex: originalIndex,
            type: type,
            isAvailable: isAvailable,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QueueEntriesTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $QueueEntriesTable,
    DriftQueueEntry,
    $$QueueEntriesTableFilterComposer,
    $$QueueEntriesTableOrderingComposer,
    $$QueueEntriesTableAnnotationComposer,
    $$QueueEntriesTableCreateCompanionBuilder,
    $$QueueEntriesTableUpdateCompanionBuilder,
    (
      DriftQueueEntry,
      BaseReferences<_$MainDatabase, $QueueEntriesTable, DriftQueueEntry>
    ),
    DriftQueueEntry,
    PrefetchHooks Function()>;
typedef $$AvailableSongEntriesTableCreateCompanionBuilder
    = AvailableSongEntriesCompanion Function({
  Value<int> index,
  required String path,
  required int originalIndex,
  required int type,
  required bool isAvailable,
});
typedef $$AvailableSongEntriesTableUpdateCompanionBuilder
    = AvailableSongEntriesCompanion Function({
  Value<int> index,
  Value<String> path,
  Value<int> originalIndex,
  Value<int> type,
  Value<bool> isAvailable,
});

class $$AvailableSongEntriesTableFilterComposer
    extends Composer<_$MainDatabase, $AvailableSongEntriesTable> {
  $$AvailableSongEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnFilters(column));
}

class $$AvailableSongEntriesTableOrderingComposer
    extends Composer<_$MainDatabase, $AvailableSongEntriesTable> {
  $$AvailableSongEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnOrderings(column));
}

class $$AvailableSongEntriesTableAnnotationComposer
    extends Composer<_$MainDatabase, $AvailableSongEntriesTable> {
  $$AvailableSongEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get originalIndex => $composableBuilder(
      column: $table.originalIndex, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => column);
}

class $$AvailableSongEntriesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $AvailableSongEntriesTable,
    AvailableSongEntry,
    $$AvailableSongEntriesTableFilterComposer,
    $$AvailableSongEntriesTableOrderingComposer,
    $$AvailableSongEntriesTableAnnotationComposer,
    $$AvailableSongEntriesTableCreateCompanionBuilder,
    $$AvailableSongEntriesTableUpdateCompanionBuilder,
    (
      AvailableSongEntry,
      BaseReferences<_$MainDatabase, $AvailableSongEntriesTable,
          AvailableSongEntry>
    ),
    AvailableSongEntry,
    PrefetchHooks Function()> {
  $$AvailableSongEntriesTableTableManager(
      _$MainDatabase db, $AvailableSongEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvailableSongEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvailableSongEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvailableSongEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> index = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> originalIndex = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<bool> isAvailable = const Value.absent(),
          }) =>
              AvailableSongEntriesCompanion(
            index: index,
            path: path,
            originalIndex: originalIndex,
            type: type,
            isAvailable: isAvailable,
          ),
          createCompanionCallback: ({
            Value<int> index = const Value.absent(),
            required String path,
            required int originalIndex,
            required int type,
            required bool isAvailable,
          }) =>
              AvailableSongEntriesCompanion.insert(
            index: index,
            path: path,
            originalIndex: originalIndex,
            type: type,
            isAvailable: isAvailable,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AvailableSongEntriesTableProcessedTableManager
    = ProcessedTableManager<
        _$MainDatabase,
        $AvailableSongEntriesTable,
        AvailableSongEntry,
        $$AvailableSongEntriesTableFilterComposer,
        $$AvailableSongEntriesTableOrderingComposer,
        $$AvailableSongEntriesTableAnnotationComposer,
        $$AvailableSongEntriesTableCreateCompanionBuilder,
        $$AvailableSongEntriesTableUpdateCompanionBuilder,
        (
          AvailableSongEntry,
          BaseReferences<_$MainDatabase, $AvailableSongEntriesTable,
              AvailableSongEntry>
        ),
        AvailableSongEntry,
        PrefetchHooks Function()>;
typedef $$SongsTableCreateCompanionBuilder = SongsCompanion Function({
  required String title,
  required String albumTitle,
  required int albumId,
  required String artist,
  required String path,
  required int duration,
  Value<String?> albumArtPath,
  Value<int?> color,
  required int discNumber,
  required int trackNumber,
  Value<int?> year,
  Value<int> blockLevel,
  Value<int> likeCount,
  Value<int> skipCount,
  Value<int> playCount,
  Value<bool> present,
  Value<DateTime> timeAdded,
  required DateTime lastModified,
  Value<bool> previous,
  Value<bool> next,
  Value<int> rowid,
});
typedef $$SongsTableUpdateCompanionBuilder = SongsCompanion Function({
  Value<String> title,
  Value<String> albumTitle,
  Value<int> albumId,
  Value<String> artist,
  Value<String> path,
  Value<int> duration,
  Value<String?> albumArtPath,
  Value<int?> color,
  Value<int> discNumber,
  Value<int> trackNumber,
  Value<int?> year,
  Value<int> blockLevel,
  Value<int> likeCount,
  Value<int> skipCount,
  Value<int> playCount,
  Value<bool> present,
  Value<DateTime> timeAdded,
  Value<DateTime> lastModified,
  Value<bool> previous,
  Value<bool> next,
  Value<int> rowid,
});

class $$SongsTableFilterComposer extends Composer<_$MainDatabase, $SongsTable> {
  $$SongsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get albumTitle => $composableBuilder(
      column: $table.albumTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get albumId => $composableBuilder(
      column: $table.albumId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discNumber => $composableBuilder(
      column: $table.discNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get skipCount => $composableBuilder(
      column: $table.skipCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get present => $composableBuilder(
      column: $table.present, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeAdded => $composableBuilder(
      column: $table.timeAdded, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get previous => $composableBuilder(
      column: $table.previous, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get next => $composableBuilder(
      column: $table.next, builder: (column) => ColumnFilters(column));
}

class $$SongsTableOrderingComposer
    extends Composer<_$MainDatabase, $SongsTable> {
  $$SongsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get albumTitle => $composableBuilder(
      column: $table.albumTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get albumId => $composableBuilder(
      column: $table.albumId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discNumber => $composableBuilder(
      column: $table.discNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get skipCount => $composableBuilder(
      column: $table.skipCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get present => $composableBuilder(
      column: $table.present, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeAdded => $composableBuilder(
      column: $table.timeAdded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get previous => $composableBuilder(
      column: $table.previous, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get next => $composableBuilder(
      column: $table.next, builder: (column) => ColumnOrderings(column));
}

class $$SongsTableAnnotationComposer
    extends Composer<_$MainDatabase, $SongsTable> {
  $$SongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get albumTitle => $composableBuilder(
      column: $table.albumTitle, builder: (column) => column);

  GeneratedColumn<int> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get albumArtPath => $composableBuilder(
      column: $table.albumArtPath, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get discNumber => $composableBuilder(
      column: $table.discNumber, builder: (column) => column);

  GeneratedColumn<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<int> get skipCount =>
      $composableBuilder(column: $table.skipCount, builder: (column) => column);

  GeneratedColumn<int> get playCount =>
      $composableBuilder(column: $table.playCount, builder: (column) => column);

  GeneratedColumn<bool> get present =>
      $composableBuilder(column: $table.present, builder: (column) => column);

  GeneratedColumn<DateTime> get timeAdded =>
      $composableBuilder(column: $table.timeAdded, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  GeneratedColumn<bool> get previous =>
      $composableBuilder(column: $table.previous, builder: (column) => column);

  GeneratedColumn<bool> get next =>
      $composableBuilder(column: $table.next, builder: (column) => column);
}

class $$SongsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $SongsTable,
    DriftSong,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (DriftSong, BaseReferences<_$MainDatabase, $SongsTable, DriftSong>),
    DriftSong,
    PrefetchHooks Function()> {
  $$SongsTableTableManager(_$MainDatabase db, $SongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> title = const Value.absent(),
            Value<String> albumTitle = const Value.absent(),
            Value<int> albumId = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<String?> albumArtPath = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<int> discNumber = const Value.absent(),
            Value<int> trackNumber = const Value.absent(),
            Value<int?> year = const Value.absent(),
            Value<int> blockLevel = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<int> skipCount = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<bool> present = const Value.absent(),
            Value<DateTime> timeAdded = const Value.absent(),
            Value<DateTime> lastModified = const Value.absent(),
            Value<bool> previous = const Value.absent(),
            Value<bool> next = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion(
            title: title,
            albumTitle: albumTitle,
            albumId: albumId,
            artist: artist,
            path: path,
            duration: duration,
            albumArtPath: albumArtPath,
            color: color,
            discNumber: discNumber,
            trackNumber: trackNumber,
            year: year,
            blockLevel: blockLevel,
            likeCount: likeCount,
            skipCount: skipCount,
            playCount: playCount,
            present: present,
            timeAdded: timeAdded,
            lastModified: lastModified,
            previous: previous,
            next: next,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String title,
            required String albumTitle,
            required int albumId,
            required String artist,
            required String path,
            required int duration,
            Value<String?> albumArtPath = const Value.absent(),
            Value<int?> color = const Value.absent(),
            required int discNumber,
            required int trackNumber,
            Value<int?> year = const Value.absent(),
            Value<int> blockLevel = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<int> skipCount = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<bool> present = const Value.absent(),
            Value<DateTime> timeAdded = const Value.absent(),
            required DateTime lastModified,
            Value<bool> previous = const Value.absent(),
            Value<bool> next = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion.insert(
            title: title,
            albumTitle: albumTitle,
            albumId: albumId,
            artist: artist,
            path: path,
            duration: duration,
            albumArtPath: albumArtPath,
            color: color,
            discNumber: discNumber,
            trackNumber: trackNumber,
            year: year,
            blockLevel: blockLevel,
            likeCount: likeCount,
            skipCount: skipCount,
            playCount: playCount,
            present: present,
            timeAdded: timeAdded,
            lastModified: lastModified,
            previous: previous,
            next: next,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SongsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $SongsTable,
    DriftSong,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (DriftSong, BaseReferences<_$MainDatabase, $SongsTable, DriftSong>),
    DriftSong,
    PrefetchHooks Function()>;
typedef $$SmartListsTableCreateCompanionBuilder = SmartListsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> shuffleMode,
  Value<String> icon,
  Value<String> gradient,
  Value<DateTime> timeCreated,
  Value<DateTime> timeChanged,
  Value<DateTime> timeLastPlayed,
  Value<bool> excludeArtists,
  Value<int> blockLevel,
  Value<int> minLikeCount,
  Value<int> maxLikeCount,
  Value<int?> minPlayCount,
  Value<int?> maxPlayCount,
  Value<int?> minSkipCount,
  Value<int?> maxSkipCount,
  Value<int?> minYear,
  Value<int?> maxYear,
  Value<int?> limit,
  required String orderCriteria,
  required String orderDirections,
});
typedef $$SmartListsTableUpdateCompanionBuilder = SmartListsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> shuffleMode,
  Value<String> icon,
  Value<String> gradient,
  Value<DateTime> timeCreated,
  Value<DateTime> timeChanged,
  Value<DateTime> timeLastPlayed,
  Value<bool> excludeArtists,
  Value<int> blockLevel,
  Value<int> minLikeCount,
  Value<int> maxLikeCount,
  Value<int?> minPlayCount,
  Value<int?> maxPlayCount,
  Value<int?> minSkipCount,
  Value<int?> maxSkipCount,
  Value<int?> minYear,
  Value<int?> maxYear,
  Value<int?> limit,
  Value<String> orderCriteria,
  Value<String> orderDirections,
});

class $$SmartListsTableFilterComposer
    extends Composer<_$MainDatabase, $SmartListsTable> {
  $$SmartListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gradient => $composableBuilder(
      column: $table.gradient, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get excludeArtists => $composableBuilder(
      column: $table.excludeArtists,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minLikeCount => $composableBuilder(
      column: $table.minLikeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxLikeCount => $composableBuilder(
      column: $table.maxLikeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minPlayCount => $composableBuilder(
      column: $table.minPlayCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxPlayCount => $composableBuilder(
      column: $table.maxPlayCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minSkipCount => $composableBuilder(
      column: $table.minSkipCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxSkipCount => $composableBuilder(
      column: $table.maxSkipCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minYear => $composableBuilder(
      column: $table.minYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxYear => $composableBuilder(
      column: $table.maxYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderCriteria => $composableBuilder(
      column: $table.orderCriteria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderDirections => $composableBuilder(
      column: $table.orderDirections,
      builder: (column) => ColumnFilters(column));
}

class $$SmartListsTableOrderingComposer
    extends Composer<_$MainDatabase, $SmartListsTable> {
  $$SmartListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gradient => $composableBuilder(
      column: $table.gradient, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get excludeArtists => $composableBuilder(
      column: $table.excludeArtists,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minLikeCount => $composableBuilder(
      column: $table.minLikeCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxLikeCount => $composableBuilder(
      column: $table.maxLikeCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minPlayCount => $composableBuilder(
      column: $table.minPlayCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxPlayCount => $composableBuilder(
      column: $table.maxPlayCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minSkipCount => $composableBuilder(
      column: $table.minSkipCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxSkipCount => $composableBuilder(
      column: $table.maxSkipCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minYear => $composableBuilder(
      column: $table.minYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxYear => $composableBuilder(
      column: $table.maxYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderCriteria => $composableBuilder(
      column: $table.orderCriteria,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderDirections => $composableBuilder(
      column: $table.orderDirections,
      builder: (column) => ColumnOrderings(column));
}

class $$SmartListsTableAnnotationComposer
    extends Composer<_$MainDatabase, $SmartListsTable> {
  $$SmartListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get gradient =>
      $composableBuilder(column: $table.gradient, builder: (column) => column);

  GeneratedColumn<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => column);

  GeneratedColumn<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => column);

  GeneratedColumn<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed, builder: (column) => column);

  GeneratedColumn<bool> get excludeArtists => $composableBuilder(
      column: $table.excludeArtists, builder: (column) => column);

  GeneratedColumn<int> get blockLevel => $composableBuilder(
      column: $table.blockLevel, builder: (column) => column);

  GeneratedColumn<int> get minLikeCount => $composableBuilder(
      column: $table.minLikeCount, builder: (column) => column);

  GeneratedColumn<int> get maxLikeCount => $composableBuilder(
      column: $table.maxLikeCount, builder: (column) => column);

  GeneratedColumn<int> get minPlayCount => $composableBuilder(
      column: $table.minPlayCount, builder: (column) => column);

  GeneratedColumn<int> get maxPlayCount => $composableBuilder(
      column: $table.maxPlayCount, builder: (column) => column);

  GeneratedColumn<int> get minSkipCount => $composableBuilder(
      column: $table.minSkipCount, builder: (column) => column);

  GeneratedColumn<int> get maxSkipCount => $composableBuilder(
      column: $table.maxSkipCount, builder: (column) => column);

  GeneratedColumn<int> get minYear =>
      $composableBuilder(column: $table.minYear, builder: (column) => column);

  GeneratedColumn<int> get maxYear =>
      $composableBuilder(column: $table.maxYear, builder: (column) => column);

  GeneratedColumn<int> get limit =>
      $composableBuilder(column: $table.limit, builder: (column) => column);

  GeneratedColumn<String> get orderCriteria => $composableBuilder(
      column: $table.orderCriteria, builder: (column) => column);

  GeneratedColumn<String> get orderDirections => $composableBuilder(
      column: $table.orderDirections, builder: (column) => column);
}

class $$SmartListsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $SmartListsTable,
    DriftSmartList,
    $$SmartListsTableFilterComposer,
    $$SmartListsTableOrderingComposer,
    $$SmartListsTableAnnotationComposer,
    $$SmartListsTableCreateCompanionBuilder,
    $$SmartListsTableUpdateCompanionBuilder,
    (
      DriftSmartList,
      BaseReferences<_$MainDatabase, $SmartListsTable, DriftSmartList>
    ),
    DriftSmartList,
    PrefetchHooks Function()> {
  $$SmartListsTableTableManager(_$MainDatabase db, $SmartListsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmartListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmartListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmartListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> shuffleMode = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> gradient = const Value.absent(),
            Value<DateTime> timeCreated = const Value.absent(),
            Value<DateTime> timeChanged = const Value.absent(),
            Value<DateTime> timeLastPlayed = const Value.absent(),
            Value<bool> excludeArtists = const Value.absent(),
            Value<int> blockLevel = const Value.absent(),
            Value<int> minLikeCount = const Value.absent(),
            Value<int> maxLikeCount = const Value.absent(),
            Value<int?> minPlayCount = const Value.absent(),
            Value<int?> maxPlayCount = const Value.absent(),
            Value<int?> minSkipCount = const Value.absent(),
            Value<int?> maxSkipCount = const Value.absent(),
            Value<int?> minYear = const Value.absent(),
            Value<int?> maxYear = const Value.absent(),
            Value<int?> limit = const Value.absent(),
            Value<String> orderCriteria = const Value.absent(),
            Value<String> orderDirections = const Value.absent(),
          }) =>
              SmartListsCompanion(
            id: id,
            name: name,
            shuffleMode: shuffleMode,
            icon: icon,
            gradient: gradient,
            timeCreated: timeCreated,
            timeChanged: timeChanged,
            timeLastPlayed: timeLastPlayed,
            excludeArtists: excludeArtists,
            blockLevel: blockLevel,
            minLikeCount: minLikeCount,
            maxLikeCount: maxLikeCount,
            minPlayCount: minPlayCount,
            maxPlayCount: maxPlayCount,
            minSkipCount: minSkipCount,
            maxSkipCount: maxSkipCount,
            minYear: minYear,
            maxYear: maxYear,
            limit: limit,
            orderCriteria: orderCriteria,
            orderDirections: orderDirections,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> shuffleMode = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> gradient = const Value.absent(),
            Value<DateTime> timeCreated = const Value.absent(),
            Value<DateTime> timeChanged = const Value.absent(),
            Value<DateTime> timeLastPlayed = const Value.absent(),
            Value<bool> excludeArtists = const Value.absent(),
            Value<int> blockLevel = const Value.absent(),
            Value<int> minLikeCount = const Value.absent(),
            Value<int> maxLikeCount = const Value.absent(),
            Value<int?> minPlayCount = const Value.absent(),
            Value<int?> maxPlayCount = const Value.absent(),
            Value<int?> minSkipCount = const Value.absent(),
            Value<int?> maxSkipCount = const Value.absent(),
            Value<int?> minYear = const Value.absent(),
            Value<int?> maxYear = const Value.absent(),
            Value<int?> limit = const Value.absent(),
            required String orderCriteria,
            required String orderDirections,
          }) =>
              SmartListsCompanion.insert(
            id: id,
            name: name,
            shuffleMode: shuffleMode,
            icon: icon,
            gradient: gradient,
            timeCreated: timeCreated,
            timeChanged: timeChanged,
            timeLastPlayed: timeLastPlayed,
            excludeArtists: excludeArtists,
            blockLevel: blockLevel,
            minLikeCount: minLikeCount,
            maxLikeCount: maxLikeCount,
            minPlayCount: minPlayCount,
            maxPlayCount: maxPlayCount,
            minSkipCount: minSkipCount,
            maxSkipCount: maxSkipCount,
            minYear: minYear,
            maxYear: maxYear,
            limit: limit,
            orderCriteria: orderCriteria,
            orderDirections: orderDirections,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SmartListsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $SmartListsTable,
    DriftSmartList,
    $$SmartListsTableFilterComposer,
    $$SmartListsTableOrderingComposer,
    $$SmartListsTableAnnotationComposer,
    $$SmartListsTableCreateCompanionBuilder,
    $$SmartListsTableUpdateCompanionBuilder,
    (
      DriftSmartList,
      BaseReferences<_$MainDatabase, $SmartListsTable, DriftSmartList>
    ),
    DriftSmartList,
    PrefetchHooks Function()>;
typedef $$SmartListArtistsTableCreateCompanionBuilder
    = SmartListArtistsCompanion Function({
  required int smartListId,
  required String artistName,
  Value<int> rowid,
});
typedef $$SmartListArtistsTableUpdateCompanionBuilder
    = SmartListArtistsCompanion Function({
  Value<int> smartListId,
  Value<String> artistName,
  Value<int> rowid,
});

class $$SmartListArtistsTableFilterComposer
    extends Composer<_$MainDatabase, $SmartListArtistsTable> {
  $$SmartListArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get smartListId => $composableBuilder(
      column: $table.smartListId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artistName => $composableBuilder(
      column: $table.artistName, builder: (column) => ColumnFilters(column));
}

class $$SmartListArtistsTableOrderingComposer
    extends Composer<_$MainDatabase, $SmartListArtistsTable> {
  $$SmartListArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get smartListId => $composableBuilder(
      column: $table.smartListId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artistName => $composableBuilder(
      column: $table.artistName, builder: (column) => ColumnOrderings(column));
}

class $$SmartListArtistsTableAnnotationComposer
    extends Composer<_$MainDatabase, $SmartListArtistsTable> {
  $$SmartListArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get smartListId => $composableBuilder(
      column: $table.smartListId, builder: (column) => column);

  GeneratedColumn<String> get artistName => $composableBuilder(
      column: $table.artistName, builder: (column) => column);
}

class $$SmartListArtistsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $SmartListArtistsTable,
    DriftSmartListArtist,
    $$SmartListArtistsTableFilterComposer,
    $$SmartListArtistsTableOrderingComposer,
    $$SmartListArtistsTableAnnotationComposer,
    $$SmartListArtistsTableCreateCompanionBuilder,
    $$SmartListArtistsTableUpdateCompanionBuilder,
    (
      DriftSmartListArtist,
      BaseReferences<_$MainDatabase, $SmartListArtistsTable,
          DriftSmartListArtist>
    ),
    DriftSmartListArtist,
    PrefetchHooks Function()> {
  $$SmartListArtistsTableTableManager(
      _$MainDatabase db, $SmartListArtistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmartListArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmartListArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmartListArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> smartListId = const Value.absent(),
            Value<String> artistName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartListArtistsCompanion(
            smartListId: smartListId,
            artistName: artistName,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int smartListId,
            required String artistName,
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartListArtistsCompanion.insert(
            smartListId: smartListId,
            artistName: artistName,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SmartListArtistsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $SmartListArtistsTable,
    DriftSmartListArtist,
    $$SmartListArtistsTableFilterComposer,
    $$SmartListArtistsTableOrderingComposer,
    $$SmartListArtistsTableAnnotationComposer,
    $$SmartListArtistsTableCreateCompanionBuilder,
    $$SmartListArtistsTableUpdateCompanionBuilder,
    (
      DriftSmartListArtist,
      BaseReferences<_$MainDatabase, $SmartListArtistsTable,
          DriftSmartListArtist>
    ),
    DriftSmartListArtist,
    PrefetchHooks Function()>;
typedef $$PlaylistsTableCreateCompanionBuilder = PlaylistsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> shuffleMode,
  Value<String> icon,
  Value<String> gradient,
  Value<DateTime> timeCreated,
  Value<DateTime> timeChanged,
  Value<DateTime> timeLastPlayed,
});
typedef $$PlaylistsTableUpdateCompanionBuilder = PlaylistsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> shuffleMode,
  Value<String> icon,
  Value<String> gradient,
  Value<DateTime> timeCreated,
  Value<DateTime> timeChanged,
  Value<DateTime> timeLastPlayed,
});

class $$PlaylistsTableFilterComposer
    extends Composer<_$MainDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gradient => $composableBuilder(
      column: $table.gradient, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed,
      builder: (column) => ColumnFilters(column));
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$MainDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gradient => $composableBuilder(
      column: $table.gradient, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed,
      builder: (column) => ColumnOrderings(column));
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$MainDatabase, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shuffleMode => $composableBuilder(
      column: $table.shuffleMode, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get gradient =>
      $composableBuilder(column: $table.gradient, builder: (column) => column);

  GeneratedColumn<DateTime> get timeCreated => $composableBuilder(
      column: $table.timeCreated, builder: (column) => column);

  GeneratedColumn<DateTime> get timeChanged => $composableBuilder(
      column: $table.timeChanged, builder: (column) => column);

  GeneratedColumn<DateTime> get timeLastPlayed => $composableBuilder(
      column: $table.timeLastPlayed, builder: (column) => column);
}

class $$PlaylistsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $PlaylistsTable,
    DriftPlaylist,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (
      DriftPlaylist,
      BaseReferences<_$MainDatabase, $PlaylistsTable, DriftPlaylist>
    ),
    DriftPlaylist,
    PrefetchHooks Function()> {
  $$PlaylistsTableTableManager(_$MainDatabase db, $PlaylistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> shuffleMode = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> gradient = const Value.absent(),
            Value<DateTime> timeCreated = const Value.absent(),
            Value<DateTime> timeChanged = const Value.absent(),
            Value<DateTime> timeLastPlayed = const Value.absent(),
          }) =>
              PlaylistsCompanion(
            id: id,
            name: name,
            shuffleMode: shuffleMode,
            icon: icon,
            gradient: gradient,
            timeCreated: timeCreated,
            timeChanged: timeChanged,
            timeLastPlayed: timeLastPlayed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> shuffleMode = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> gradient = const Value.absent(),
            Value<DateTime> timeCreated = const Value.absent(),
            Value<DateTime> timeChanged = const Value.absent(),
            Value<DateTime> timeLastPlayed = const Value.absent(),
          }) =>
              PlaylistsCompanion.insert(
            id: id,
            name: name,
            shuffleMode: shuffleMode,
            icon: icon,
            gradient: gradient,
            timeCreated: timeCreated,
            timeChanged: timeChanged,
            timeLastPlayed: timeLastPlayed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $PlaylistsTable,
    DriftPlaylist,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (
      DriftPlaylist,
      BaseReferences<_$MainDatabase, $PlaylistsTable, DriftPlaylist>
    ),
    DriftPlaylist,
    PrefetchHooks Function()>;
typedef $$PlaylistEntriesTableCreateCompanionBuilder = PlaylistEntriesCompanion
    Function({
  required int playlistId,
  required String songPath,
  required int position,
  Value<int> rowid,
});
typedef $$PlaylistEntriesTableUpdateCompanionBuilder = PlaylistEntriesCompanion
    Function({
  Value<int> playlistId,
  Value<String> songPath,
  Value<int> position,
  Value<int> rowid,
});

class $$PlaylistEntriesTableFilterComposer
    extends Composer<_$MainDatabase, $PlaylistEntriesTable> {
  $$PlaylistEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get songPath => $composableBuilder(
      column: $table.songPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));
}

class $$PlaylistEntriesTableOrderingComposer
    extends Composer<_$MainDatabase, $PlaylistEntriesTable> {
  $$PlaylistEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get songPath => $composableBuilder(
      column: $table.songPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));
}

class $$PlaylistEntriesTableAnnotationComposer
    extends Composer<_$MainDatabase, $PlaylistEntriesTable> {
  $$PlaylistEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => column);

  GeneratedColumn<String> get songPath =>
      $composableBuilder(column: $table.songPath, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$PlaylistEntriesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $PlaylistEntriesTable,
    DriftPlaylistEntry,
    $$PlaylistEntriesTableFilterComposer,
    $$PlaylistEntriesTableOrderingComposer,
    $$PlaylistEntriesTableAnnotationComposer,
    $$PlaylistEntriesTableCreateCompanionBuilder,
    $$PlaylistEntriesTableUpdateCompanionBuilder,
    (
      DriftPlaylistEntry,
      BaseReferences<_$MainDatabase, $PlaylistEntriesTable, DriftPlaylistEntry>
    ),
    DriftPlaylistEntry,
    PrefetchHooks Function()> {
  $$PlaylistEntriesTableTableManager(
      _$MainDatabase db, $PlaylistEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> playlistId = const Value.absent(),
            Value<String> songPath = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistEntriesCompanion(
            playlistId: playlistId,
            songPath: songPath,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int playlistId,
            required String songPath,
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistEntriesCompanion.insert(
            playlistId: playlistId,
            songPath: songPath,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistEntriesTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $PlaylistEntriesTable,
    DriftPlaylistEntry,
    $$PlaylistEntriesTableFilterComposer,
    $$PlaylistEntriesTableOrderingComposer,
    $$PlaylistEntriesTableAnnotationComposer,
    $$PlaylistEntriesTableCreateCompanionBuilder,
    $$PlaylistEntriesTableUpdateCompanionBuilder,
    (
      DriftPlaylistEntry,
      BaseReferences<_$MainDatabase, $PlaylistEntriesTable, DriftPlaylistEntry>
    ),
    DriftPlaylistEntry,
    PrefetchHooks Function()>;
typedef $$KeyValueEntriesTableCreateCompanionBuilder = KeyValueEntriesCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$KeyValueEntriesTableUpdateCompanionBuilder = KeyValueEntriesCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$KeyValueEntriesTableFilterComposer
    extends Composer<_$MainDatabase, $KeyValueEntriesTable> {
  $$KeyValueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$KeyValueEntriesTableOrderingComposer
    extends Composer<_$MainDatabase, $KeyValueEntriesTable> {
  $$KeyValueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$KeyValueEntriesTableAnnotationComposer
    extends Composer<_$MainDatabase, $KeyValueEntriesTable> {
  $$KeyValueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KeyValueEntriesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $KeyValueEntriesTable,
    KeyValueEntry,
    $$KeyValueEntriesTableFilterComposer,
    $$KeyValueEntriesTableOrderingComposer,
    $$KeyValueEntriesTableAnnotationComposer,
    $$KeyValueEntriesTableCreateCompanionBuilder,
    $$KeyValueEntriesTableUpdateCompanionBuilder,
    (
      KeyValueEntry,
      BaseReferences<_$MainDatabase, $KeyValueEntriesTable, KeyValueEntry>
    ),
    KeyValueEntry,
    PrefetchHooks Function()> {
  $$KeyValueEntriesTableTableManager(
      _$MainDatabase db, $KeyValueEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValueEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValueEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KeyValueEntriesCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              KeyValueEntriesCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KeyValueEntriesTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $KeyValueEntriesTable,
    KeyValueEntry,
    $$KeyValueEntriesTableFilterComposer,
    $$KeyValueEntriesTableOrderingComposer,
    $$KeyValueEntriesTableAnnotationComposer,
    $$KeyValueEntriesTableCreateCompanionBuilder,
    $$KeyValueEntriesTableUpdateCompanionBuilder,
    (
      KeyValueEntry,
      BaseReferences<_$MainDatabase, $KeyValueEntriesTable, KeyValueEntry>
    ),
    KeyValueEntry,
    PrefetchHooks Function()>;
typedef $$HomeWidgetsTableCreateCompanionBuilder = HomeWidgetsCompanion
    Function({
  Value<int> position,
  required String type,
  Value<String> data,
});
typedef $$HomeWidgetsTableUpdateCompanionBuilder = HomeWidgetsCompanion
    Function({
  Value<int> position,
  Value<String> type,
  Value<String> data,
});

class $$HomeWidgetsTableFilterComposer
    extends Composer<_$MainDatabase, $HomeWidgetsTable> {
  $$HomeWidgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));
}

class $$HomeWidgetsTableOrderingComposer
    extends Composer<_$MainDatabase, $HomeWidgetsTable> {
  $$HomeWidgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));
}

class $$HomeWidgetsTableAnnotationComposer
    extends Composer<_$MainDatabase, $HomeWidgetsTable> {
  $$HomeWidgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$HomeWidgetsTableTableManager extends RootTableManager<
    _$MainDatabase,
    $HomeWidgetsTable,
    DriftHomeWidget,
    $$HomeWidgetsTableFilterComposer,
    $$HomeWidgetsTableOrderingComposer,
    $$HomeWidgetsTableAnnotationComposer,
    $$HomeWidgetsTableCreateCompanionBuilder,
    $$HomeWidgetsTableUpdateCompanionBuilder,
    (
      DriftHomeWidget,
      BaseReferences<_$MainDatabase, $HomeWidgetsTable, DriftHomeWidget>
    ),
    DriftHomeWidget,
    PrefetchHooks Function()> {
  $$HomeWidgetsTableTableManager(_$MainDatabase db, $HomeWidgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeWidgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeWidgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HomeWidgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> position = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> data = const Value.absent(),
          }) =>
              HomeWidgetsCompanion(
            position: position,
            type: type,
            data: data,
          ),
          createCompanionCallback: ({
            Value<int> position = const Value.absent(),
            required String type,
            Value<String> data = const Value.absent(),
          }) =>
              HomeWidgetsCompanion.insert(
            position: position,
            type: type,
            data: data,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HomeWidgetsTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $HomeWidgetsTable,
    DriftHomeWidget,
    $$HomeWidgetsTableFilterComposer,
    $$HomeWidgetsTableOrderingComposer,
    $$HomeWidgetsTableAnnotationComposer,
    $$HomeWidgetsTableCreateCompanionBuilder,
    $$HomeWidgetsTableUpdateCompanionBuilder,
    (
      DriftHomeWidget,
      BaseReferences<_$MainDatabase, $HomeWidgetsTable, DriftHomeWidget>
    ),
    DriftHomeWidget,
    PrefetchHooks Function()>;
typedef $$HistoryEntriesTableCreateCompanionBuilder = HistoryEntriesCompanion
    Function({
  Value<DateTime> time,
  required String type,
  required String identifier,
  Value<int> rowid,
});
typedef $$HistoryEntriesTableUpdateCompanionBuilder = HistoryEntriesCompanion
    Function({
  Value<DateTime> time,
  Value<String> type,
  Value<String> identifier,
  Value<int> rowid,
});

class $$HistoryEntriesTableFilterComposer
    extends Composer<_$MainDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => ColumnFilters(column));
}

class $$HistoryEntriesTableOrderingComposer
    extends Composer<_$MainDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => ColumnOrderings(column));
}

class $$HistoryEntriesTableAnnotationComposer
    extends Composer<_$MainDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => column);
}

class $$HistoryEntriesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $HistoryEntriesTable,
    DriftHistoryEntry,
    $$HistoryEntriesTableFilterComposer,
    $$HistoryEntriesTableOrderingComposer,
    $$HistoryEntriesTableAnnotationComposer,
    $$HistoryEntriesTableCreateCompanionBuilder,
    $$HistoryEntriesTableUpdateCompanionBuilder,
    (
      DriftHistoryEntry,
      BaseReferences<_$MainDatabase, $HistoryEntriesTable, DriftHistoryEntry>
    ),
    DriftHistoryEntry,
    PrefetchHooks Function()> {
  $$HistoryEntriesTableTableManager(
      _$MainDatabase db, $HistoryEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> identifier = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HistoryEntriesCompanion(
            time: time,
            type: type,
            identifier: identifier,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            required String type,
            required String identifier,
            Value<int> rowid = const Value.absent(),
          }) =>
              HistoryEntriesCompanion.insert(
            time: time,
            type: type,
            identifier: identifier,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryEntriesTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $HistoryEntriesTable,
    DriftHistoryEntry,
    $$HistoryEntriesTableFilterComposer,
    $$HistoryEntriesTableOrderingComposer,
    $$HistoryEntriesTableAnnotationComposer,
    $$HistoryEntriesTableCreateCompanionBuilder,
    $$HistoryEntriesTableUpdateCompanionBuilder,
    (
      DriftHistoryEntry,
      BaseReferences<_$MainDatabase, $HistoryEntriesTable, DriftHistoryEntry>
    ),
    DriftHistoryEntry,
    PrefetchHooks Function()>;
typedef $$BlockedFilesTableCreateCompanionBuilder = BlockedFilesCompanion
    Function({
  required String path,
  Value<int> rowid,
});
typedef $$BlockedFilesTableUpdateCompanionBuilder = BlockedFilesCompanion
    Function({
  Value<String> path,
  Value<int> rowid,
});

class $$BlockedFilesTableFilterComposer
    extends Composer<_$MainDatabase, $BlockedFilesTable> {
  $$BlockedFilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));
}

class $$BlockedFilesTableOrderingComposer
    extends Composer<_$MainDatabase, $BlockedFilesTable> {
  $$BlockedFilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));
}

class $$BlockedFilesTableAnnotationComposer
    extends Composer<_$MainDatabase, $BlockedFilesTable> {
  $$BlockedFilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$BlockedFilesTableTableManager extends RootTableManager<
    _$MainDatabase,
    $BlockedFilesTable,
    BlockedFile,
    $$BlockedFilesTableFilterComposer,
    $$BlockedFilesTableOrderingComposer,
    $$BlockedFilesTableAnnotationComposer,
    $$BlockedFilesTableCreateCompanionBuilder,
    $$BlockedFilesTableUpdateCompanionBuilder,
    (
      BlockedFile,
      BaseReferences<_$MainDatabase, $BlockedFilesTable, BlockedFile>
    ),
    BlockedFile,
    PrefetchHooks Function()> {
  $$BlockedFilesTableTableManager(_$MainDatabase db, $BlockedFilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockedFilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockedFilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockedFilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> path = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockedFilesCompanion(
            path: path,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String path,
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockedFilesCompanion.insert(
            path: path,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BlockedFilesTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $BlockedFilesTable,
    BlockedFile,
    $$BlockedFilesTableFilterComposer,
    $$BlockedFilesTableOrderingComposer,
    $$BlockedFilesTableAnnotationComposer,
    $$BlockedFilesTableCreateCompanionBuilder,
    $$BlockedFilesTableUpdateCompanionBuilder,
    (
      BlockedFile,
      BaseReferences<_$MainDatabase, $BlockedFilesTable, BlockedFile>
    ),
    BlockedFile,
    PrefetchHooks Function()>;

class $MainDatabaseManager {
  final _$MainDatabase _db;
  $MainDatabaseManager(this._db);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$ArtistsTableTableManager get artists =>
      $$ArtistsTableTableManager(_db, _db.artists);
  $$LibraryFoldersTableTableManager get libraryFolders =>
      $$LibraryFoldersTableTableManager(_db, _db.libraryFolders);
  $$QueueEntriesTableTableManager get queueEntries =>
      $$QueueEntriesTableTableManager(_db, _db.queueEntries);
  $$AvailableSongEntriesTableTableManager get availableSongEntries =>
      $$AvailableSongEntriesTableTableManager(_db, _db.availableSongEntries);
  $$SongsTableTableManager get songs =>
      $$SongsTableTableManager(_db, _db.songs);
  $$SmartListsTableTableManager get smartLists =>
      $$SmartListsTableTableManager(_db, _db.smartLists);
  $$SmartListArtistsTableTableManager get smartListArtists =>
      $$SmartListArtistsTableTableManager(_db, _db.smartListArtists);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistEntriesTableTableManager get playlistEntries =>
      $$PlaylistEntriesTableTableManager(_db, _db.playlistEntries);
  $$KeyValueEntriesTableTableManager get keyValueEntries =>
      $$KeyValueEntriesTableTableManager(_db, _db.keyValueEntries);
  $$HomeWidgetsTableTableManager get homeWidgets =>
      $$HomeWidgetsTableTableManager(_db, _db.homeWidgets);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(_db, _db.historyEntries);
  $$BlockedFilesTableTableManager get blockedFiles =>
      $$BlockedFilesTableTableManager(_db, _db.blockedFiles);
}
