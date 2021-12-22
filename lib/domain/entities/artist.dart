import 'package:equatable/equatable.dart';
import 'package:mucke/domain/entities/playable.dart';

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
