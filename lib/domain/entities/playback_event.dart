class PlaybackEvent {
  PlaybackEvent({
    required this.index,
    required this.playing,
    required this.processingState,
    required this.updatePosition,
    required this.updateTime,
  });

  final int index;
  final bool playing;
  final ProcessingState processingState;
  final Duration updatePosition;
  final DateTime updateTime;

  @override
  String toString() {
    return '$index, $playing, $processingState';
  }
}

enum ProcessingState {
  /// The player has not loaded an [AudioSource].
  none,

  /// The player is loading an [AudioSource].
  loading,

  /// The player is buffering audio and unable to play.
  buffering,

  /// The player is has enough audio buffered and is able to play.
  ready,

  /// The player has reached the end of the audio.
  completed,
}
