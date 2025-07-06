import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({Key? key}) : super(key: key);

  @override
  State<RememberMeScreen> createState() => _RememberMeScreenState();
}

class _RememberMeScreenState extends State<RememberMeScreen> {
  final List<_Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedReminders = prefs.getStringList('reminders');
    if (savedReminders != null) {
      setState(() {
        _reminders.clear();
        for (String reminder in savedReminders) {
          final parts = reminder.split('|');
          if (parts.length >= 3) {
            _reminders.add(
              _Reminder(
                name: parts[0],
                relation: parts[1],
                isLoss: parts[2] == 'true',
              ),
            );
          }
        }
      });
    }
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> reminderStrings = _reminders
        .map((reminder) => '${reminder.name}|${reminder.relation}|${reminder.isLoss}')
        .toList();
    await prefs.setStringList('reminders', reminderStrings);
  }

  void _addReminder() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String relation = '';
        bool isLoss = false;
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Relation'),
                onChanged: (value) => relation = value,
              ),
              SwitchListTile(
                title: const Text('Is this a loss?'),
                value: isLoss,
                onChanged: (value) => setState(() => isLoss = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _reminders.add(_Reminder(name: name, relation: relation, isLoss: isLoss));
                });
                _saveReminders();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteReminder(int index) {
    setState(() {
      _reminders.removeAt(index);
    });
    _saveReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remember Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ..._reminders.asMap().entries.map((entry) => ListTile(
                    leading: entry.value.isLoss
                        ? const Text('🙏', style: TextStyle(fontSize: 24))
                        : const Icon(Icons.cake),
                    title: Text('${entry.value.name} (${entry.value.relation})'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteReminder(entry.key),
                    ),
                  )),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addReminder,
              icon: const Icon(Icons.add),
              label: const Text('Add Reminder'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Reminder {
  final String name;
  final String relation;
  final bool isLoss;

  _Reminder({
    required this.name,
    required this.relation,
    required this.isLoss,
  });
}