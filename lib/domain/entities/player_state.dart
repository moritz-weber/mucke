class PlayerState {
  PlayerState(this.playing, this.processingState);

  final bool playing;

  final ProcessingState processingState;

}

/// Enumerates the different processing states of a player.
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