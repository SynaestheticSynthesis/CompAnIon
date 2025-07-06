import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';

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
    final today = DateTime.now();
    final upcoming = _reminders.where((e) =>
      e.date.month == today.month && e.date.day == today.day
    ).toList();
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.menuRememberMe),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: loc.addReminder ?? 'Add Reminder',
            onPressed: _addReminder,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (upcoming.isNotEmpty)
            ...upcoming.map((e) => Card(
              color: e.isLoss ? Colors.orange[50] : Colors.lightBlue[50],
              margin: const EdgeInsets.only(bottom: 18),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.isLoss ? (loc.inMemory ?? 'In Memory') : (loc.specialDay ?? 'Special Day'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: e.isLoss ? Colors.orange : Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      buildHumanReminder(e),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (!e.isLoss)
                          ...[
                            ElevatedButton.icon(
                              icon: const Icon(Icons.phone),
                              label: Text(loc.call ?? 'Call'),
                              onPressed: () {/* integrate call intent */},
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.edit_note),
                              label: Text(loc.write ?? 'Write'),
                              onPressed: () {/* integrate note intent */},
                            ),
                          ],
                        ElevatedButton.icon(
                          icon: const Text('🙏', style: TextStyle(fontSize: 20)),
                          label: Text(e.isLoss ? (loc.lightCandle ?? 'Light a candle') : (loc.rememberSilently ?? 'Remember silently')),
                          onPressed: () {/* soft tribute action */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          if (upcoming.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                loc.noSpecialDatesToday ?? 'No special dates today.\nAdd a loved one to remember.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          const Divider(height: 32),
          Text(loc.allReminders ?? 'All Reminders:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ..._reminders.asMap().entries.map((entry) => ListTile(
            leading: entry.value.isLoss
                ? const Text('🙏', style: TextStyle(fontSize: 24))
                : const Icon(Icons.cake),
            title: Text('${entry.value.name} (${entry.value.relation})'),
            subtitle: Text(
              '${entry.value.date.day}/${entry.value.date.month}'
              '${entry.value.isLoss ? ' (${loc.inMemory ?? "In memory"})' : ''}\n'
              '${entry.value.memory}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeReminder(entry.key),
            ),
          )),
        ],
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