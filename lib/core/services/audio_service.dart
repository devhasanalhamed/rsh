import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playTimerComplete() async {
    try {
      await _player.play(AssetSource('sounds/timer_alert.mp3'));
    } catch (e) {
      // Fallback to system sound or handle gracefully
      print('Audio playback failed: $e');
    }
  }

  static Future<void> dispose() async {
    await _player.dispose();
  }
}
