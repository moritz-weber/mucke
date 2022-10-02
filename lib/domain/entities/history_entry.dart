import 'playable.dart';

class HistoryEntry {
  HistoryEntry({
    required this.time,
    required this.playable,
  });

  final DateTime time;
  final Playable playable;
}
