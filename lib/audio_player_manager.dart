import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

// const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
const url = 'https://ia801301.us.archive.org/12/items/002_20231230/002.mp3';
const url2 = 'asset:///song1.mp4';

class AudioPlayerManager {
  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    //player.setUrl(url);
    player.setUrl(url2);
  }

  void dispose() {
    player.dispose();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
