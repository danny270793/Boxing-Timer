import 'package:audioplayers/audioplayers.dart';

/// Plays the timer's cue sounds (round/rest bell, 10-seconds-left warning).
///
/// Uses two separate players so a bell and a warning can never cut each
/// other off if they were ever triggered close together. Players are created
/// on first use so merely constructing the timer does not touch the plugin.
class SoundPlayer {
  AudioPlayer? _bellPlayer;
  AudioPlayer? _warningPlayer;

  AudioPlayer get _bell => _bellPlayer ??= _create('boxing_timer_bell');

  AudioPlayer get _warning =>
      _warningPlayer ??= _create('boxing_timer_warning');

  static AudioPlayer _create(String id) {
    final player = AudioPlayer(playerId: id);
    player.setReleaseMode(ReleaseMode.stop);
    return player;
  }

  Future<void> playRoundBell() async {
    await _bell.stop();
    await _bell.play(AssetSource('sounds/bell.mp3'));
  }

  Future<void> playTenSecondsWarning() async {
    await _warning.stop();
    await _warning.play(AssetSource('sounds/clash.mp3'));
  }

  void dispose() {
    _bellPlayer?.dispose();
    _warningPlayer?.dispose();
  }
}
