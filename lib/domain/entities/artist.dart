import 'package:equatable/equatable.dart';

import 'playable.dart';

class Artist extends Equatable implements Playable {
  const Artist({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];

  @override
  PlayableType get type => PlayableType.artist;
}
