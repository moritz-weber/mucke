import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart' as utils;

const _LEADING_WIDTH = 108.0;

class SongInfo extends StatelessWidget {
  const SongInfo(this.song, {Key key}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    final cover = Image(
      image: utils.getAlbumImage(song.albumArtPath),
      fit: BoxFit.cover,
    );

    return Column(
      children: [
        SizedBox(
          height: 96,
          width: 96,
          child: cover,
        ),
        Container(height: 8),
        InfoRow(leading: 'Title:', trailing: song.title, leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Album:', trailing: song.album, leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Artist:', trailing: song.artist, leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Path:', trailing: song.path, leadingWidth: _LEADING_WIDTH),
        InfoRow(
          leading: 'Album art path:',
          trailing: song.albumArtPath,
          leadingWidth: _LEADING_WIDTH,
        ),
        InfoRow(
          leading: 'Duration:',
          trailing: utils.msToTimeString(Duration(milliseconds: song.duration)),
          leadingWidth: _LEADING_WIDTH,
        ),
        InfoRow(
            leading: 'Track number:',
            trailing: '${song.trackNumber}',
            leadingWidth: _LEADING_WIDTH),
        InfoRow(
            leading: 'Disc number:', trailing: '${song.discNumber}', leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Is blocked:', trailing: '${song.blocked}', leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Likes:', trailing: '${song.likeCount}', leadingWidth: _LEADING_WIDTH),
        InfoRow(
            leading: 'Times played:', trailing: '${song.playCount}', leadingWidth: _LEADING_WIDTH),
        InfoRow(
            leading: 'Times skipped:', trailing: '${song.skipCount}', leadingWidth: _LEADING_WIDTH),
        InfoRow(
            leading: 'Previous song:', trailing: '${song.previous}', leadingWidth: _LEADING_WIDTH),
        InfoRow(leading: 'Next song:', trailing: '${song.next}', leadingWidth: _LEADING_WIDTH),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({Key key, this.leadingWidth, this.leading, this.trailing}) : super(key: key);

  final double leadingWidth;
  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: leadingWidth,
            child: Text(leading),
          ),
          Expanded(
            child: Text(
              trailing,
            ),
          ),
        ],
      ),
    );
  }
}
