import 'dart:math';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MyPainter extends CustomPainter {
 final double animationValue; 
 MyPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 3; i >= 0; i--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height), 
      i + animationValue);
    }
  }
  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(84, 190, 123, 1)
      .withValues(alpha: 1 - (value / 4).clamp(0, 1));

    canvas.drawCircle(rect.center, 
          sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _RippleAnimation extends StatefulWidget {
  const _RippleAnimation({super.key});
  @override 
  State<_RippleAnimation> createState() => _RippleState();
}

class _RippleState extends State<_RippleAnimation> with SingleTickerProviderStateMixin{
  late AnimationController motionController;
  late Animation<double> animation; 
  @override
  void initState() {
    super.initState(); 
    motionController = AnimationController(
      vsync: this, 
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(motionController)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        motionController.forward();
      } else if (status == AnimationStatus.completed) {
        motionController.repeat();
      }
    });

    motionController.forward();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(400, 400),
              painter: MyPainter(animation.value),
            ),
            Image.asset(
              "assets/images/leaf.png",
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioPlayerWidget extends StatefulWidget {
  const _AudioPlayerWidget({super.key});

  @override
  State<_AudioPlayerWidget> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<_AudioPlayerWidget> {
  late AudioPlayer _audioPlayer; 

  Stream<PositionData> get _positionDataStream =>
    Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      _audioPlayer.positionStream, 
      _audioPlayer.bufferedPositionStream, 
      _audioPlayer.durationStream, 
      (position, bufferedPosition, duration) => PositionData(
        position, 
        bufferedPosition, 
        duration ?? Duration.zero,
      ),
    );

  @override 
  void initState() {
    super.initState(); 
    _audioPlayer = AudioPlayer()..setAsset("assets/audio/guided.mp3");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, 
      width: 380, 
      decoration: BoxDecoration(
        color: const Color.fromRGBO(135, 202, 229, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey, 
            offset: const Offset(2.0, 3.0),
            blurRadius: 5.0, 
          ),
        ],
      ),
      child: Padding( padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center, 
          children: [
            StreamBuilder<PositionData>(
              stream: _positionDataStream, 
              builder: (context, snapshot) {
                final positionData = snapshot.data; 
                return ProgressBar(
                  barHeight: 8, 
                  baseBarColor: Color.fromRGBO(22, 103, 135, 1), 
                  bufferedBarColor: Colors.grey,
                  progressBarColor: Color.fromRGBO(255, 233, 205, 1,),
                  thumbColor: Colors.white, 
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.w600,
                  ),
                  progress: positionData?.position ?? Duration.zero, 
                  buffered: positionData?.bufferedPositionStream ?? Duration.zero, 
                  total: positionData?.duration ?? Duration.zero, 
                  onSeek: _audioPlayer.seek, 
                );
              },
            ),
            Stack(
              alignment: Alignment.center, 
              children: [
                Container(
                  width: 100, 
                  height: 100, 
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(22, 135, 99, 1),
                    shape: BoxShape.circle,
                  ),
                ),
                Controls(audioPlayer: _audioPlayer),
              ],
            ),
          ],
        ),
      ),
    );
  }  
}

class PositionData {
  const PositionData(this.position, this.bufferedPositionStream, this.duration);
  final Duration position; 
  final Duration bufferedPositionStream; 
  final Duration duration; 
}

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream, 
      builder: (context, snapshot) {
        final playerState = snapshot.data; 
        final processingState = playerState?.processingState; 
        final playing = playerState?.playing; 

        if (!(playing ?? false)) {
          return IconButton(
            onPressed: audioPlayer.play, 
            iconSize: 80, 
            color: Colors.white, 
            icon: const Icon(Icons.play_arrow_rounded),
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            onPressed: audioPlayer.pause, 
            iconSize: 80, 
            color: Colors.white, 
            icon: const Icon(Icons.pause_rounded),
          );
        }
        return const Icon(
          Icons.play_arrow_rounded, 
          size: 80, 
          color: Colors.white, 
        );
      },
    );
  }
}

class MeditatePage extends StatelessWidget {
  const MeditatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(84, 190, 123, 1),
        title: Text(
          "Guided Meditation",
          style: AppTheme.theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),

            /* Meditation Message */
            Container(
              height: 40, 
              width: 420,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 103, 135, 1)
              ),
              child: Align(
                child: Text(
                  "Close your eyes and listen..",
                  style: AppTheme.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 15),

            /* Ripple Animation */
            Container(
              height: 400,
              child: _RippleAnimation(),
            ),
            SizedBox(height: 20),

            /* Audio Player */
            _AudioPlayerWidget(),
          ],
        ),
      ),
    );
  }
}