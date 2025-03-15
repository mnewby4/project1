import 'package:flutter/material.dart';
import 'calendar.dart';
import 'activity.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //color: Colors.yellow, 
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(
            children: [
              CalendarView(),
              ActivityView(),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.monitor_heart),
              ),
              Tab(
                icon: new Icon(Icons.rss_feed),
              ),
            ],
            labelColor: Colors.white, 
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}