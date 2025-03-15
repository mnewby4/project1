import 'package:flutter/material.dart';
import 'calendar.dart';
import 'activity.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  bool isActivity1On = true;
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(84, 190, 123, 1)),
      ),
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(
            children: [
              CalendarView(),
              ActivityView(),
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