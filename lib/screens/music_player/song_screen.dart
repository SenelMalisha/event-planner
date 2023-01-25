import 'package:event_planner/models/song_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../widgets/player_buttons.dart';
import '../../widgets/seekbar.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/17/2023 at 1:26 AM **/

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  Song song = Song.songs[0];

  @override
  void initState(){
    super.initState();

    audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
            children: [
              AudioSource.uri(
                Uri.parse('asset:///${song.url}'),
              )
            ]
        )
    );
  }

  @override
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream,
          audioPlayer.durationStream,
              (Duration position, Duration? duration,){
            return SeekBarData(position, duration ?? Duration.zero);
          }
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),
          _BackgroundFilter(),
          MusicPlayer(
              song: song,
              seekBarDataStream: _seekBarDataStream,
              audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    Key? key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer, required this.song,
  }) : _seekBarDataStream = seekBarDataStream, super(key: key);

  final Song song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Text(
            song.description,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          SizedBox(height: 30,),
          StreamBuilder(
              stream: _seekBarDataStream,
              builder: (context, snapshot){
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChanged: audioPlayer.seek,
                );
              }
          ),
          PlayerButtons(audioPlayer: audioPlayer)
        ]
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect){
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: [
              0.0,
              0.4,
              0.6
            ]
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ]
          )
        ),
      ),
    );
  }
}
