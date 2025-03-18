import 'package:flutter/material.dart';
import 'dart:math';

class ActivityView extends StatelessWidget{
  const ActivityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold (
       body: Center(
       child: ActivityPage(
        title: 'Relaxation Station',
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            titleSmall: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            titleMedium: const TextStyle(
              color: Colors.black,
              fontSize: 23,
            ),
            bodyMedium: const TextStyle(
              color: Colors.black,
              fontSize: 21,
            ),
          ),
         ), 
        ),
      ),
    );
  }
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.title, required this.theme});
  final String title;
  final ThemeData theme;
  @override
  State<ActivityPage> createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  List<String> quotes = [
    "No flower can grow without a little rain. Let go of control over what you cannot change.",
    "Grow towards your interests, like a plant reaching for the sun.",
    "You deserve the same kindness you give to others, so extend that kindness to yourself.",
    "How you've survived hardships before will help you survive it again in the present.",
    "Embrace the present moment and allow things to unfold at their own pace.",
    "Trust that everything will happen in the right timing for you at your own pace.",
    "Nature does not hurry yet everything is accomplished.",
    "Release negative thoughts about yourself that limit you from being who you truly are.",
    "The only person you should compare yourself to is yourself. Aim to be a tiny bit better than who you were yesterday.",
    "Nothing is perfect, yet everything is perfect. Trees can be contorted or bent and they're still beautiful",
  ];
  //String example = "The only person you should compare yourself to is yourself. Aim to be a tiny bit better than who you were yesterday.";
  DateTime todayDate = DateTime.now();

  void navigateBreath() {
    print("breathing button pressed");
  }

  int get todaysQuoteNum {
    int day = todayDate.difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return day % quotes.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(84, 190, 123, 1),
        title: Text(
          widget.title,
          style: widget.theme.textTheme.titleLarge,
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
                  style: widget.theme.textTheme.titleSmall,
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
                    quotes[todaysQuoteNum],
                    style: widget.theme.textTheme.bodyMedium,
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
                  style: widget.theme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 30),
            
            /* Breathing Exercise Button */
            SizedBox(
              height: 150,
              width: 380,
              child: ElevatedButton(
                onPressed: navigateBreath,
                style: 
                ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(173, 249, 223, 1)),
                ),
                child: Text(
                  "Breathing Exercise", 
                  style: widget.theme.textTheme.titleMedium
                ),
              ),
            ),
            SizedBox(height: 30),
            
            /* Guided Meditation Button */
            SizedBox(
              height: 150,
              width: 380,
              child: ElevatedButton(
                onPressed: navigateBreath,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(135, 202, 229, 1)),
                ),
                child: Text(
                  "Guided Meditation", 
                  style: widget.theme.textTheme.titleMedium
                ),
              ),
            ),            
          ],
        ),
      ),
    );
  }
}
