import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/widgets/song_info.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/album_art.dart';
import '../widgets/album_background.dart';
import '../widgets/currently_playing_header.dart';
import '../widgets/playback_control.dart';
import '../widgets/song_customization_buttons.dart';
import '../widgets/time_progress_indicator.dart';
import 'album_details_page.dart';
import 'artist_details_page.dart';
import 'queue_page.dart';

class CurrentlyPlayingPage extends StatelessWidget {
  const CurrentlyPlayingPage({Key? key}) : super(key: key);

  static final _log = FimberLog('CurrentlyPlayingPage');

  @override
  Widget build(BuildContext context) {
    _log.d('build started');
    final AudioStore audioStore = GetIt.I<AudioStore>();

    // TODO: everything wrapped in Observer and most components have Observer themselves
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! < 0) {
              _openQueue(context);
            } else if (dragEndDetails.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Observer(
            builder: (BuildContext context) {
              _log.d('Observer.build');
              final Song? song = audioStore.currentSongStream.value;

              if (song == null) {
                return Container();
              }

              return Stack(
                children: [
                  AlbumBackground(
                    song: song,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CurrentlyPlayingHeader(
                          onTap: _openQueue,
                          onMoreTap: _openMoreMenu,
                        ),
                        const Spacer(
                          flex: 10,
                        ),
                        Expanded(
                          flex: 720,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 0.0,
                              ),
                              child: AlbumArt(
                                song: song,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  song.title,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TEXT_BIG.copyWith(),
                                ),
                                Text(
                                  song.artist,
                                  style: TEXT_SUBTITLE.copyWith(
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 6.0),
                          child: SongCustomizationButtons(),
                        ),
                        const Spacer(
                          flex: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: PlaybackControl(),
                        ),
                        const Spacer(
                          flex: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                          child: TimeProgressIndicator(),
                        ),
                        const Spacer(
                          flex: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _openQueue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const QueuePage(),
      ),
    );
  }

  Future<void> _openMoreMenu(BuildContext context) async {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    final song = audioStore.currentSongStream.value;
    if (song == null) return;
    // TODO: EXPLORATORY
    final albums = await musicDataStore.albumStream.first;
    final album = albums.singleWhere((a) => a.title == song.album);

    final artists = await musicDataStore.artistStream.first;
    final artist = artists.singleWhere((a) => a.name == album.artist);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: DARK2,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                color: LIGHT1,
              ),
              const SizedBox(height: 8.0),
              Observer(
                builder: (context) => SwitchListTile(
                  value: audioStore.excludeBlockedStream.value ?? true,
                  title: const Text('Exclude blocked songs'),
                  secondary: const Icon(Icons.remove_circle_outline_rounded),
                  onChanged: (value) {
                    audioStore.setExcludeBlocked(value);
                  },
                ),
              ),
              Observer(
                builder: (context) => SwitchListTile(
                  value: audioStore.excludeSkippedStream.value ?? true,
                  title: const Text('Exclude skipped songs'),
                  secondary: const Icon(Icons.skip_next_rounded),
                  onChanged: (value) {
                    audioStore.setExcludeSkipped(value);
                  },
                ),
              ),
              Observer(
                builder: (context) => SwitchListTile(
                  value: audioStore.respectSongLinksStream.value ?? true,
                  title: const Text('Respect song links'),
                  secondary: const Icon(Icons.link_rounded),
                  onChanged: (value) {
                    audioStore.setRespectSongLinks(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 1,
                  color: Colors.white10,
                ),
              ),
              ListTile(
                title: const Text('Show song info'),
                leading: const Icon(Icons.info),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        backgroundColor: DARK3,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(HORIZONTAL_PADDING),
                            child: SongInfo(song),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Close',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: const Text('Go to artist'),
                leading: const Icon(Icons.person_rounded),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  navStore.pushOnLibrary(
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => ArtistDetailsPage(
                        artist: artist,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Go to album'),
                leading: const Icon(Icons.album_rounded),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  navStore.pushOnLibrary(
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => AlbumDetailsPage(
                        album: album,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        );
      },
    );
  }
}
