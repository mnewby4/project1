import 'package:flutter/material.dart';
import 'activity.dart';

class CalendarView extends StatelessWidget{
  const CalendarView({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
       body: const Center(
       child: const CalendarPage(title: 'Reflection Section'),
     )
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.title});
  final String title;
  @override
  State<CalendarPage> createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Calendar View here"),
          ],
        ),
      ),
    );
  }
}
