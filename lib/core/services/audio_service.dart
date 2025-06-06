import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:timer/core/constants/app_sounds.dart';

class AudioService {
  static final AudioService instance = AudioService._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _initialized = false;

  AudioService._internal();

  Future<void> init() async {
    if (_initialized) return;
    final session = await AudioSession.instance;
    await session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.sonification,
          usage: AndroidAudioUsage.alarm,
        ),
        androidAudioFocusGainType:
            AndroidAudioFocusGainType.gainTransientMayDuck,
        androidWillPauseWhenDucked: false,
      ),
    );

    _initialized = true;
  }

  Future<void> playTimerComplete() async {
    try {
      await init(); // Ensure session is configured
      await _player.stop();
      await _player.setAsset(AppSounds.done);
      await _player.setVolume(1.0);
      await _player.play();
    } catch (e) {
      print('Audio playback failed: $e');
    }
  }

  //? do not dispose static player or recreate it if null
  // Future<void> dispose() async {
  // await _player.dispose();
  // }
}
