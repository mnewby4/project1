import 'package:flutter/material.dart';
import 'calendar.dart';

class ActivityView extends StatelessWidget{
  const ActivityView({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
       body: const Center(
       child: const ActivityPage(title: 'Relaxation Station'),
     )
    );
  }
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.title});
  final String title;
  @override
  State<ActivityPage> createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
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
            Text("Activity View here"),
          ],
        ),
      ),
    );
  }
}
