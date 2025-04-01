import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:just_audio/just_audio.dart';

final AudioPlayer audioPlayer = AudioPlayer()..setAsset("assets/audio/backgroundaudio.mp3");

class _HeartAnimation extends StatefulWidget {
  const _HeartAnimation();
  @override
  State<_HeartAnimation> createState() => _HeartAnimationState();
}

/* Returns the Heart Animation */
class _HeartAnimationState extends State<_HeartAnimation> with SingleTickerProviderStateMixin {
  late AnimationController motionController;
  late Animation motionAnimation;
  double size = 20;

  @override
  void initState() {
    super.initState();
    audioPlayer.play();

    motionController = AnimationController(
      duration: Duration(seconds: 4),
      reverseDuration: Duration(seconds: 8), 
      vsync: this, 
      lowerBound: 0.5
    );

    motionAnimation = CurvedAnimation(
      parent: motionController, 
      curve: Curves.ease
    );
  
    motionController.forward();
    motionController.addStatusListener((status){
      setState(() {
        if(status == AnimationStatus.completed){
          Future.delayed(const Duration(seconds:7), () {
            motionController.reverse();
          });
        } 
        else if (status == AnimationStatus.dismissed){
          motionController.forward();
        }
      });
    });

    motionController.addListener((){
      setState(() {
        size = motionController.value * 250;
      });
    });
  }
  
  @override
  void dispose() {
    audioPlayer.dispose();
    motionController.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(children: <Widget>[
            Center(
              child: new Container(
                child: Image.asset('assets/images/heart_pump.png'),
                height: size,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _MuteButton extends StatefulWidget {
  const _MuteButton({super.key});
  @override 
  State<_MuteButton> createState() => _MuteButtonState();
}

class _MuteButtonState extends State<_MuteButton> {
  bool isSongMuted = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50.0,
      onPressed: () {
        setState(() {
          if (isSongMuted == true) {
            audioPlayer.play();
            audioPlayer.setVolume(0.5);
          } else {
            audioPlayer.setVolume(0.0);
          }
          isSongMuted = !isSongMuted;
        });
      }, 
      icon: isSongMuted 
          ? const Icon(Icons.music_off_rounded)
          : const Icon(Icons.music_note_rounded),
    );
  }
}

class BreathePage extends StatelessWidget {
  const BreathePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(84, 190, 123, 1),
        title: Text(
          "Breathing Exercise",
          style: AppTheme.theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),

            /* Heart Message */
            Container(
              height: 40, 
              width: 420,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 135, 99, 1)
              ),
              child: Align(
                child: Text(
                  "Copy the heart's timing..",
                  style: AppTheme.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 15),

            /* Mute Button */
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: _MuteButton(),
                ),
              ],
            ),

            /* Heart Animation */
            Container(
              height: 400,
              child: _HeartAnimation(),
            ),
            SizedBox(height: 20),

            /* Instructions Box */
            Container(
              height: 200, 
              width: 380, 
              decoration: BoxDecoration(
                color: const Color.fromRGBO(159, 236, 149, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, 
                    offset: const Offset(2.0, 3.0),
                    blurRadius: 5.0, 
                  ),
                ],
              ),
              child: Padding( padding: const EdgeInsets.all(30.0),
                child: Align(
                  child: Text(
                    "Inhale for 4 seconds\nHold for 7 seconds\nExhale for 8 seconds\nRepeat as needed...",
                    style: AppTheme.theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}