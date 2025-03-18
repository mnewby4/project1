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
            Container(
              height: 40, 
              width: 420,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 103, 135, 1)
              ),
              child: Align(
                child: Text(
                  "Just a reminder that...",
                  //style: widget.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}