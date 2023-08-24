import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._settingsDataSource) {
    Permission.manageExternalStorage.isGranted.then(_manageExternalStorageGrantedSubject.add);
    _settingsDataSource.fileExtensionsStream.listen(_fileExtensionsSubject.add);
    _settingsDataSource.playAlbumsInOrderStream.listen(_playAlbumsInOrderSubject.add);
    _settingsDataSource.listenedPercentageStream.listen(
      (value) => _listenedPercentageSubject.add(value),
    );
  }

  final SettingsDataSource _settingsDataSource;

  final BehaviorSubject<bool> _manageExternalStorageGrantedSubject = BehaviorSubject();
  final BehaviorSubject<String> _fileExtensionsSubject = BehaviorSubject();
  final BehaviorSubject<bool> _playAlbumsInOrderSubject = BehaviorSubject();
  final BehaviorSubject<int> _listenedPercentageSubject = BehaviorSubject();

  @override
  Stream<List<String>> get libraryFoldersStream => _settingsDataSource.libraryFoldersStream;

  @override
  Future<void> addLibraryFolder(String? path) async {
    if (path == null) return;
    await _settingsDataSource.addLibraryFolder(path);
  }

  @override
  Future<void> removeLibraryFolder(String? path) async {
    if (path == null) return;
    await _settingsDataSource.removeLibraryFolder(path);
  }

  @override
  ValueStream<bool> get manageExternalStorageGranted => _manageExternalStorageGrantedSubject.stream;

  @override
  Future<void> setManageExternalStorageGranted(bool granted) async {
    if (granted) {
      if (!await Permission.manageExternalStorage.isGranted) {
        _manageExternalStorageGrantedSubject
            .add(await Permission.manageExternalStorage.request().isGranted);
      }
    } else {
      if (await Permission.manageExternalStorage.isGranted) {
        await openAppSettings();
        _manageExternalStorageGrantedSubject.add(await Permission.manageExternalStorage.isGranted);
      }
    }
  }

  @override
  ValueStream<String> get fileExtensionsStream => _fileExtensionsSubject.stream;

  @override
  Future<void> setFileExtension(String extensions) async {
    await _settingsDataSource.setFileExtension(extensions);
  }

  @override
  ValueStream<bool> get playAlbumsInOrderStream => _playAlbumsInOrderSubject.stream;

  @override
  Future<void> setPlayAlbumsInOrder(bool playInOrder) async {
    await _settingsDataSource.setPlayAlbumsInOrder(playInOrder);
  }

  @override
  ValueStream<int> get listenedPercentageStream => _listenedPercentageSubject.stream;

  @override
  Future<void> setListenedPercentage(int percentage) async {
    await _settingsDataSource.setListenedPercentage(percentage);
  }
}
