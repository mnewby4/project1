import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'helper.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<String, Map<String, dynamic>> _moodEntries = {};

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadMoodEntries();
  }

  Future<void> _loadMoodEntries() async {
    final entries = await dbHelper.getAllEntries();
    setState(() {
      _moodEntries = {
        for (var entry in entries)
          entry['date']: {
            'mood': entry['mood'],
            'journal': entry['journal'],
          }
      };
    });
  }

  void _showMoodDialog(DateTime date) {
    int? selectedMood;
    TextEditingController journalController = TextEditingController();
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final existingEntry = _moodEntries[dateStr];

    if (existingEntry != null) {
      selectedMood = existingEntry['mood'];
      journalController.text = existingEntry['journal'] ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Mood Entry for $dateStr"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  final moods = ['😞', '🙁', '😐', '🙂', '😄'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = index;
                      });
                      Navigator.pop(context);
                      _showMoodDialog(date); // reopen to reflect change
                    },
                    child: Text(
                      moods[index],
                      style: TextStyle(
                        fontSize: 30,
                        backgroundColor: selectedMood == index ? Colors.grey[300] : Colors.transparent,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: journalController,
                decoration: const InputDecoration(
                  labelText: "Write about your day (optional)",
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (selectedMood != null) {
                  await dbHelper.insertEntry(dateStr, selectedMood!, journalController.text);
                  await _loadMoodEntries();
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker Calendar'),
      ),
      body: Column(
        children: [
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
                _showMoodDialog(selectedDay);
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final dateStr = DateFormat('yyyy-MM-dd').format(day);
                  if (_moodEntries.containsKey(dateStr)) {
                    final mood = _moodEntries[dateStr]!['mood'];
                    final emojis = ['😞', '🙁', '😐', '🙂', '😄'];
                    return Positioned(
                      bottom: 1,
                      child: Text(
                        emojis[mood],
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showMoodDialog(DateTime.now());
              },
              child: const Text("Add Today’s Entry"),
            ),
          ),
        ],
      ),
    );
  }
}
