import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../modules/remember_me/reminder_model.dart';
import '../../modules/remember_me/reminder_service.dart';
import '../../modules/remember_me/reminder_utils.dart';
import '../../core/logic/flow_feedback.dart';
import '../../l10n/app_localizations.dart';

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({super.key});

  @override
  State<RememberMeScreen> createState() => _RememberMeScreenState();
}

class _RememberMeScreenState extends State<RememberMeScreen> {
  List<ReminderModel> _reminders = [];
  final _service = ReminderService();
  String _reminderFeedback = '';
  String _searchText = ''; // Add search state

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final loaded = await _service.loadReminders();
    setState(() => _reminders = loaded);
    setState(() => _reminderFeedback = FlowFeedback.reminderFeedback(_reminders.length));
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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminders exported to: ${file.path}')),
    );
  }

  // Restore/Import
  Future<void> _importReminders() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);
      setState(() {
        _reminders = data.map((e) => ReminderModel.fromJson(e)).toList();
      });
      await _saveReminders();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reminders imported!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final today = DateTime.now();
    final upcoming = _reminders.where((e) =>
      e.date.month == today.month && e.date.day == today.day
    ).toList();

    // Filter reminders by search text
    final filteredReminders = _reminders.where((r) {
      final query = _searchText.toLowerCase();
      return r.name.toLowerCase().contains(query) ||
             r.relation.toLowerCase().contains(query) ||
             r.memory.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.menuRememberMe),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: loc.addReminder,
            onPressed: _addReminder,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: loc.exportHistoryCSV,
            onPressed: _exportReminders,
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            tooltip: loc.importReminders ?? 'Import Reminders',
            onPressed: _importReminders,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (_reminderFeedback.isNotEmpty)
            Card(
              color: Colors.orange[50],
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_reminderFeedback, style: const TextStyle(fontSize: 15))),
                  ],
                ),
              ),
            ),
          if (upcoming.isNotEmpty)
            ...upcoming.map((e) => _RememberMeReminderCard(entry: e, parentMounted: mounted)),
          if (upcoming.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                loc.noSpecialDatesToday,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          const Divider(height: 32),
          Text(loc.allReminders, style: const TextStyle(fontWeight: FontWeight.bold)),
          // Add search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                labelText: loc.searchReminders ?? 'Search reminders',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _searchText = val),
            ),
          ),
          ...filteredReminders.asMap().entries.map((entry) => Semantics(
            container: true,
            label: entry.value.isLoss
              ? '${loc.inMemory}: ${entry.value.name}, ${entry.value.relation}'
              : '${loc.specialDay}: ${entry.value.name}, ${entry.value.relation}',
            child: ListTile(
              leading: entry.value.isLoss
                  ? Text(loc.inMemoryEmoji, style: const TextStyle(fontSize: 24))
                  : const Icon(Icons.cake, semanticLabel: 'Birthday or special day'),
              title: Text('${entry.value.name} (${entry.value.relation})'),
              subtitle: Text(
                '${DateFormat('d MMM').format(entry.value.date)}'
                '${entry.value.isLoss ? ' (${loc.inMemory})' : ''}\n'
                '${entry.value.memory}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue, semanticLabel: 'Edit reminder'),
                    onPressed: () => _editReminder(entry.key),
                    tooltip: loc.edit ?? 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, semanticLabel: 'Delete reminder'),
                    onPressed: () => _removeReminder(entry.key),
                    tooltip: loc.delete ?? 'Delete',
                  ),
                ],
              ),
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
  final bool parentMounted;
  const _RememberMeReminderCard({required this.entry, required this.parentMounted});

  Future<void> _call(BuildContext context, String name, String? phone) async {
    if (phone != null && phone.isNotEmpty) {
      final uri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No phone app found.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No phone number available for $name.')),
      );
    }
  }

  Future<void> _sms(BuildContext context, String name, String? phone) async {
    if (phone != null && phone.isNotEmpty) {
      final uri = Uri(scheme: 'sms', path: phone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No SMS app found.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No phone number available for $name.')),
      );
    }
  }

  void _writeTribute(BuildContext context, String name) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Write a tribute to $name'),
        content: TextField(
          controller: controller,
          minLines: 2,
          maxLines: 5,
          decoration: const InputDecoration(hintText: 'Type your message...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (!parentMounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tribute sent to $name!')),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
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
    // Optionally, add a phone field to ReminderModel and pass it here
    final phone = null; // Replace with entry.phone if available
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
                      onPressed: () => _call(context, entry.name, phone),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit_note),
                      label: const Text('Write'),
                      onPressed: () => _writeTribute(context, entry.name),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.sms),
                      label: const Text('SMS'),
                      onPressed: () => _sms(context, entry.name, phone),
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
