import 'package:flutter/material.dart';
import 'reminder_model.dart';
import 'reminder_service.dart';
import 'reminder_utils.dart';
import 'add_reminder_screen.dart';

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({super.key});

  @override
  State<RememberMeScreen> createState() => _RememberMeScreenState();
}

class _RememberMeScreenState extends State<RememberMeScreen> {
  List<ReminderModel> _reminders = [];
  final _service = ReminderService();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final loaded = await _service.loadReminders();
    if (loaded.isEmpty) {
      // Dummy data for first run
      _reminders = [
        ReminderModel(
          id: '1',
          name: 'Θεία Άννα',
          date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          relation: 'θεία',
          memory: 'σου έφερνε κουλουράκια στη γιορτή σου όταν ήσουν μικρός',
        ),
        ReminderModel(
          id: '2',
          name: 'Παππούς Νίκος',
          date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          relation: 'παππούς',
          memory: '',
          isLoss: true,
        ),
      ];
      await _service.saveReminders(_reminders);
    } else {
      _reminders = loaded;
    }
    setState(() {});
  }

  Future<void> _addReminder() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddReminderScreen(
        onSave: (reminder) async {
          _reminders.add(reminder);
          await _service.saveReminders(_reminders);
          setState(() {});
        },
      ),
    ));
  }

  Future<void> _removeReminder(int idx) async {
    _reminders.removeAt(idx);
    await _service.saveReminders(_reminders);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final upcoming = _reminders.where((e) =>
      e.date.month == today.month && e.date.day == today.day
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Remember Me'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Reminder',
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
                      e.isLoss ? 'In Memory' : 'Special Day',
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
                              label: const Text('Call'),
                              onPressed: () {/* integrate call intent */},
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.edit_note),
                              label: const Text('Write'),
                              onPressed: () {/* integrate note intent */},
                            ),
                          ],
                        ElevatedButton.icon(
                          icon: const Icon(Icons.favorite),
                          label: Text(e.isLoss ? 'Light a candle' : 'Remember silently'),
                          onPressed: () {/* soft tribute action */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          if (upcoming.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'No special dates today.\nAdd a loved one to remember.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          const Divider(height: 32),
          const Text('All Reminders:', style: TextStyle(fontWeight: FontWeight.bold)),
          ..._reminders.asMap().entries.map((entry) => ListTile(
            leading: Icon(entry.value.isLoss ? Icons.candle : Icons.cake),
            title: Text('${entry.value.name} (${entry.value.relation})'),
            subtitle: Text(
              '${entry.value.date.day}/${entry.value.date.month}'
              '${entry.value.isLoss ? ' (In memory)' : ''}\n'
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
