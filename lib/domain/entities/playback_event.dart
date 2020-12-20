class PlaybackEvent {
  PlaybackEvent({
    this.duration,
    this.index,
    this.processingState,
    this.updatePosition,
    this.updateTime,
  });

  final Duration duration;
  final int index;
  final ProcessingState processingState;
  final Duration updatePosition;
  final DateTime updateTime;
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
