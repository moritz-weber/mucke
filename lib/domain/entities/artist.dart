import 'package:equatable/equatable.dart';

import 'playable.dart';

class Artist extends Equatable implements Playable {
  const Artist({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  PlayableType get type => PlayableType.artist;
  
  @override
  String get identifier => id.toString();
  
  @override
  String get title => name;
}
