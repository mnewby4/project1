import 'package:flutter/material.dart';
import 'theme.dart';

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
            SizedBox(height: 60),

            /* Heart Animation */
            Container(
              height: 400,
              child: Image.asset("assets/images/heart_pump.png"),
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