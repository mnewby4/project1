import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker Calendar'),
      ),
      body: Column(
        children: [
          // Header text matching the proposal outline
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Select a date to view or add your mood entry",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                // When a day is selected, show a placeholder dialog for mood details.
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          "Mood Entry for ${selectedDay.toLocal().toString().split(' ')[0]}"),
                      content: const Text(
                          "Mood and journal entry details would appear here."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        )
                      ],
                    );
                  },
                );
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              // Marker to show mood entry for days (using a simple dummy example)
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  // For demonstration, we mark today with a dot.
                  if (isSameDay(day, DateTime.now())) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          // Button to add today's mood entry as described in the proposal.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Placeholder for adding today's entry.
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add Today's Entry"),
                      content: const Text(
                          "A form to add your mood and journal entry would appear here."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text("Add Today’s Entry"),
            ),
          ),
        ],
      ),
    );
  }
}