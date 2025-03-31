import 'package:flutter/material.dart';
import 'calendar.dart';
import 'activity.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
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
  int get todaysQuoteNum {
    int randomNum = Random().nextInt(quotes.length - 1);
    return randomNum;
  }
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(84, 190, 123, 1)),
        fontFamily: 'Verdana',
      ),
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(
            children: [
              CalendarView(),
              ActivityView(quote: quotes[todaysQuoteNum]),
            ],
          ),
          bottomNavigationBar: SizedBox( 
            height: 70.0, 
            child: TabBar(
              tabs: [
                Tab(
                  icon: new Icon(
                    Icons.emoji_emotions,
                    size: 40,
                  ),
                ),
                Tab(
                  icon: new Icon(
                    Icons.favorite,
                    size: 40,
                  ),
                ),
              ],
              labelColor: Colors.white, 
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(84, 190, 123, 1),
        ),
      ),
    );
  }
}