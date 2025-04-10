import 'package:flutter/material.dart';

void main() {
  runApp(const DateTimePickerApp());
}

class DateTimePickerApp extends StatelessWidget {
  const DateTimePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date & Time Picker',
      debugShowCheckedModeBanner: false,
      home: const DateTimePickerScreen(),
    );
  }
}

class DateTimePickerScreen extends StatefulWidget {
  const DateTimePickerScreen({super.key});

  @override
  State<DateTimePickerScreen> createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'No date selected';
    return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
  }

  String get _formattedTime {
    if (_selectedTime == null) return 'No time selected';
    return _selectedTime!.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Pick Date'),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Date: $_formattedDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _pickTime,
              child: const Text('Pick Time'),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Time: $_formattedTime',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
