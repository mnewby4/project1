import 'package:flutter/material.dart';
import 'breathe.dart';
import 'meditate.dart';
import 'theme.dart';

class ActivityView extends StatelessWidget{
  const ActivityView({super.key, required this.quote});
  final String quote; 
  @override
  Widget build(BuildContext context) {
    return Scaffold (
       body: Center(
       child: ActivityPage(
        title: 'Relaxation Station',
        quote: quote,
        ),
      ),
    );
  }
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.title, required this.quote});
  final String title;
  final String quote;
  @override
  State<ActivityPage> createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  void navigateBreath() {
    print("breathing button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(84, 190, 123, 1),
        title: Text(
          widget.title,
          style: AppTheme.theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),

            /* Reminder Text */
            Container(
              height: 40, 
              width: 420,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 103, 135, 1)
              ),
              child: Align(
                child: Text(
                  "Just a reminder that...",
                  style: AppTheme.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 30),

            /* Positive Quote */
            Container(
              height: 200, 
              width: 380, 
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 241, 205, 1),
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
                    widget.quote,
                    style: AppTheme.theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            /* Activities Text */
            Container(
              height: 40, 
              width: 420,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 135, 99, 1)
              ),
              child: Align(
                child: Text(
                  "Activities",
                  style: AppTheme.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 30),
            
            /* Breathing Exercise Button */
            SizedBox(
              height: 150,
              width: 380,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BreathePage()),);
                },
                style: 
                  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(173, 249, 223, 1)),
                  ),
                child: Text(
                  "Breathing Exercise", 
                  style: AppTheme.theme.textTheme.titleMedium
                ),
              ),
            ),
            SizedBox(height: 30),
            
            /* Guided Meditation Button */
            SizedBox(
              height: 150,
              width: 380,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MeditatePage()));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(135, 202, 229, 1)),
                ),
                child: Text(
                  "Guided Meditation", 
                  style: AppTheme.theme.textTheme.titleMedium
                ),
              ),
            ),            
          ],
        ),
      ),
    );
  }
}
