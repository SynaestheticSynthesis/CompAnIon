import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../modules/remember_me/reminder_model.dart';
import '../../modules/remember_me/reminder_service.dart';
import '../../modules/remember_me/reminder_utils.dart';

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
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final loaded = await _service.loadReminders();
    setState(() => _reminders = loaded);
  }

  Future<void> _saveReminders() async {
    await _service.saveReminders(_reminders);
  }

  Future<void> _addReminder() async {
    final newReminder = await showDialog<ReminderModel>(
      context: context,
      builder: (context) => _EditReminderDialog(),
    );
    if (newReminder != null) {
      setState(() => _reminders.add(newReminder));
      await _saveReminders();
    }
  }

  Future<void> _editReminder(int idx) async {
    final edited = await showDialog<ReminderModel>(
      context: context,
      builder: (context) => _EditReminderDialog(reminder: _reminders[idx]),
    );
    if (edited != null) {
      setState(() => _reminders[idx] = edited);
      await _saveReminders();
    }
  }

  Future<void> _removeReminder(int idx) async {
    setState(() => _reminders.removeAt(idx));
    await _saveReminders();
  }

  // Backup/Export
  Future<void> _exportReminders() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/reminders_backup.json');
    final jsonStr = jsonEncode(_reminders.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonStr);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminders exported to: ${file.path}')),
    );
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
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export Reminders',
            onPressed: _exportReminders,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (upcoming.isNotEmpty)
            ...upcoming.map((e) => _RememberMeReminderCard(entry: e)),
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
            leading: entry.value.isLoss
                ? const Text('🙏', style: TextStyle(fontSize: 24))
                : const Icon(Icons.cake),
            title: Text('${entry.value.name} (${entry.value.relation})'),
            subtitle: Text(
              '${DateFormat('d MMM').format(entry.value.date)}'
              '${entry.value.isLoss ? ' (In memory)' : ''}\n'
              '${entry.value.memory}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editReminder(entry.key),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeReminder(entry.key),
                  tooltip: 'Delete',
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _EditReminderDialog extends StatefulWidget {
  final ReminderModel? reminder;
  const _EditReminderDialog({this.reminder});
  @override
  State<_EditReminderDialog> createState() => _EditReminderDialogState();
}

class _EditReminderDialogState extends State<_EditReminderDialog> {
  late TextEditingController _nameController;
  late TextEditingController _relationController;
  late TextEditingController _memoryController;
  late DateTime _date;
  late bool _isLoss;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reminder?.name ?? '');
    _relationController = TextEditingController(text: widget.reminder?.relation ?? '');
    _memoryController = TextEditingController(text: widget.reminder?.memory ?? '');
    _date = widget.reminder?.date ?? DateTime.now();
    _isLoss = widget.reminder?.isLoss ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _relationController,
              decoration: const InputDecoration(labelText: 'Relation'),
            ),
            TextField(
              controller: _memoryController,
              decoration: const InputDecoration(labelText: 'Memory'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isLoss,
                  onChanged: (v) => setState(() => _isLoss = v ?? false),
                ),
                const Text('In memory (loss/tribute)')
              ],
            ),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _date = picked);
              },
              child: Text('Date: ${_date.day}/${_date.month}'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.trim().isEmpty) return;
            Navigator.of(context).pop(ReminderModel(
              id: widget.reminder?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
              name: _nameController.text.trim(),
              date: _date,
              relation: _relationController.text.trim(),
              memory: _memoryController.text.trim(),
              isLoss: _isLoss,
            ));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _RememberMeReminderCard extends StatelessWidget {
  final ReminderModel entry;
  const _RememberMeReminderCard({required this.entry});

  Future<void> _call(BuildContext context, String name) async {
    final uri = Uri(scheme: 'tel');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No phone app found.')),
      );
    }
  }

  Future<void> _sms(BuildContext context, String name) async {
    final uri = Uri(scheme: 'sms');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No SMS app found.')),
      );
    }
  }

  void _rememberSilently(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.isLoss ? 'Light a candle' : 'Remember silently'),
        content: Text(entry.isLoss
            ? 'A digital candle was lit in memory of ${entry.name}.'
            : 'You dedicated a silent thought to ${entry.name}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tribute = buildHumanReminder(entry);
    return Card(
      color: entry.isLoss ? Colors.orange[50] : Colors.lightBlue[50],
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.isLoss ? 'In Memory' : 'Special Day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: entry.isLoss ? Colors.orange : Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tribute,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (!entry.isLoss)
                  ...[
                    ElevatedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: const Text('Call'),
                      onPressed: () => _call(context, entry.name),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit_note),
                      label: const Text('Write'),
                      onPressed: () => _sms(context, entry.name),
                    ),
                  ],
                ElevatedButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: Text(entry.isLoss ? 'Light a candle' : 'Remember silently'),
                  onPressed: () => _rememberSilently(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
                      label: const Text('Call'),
                      onPressed: () => _call(context, entry.name),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit_note),
                      label: const Text('Write'),
                      onPressed: () => _sms(context, entry.name),
                    ),
                  ],
                ElevatedButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: Text(entry.isLoss ? 'Light a candle' : 'Remember silently'),
                  onPressed: () => _rememberSilently(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
