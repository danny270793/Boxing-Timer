import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Plays the timer's cue sounds (round/rest bell, 10-seconds-left warning).
///
/// Uses two separate players so a bell and a warning can never cut each
/// other off if they were ever triggered close together.
class SoundPlayer {
  SoundPlayer()
    : _bellPlayer = AudioPlayer(playerId: 'boxing_timer_bell'),
      _warningPlayer = AudioPlayer(playerId: 'boxing_timer_warning') {
    _bellPlayer.setReleaseMode(ReleaseMode.stop);
    _warningPlayer.setReleaseMode(ReleaseMode.stop);
  }

  final AudioPlayer _bellPlayer;
  final AudioPlayer _warningPlayer;

  Future<void> playRoundBell() async {
    await _bellPlayer.stop();
    await _bellPlayer.play(AssetSource('sounds/bell.mp3'));
  }

  Future<void> playTenSecondsWarning() async {
    await _warningPlayer.stop();
    await _warningPlayer.play(AssetSource('sounds/clash.mp3'));
  }

  void dispose() {
    _bellPlayer.dispose();
    _warningPlayer.dispose();
  }
}

final soundPlayerProvider = Provider<SoundPlayer>((ref) {
  final player = SoundPlayer();
  ref.onDispose(player.dispose);
  return player;
});
