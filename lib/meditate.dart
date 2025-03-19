import 'dart:math';
import 'package:flutter/material.dart';
import 'theme.dart';

class MyPainter extends CustomPainter {
 final double animationValue;
 
 MyPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 3; i >= 0; i--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height), i + animationValue);
    }
  }
  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(84, 190, 123, 1).withValues(alpha: 1 - (value / 4).clamp(0, 1));

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
            AnimatedContainer(
              height: 200, 
              width: 380, 
              curve: Curves.easeInOut, 
              duration: Duration(seconds: 4),
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
                child: Align(
                  child: Text(
                    "Add player here",
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