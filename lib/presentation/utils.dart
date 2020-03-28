import 'dart:io';

import 'package:flutter/material.dart';

Image getAlbumImage(String albumArtPath) {
  // return Image.asset('assets/no_cover.png');

  if (albumArtPath == null || !File(albumArtPath).existsSync()) {
    return Image.asset('assets/no_cover.png');
  }
  return Image.file(File(albumArtPath));
}
