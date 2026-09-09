// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_dao.dart';

// ignore_for_file: type=lint
mixin _$HomeWidgetDaoMixin on DatabaseAccessor<MainDatabase> {
  $HomeWidgetsTable get homeWidgets => attachedDatabase.homeWidgets;
  $KeyValueEntriesTable get keyValueEntries => attachedDatabase.keyValueEntries;
  HomeWidgetDaoManager get managers => HomeWidgetDaoManager(this);
}

class HomeWidgetDaoManager {
  final _$HomeWidgetDaoMixin _db;
  HomeWidgetDaoManager(this._db);
  $$HomeWidgetsTableTableManager get homeWidgets =>
      $$HomeWidgetsTableTableManager(_db.attachedDatabase, _db.homeWidgets);
  $$KeyValueEntriesTableTableManager get keyValueEntries =>
      $$KeyValueEntriesTableTableManager(
          _db.attachedDatabase, _db.keyValueEntries);
}
