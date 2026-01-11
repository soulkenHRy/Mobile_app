import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  static final BackgroundMusic _instance = BackgroundMusic._internal();
  static final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  factory BackgroundMusic() {
    return _instance;
  }

  BackgroundMusic._internal();

  Future<void> initialize() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set looping
    await _audioPlayer.setVolume(0.5); // Set initial volume to 50%
  }

  Future<void> playBackgroundMusic() async {
    if (!_isPlaying) {
      await _audioPlayer.play(
        AssetSource('music/good-night-lofi-cozy-chill-music-160166.mp3'),
      );
      _isPlaying = true;
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  Future<void> pauseBackgroundMusic() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  Future<void> resumeBackgroundMusic() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  bool get isPlaying => _isPlaying;
}
