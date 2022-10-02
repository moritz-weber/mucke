import 'package:equatable/equatable.dart';

import 'custom_list.dart';
import 'playable.dart';
import 'shuffle_mode.dart';

class Playlist extends CustomList with EquatableMixin implements Playable {
  const Playlist({
    required String name,
    required String iconString,
    required String gradientString,
    required DateTime timeCreated,
    required DateTime timeChanged,
    required DateTime timeLastPlayed,
    ShuffleMode? shuffleMode,
    required this.id,
  }) : super(
          name,
          iconString,
          gradientString,
          shuffleMode,
          timeCreated,
          timeChanged,
          timeLastPlayed,
        );

  final int id;

  @override
  List<Object?> get props => [
        id,
        name,
        iconString,
        gradientString,
        shuffleMode,
        timeCreated,
        timeChanged,
        timeLastPlayed,
      ];

  @override
  PlayableType get type => PlayableType.playlist;
  
  @override
  String get identifier => id.toString();
  
  @override
  String get title => name;
}
