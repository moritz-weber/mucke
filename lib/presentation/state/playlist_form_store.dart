import 'package:mobx/mobx.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../gradients.dart';
import '../icons.dart';
import 'cover_customization_store.dart';

part 'playlist_form_store.g.dart';

class PlaylistFormStore extends _PlaylistStore with _$PlaylistFormStore {
  PlaylistFormStore({
    required MusicDataRepository musicDataRepository,
    Playlist? playlist,
  }) : super(musicDataRepository, playlist);
}

abstract class _PlaylistStore with Store {
  _PlaylistStore(
    this._musicDataRepository,
    this._playlist,
  );

  final MusicDataRepository _musicDataRepository;
  final Playlist? _playlist;

  final FormErrorState error = FormErrorState();

  late CoverCustomizationStore cover = CoverCustomizationStore(
    iconString: _playlist?.iconString ?? CUSTOM_ICONS.keys.first,
    gradientString: _playlist?.gradientString ?? CUSTOM_GRADIENTS.keys.first,
  );

  @observable
  late String? name = _playlist?.name;

  @observable
  late ShuffleMode? shuffleMode = _playlist?.shuffleMode;
  @computed
  int get shuffleModeIndex => _shuffleModeIndex(shuffleMode);
  @action
  void setShuffleModeIndex(int index) {
    shuffleMode = _intToShuffleMode(index);
  }

  Future<void> save() async {
    if (_playlist == null) {
      _createPlaylist();
    } else {
      _updatePlaylist();
    }
  }

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, _validateName),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    _validateName(name);
  }

  void _validateName(String? name) {
    error.name = name == null || name == '' ? 'The name must not be empty.' : null;
  }

  Future<void> _createPlaylist() async {
    await _musicDataRepository.insertPlaylist(
      name ?? 'This needs a name',
      cover.iconString,
      cover.gradientString,
      shuffleMode,
    );
  }

  Future<void> _updatePlaylist() async {
    await _musicDataRepository.updatePlaylist(
      Playlist(
        id: _playlist!.id,
        name: name ?? 'This needs a name',
        iconString: cover.iconString,
        gradientString: cover.gradientString,
        shuffleMode: shuffleMode,
        timeChanged: DateTime.now(),
        timeCreated: _playlist!.timeCreated,
        timeLastPlayed: _playlist!.timeLastPlayed,
      ),
    );
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? name;

  @computed
  bool get hasErrors => name != null;
}

int _shuffleModeIndex(ShuffleMode? shuffleMode) {
  if (shuffleMode == null) return 0;
  switch (shuffleMode) {
    case ShuffleMode.none:
      return 1;
    case ShuffleMode.standard:
      return 2;
    case ShuffleMode.plus:
      return 3;
  }
}

ShuffleMode? _intToShuffleMode(int index) {
  switch (index) {
    case 1:
      return ShuffleMode.none;
    case 2:
      return ShuffleMode.standard;
    case 3:
      return ShuffleMode.plus;
  }
  return null;
}
