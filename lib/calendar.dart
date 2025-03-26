import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],

      appBar: AppBar(
        title: const Text('Reflection Section'),
        backgroundColor: Colors.green,
      ),

      // Main content is the CalendarPage
      body: const CalendarPage(),

      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.sentiment_satisfied_alt),
              color: Colors.white,
              onPressed: () {
                // Handle mood tracking or navigate to mood screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.white,
              onPressed: () {
                // Handle favorites or navigate to a different screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;

  // The current day
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TableCalendar widget
        TableCalendar(
          // Define the range of your calendar
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,

          // Highlight which day is selected
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

          //user taps a day
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },

          calendarStyle: CalendarStyle(
            // Highlight the selected day
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            // Highlight today's date
            todayDecoration: BoxDecoration(
              color: Colors.orangeAccent,
              shape: BoxShape.circle,
            ),
            // Adjust text styles, spacing, etc. as desired
          ),

          headerStyle: const HeaderStyle(
            // Center the month/year title
            titleCentered: true,
            formatButtonVisible: false,
          ),
        ),

        const SizedBox(height: 20),

        // "Add Today's Entry" button
        ElevatedButton(
          onPressed: () {
            // Navigate to your "Daily View" or open a modal
            // to record mood & journal entry
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text(
            "Add Today's Entry",
            style: TextStyle(color: Colors.white),
          ),
        ),

        const SizedBox(height: 20),
        Text(
          'Mood History (Coming Soon)',
          style: Theme.of(context).textTheme.titleMedium,

        ),
      ],
    );
  }
}
