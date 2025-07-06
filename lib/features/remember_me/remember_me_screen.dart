import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class RememberMeEntry {
  final String name;
  final DateTime date;
  final String relation;
  final String memory;
  final bool isLoss;

  RememberMeEntry({
    required this.name,
    required this.date,
    required this.relation,
    required this.memory,
    this.isLoss = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date.toIso8601String(),
    'relation': relation,
    'memory': memory,
    'isLoss': isLoss,
  };

  static RememberMeEntry fromJson(Map<String, dynamic> json) => RememberMeEntry(
    name: json['name'],
    date: DateTime.parse(json['date']),
    relation: json['relation'],
    memory: json['memory'],
    isLoss: json['isLoss'] ?? false,
  );
}

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({super.key});

  @override
  State<RememberMeScreen> createState() => _RememberMeScreenState();
}

class _RememberMeScreenState extends State<RememberMeScreen> {
  List<RememberMeEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('rememberMeEntries') ?? [];
    setState(() {
      _entries = raw
          .map((e) => RememberMeEntry.fromJson(Map<String, dynamic>.from(
              (e.isNotEmpty) ? Map<String, dynamic>.from(Uri.splitQueryString(e)) : {})))
          .toList();
    });
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'rememberMeEntries',
      _entries.map((e) => e.toJson().entries.map((kv) => '${kv.key}=${Uri.encodeComponent(kv.value.toString())}').join('&')).toList(),
    );
  }

  void _addEntry() async {
    final entry = await showDialog<RememberMeEntry>(
      context: context,
      builder: (context) => _RememberMeEntryDialog(),
    );
    if (entry != null) {
      setState(() {
        _entries.add(entry);
      });
      await _saveEntries();
    }
  }

  void _removeEntry(int idx) async {
    setState(() {
      _entries.removeAt(idx);
    });
    await _saveEntries();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final upcoming = _entries.where((e) =>
      e.date.month == today.month && e.date.day == today.day
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Remember Me'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Reminder',
            onPressed: _addEntry,
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
          ..._entries.asMap().entries.map((entry) => ListTile(
            leading: Text(
              entry.value.isLoss ? '🙏' : '',
              style: const TextStyle(fontSize: 24),
            ),
            title: Text('${entry.value.name} (${entry.value.relation})'),
            subtitle: Text(
              '${DateFormat('d MMM').format(entry.value.date)}'
              '${entry.value.isLoss ? ' (In memory)' : ''}\n'
              '${entry.value.memory}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeEntry(entry.key),
            ),
          )),
        ],
      ),
    );
  }
}

class _RememberMeEntryDialog extends StatefulWidget {
  @override
  State<_RememberMeEntryDialog> createState() => _RememberMeEntryDialogState();
}

class _RememberMeEntryDialogState extends State<_RememberMeEntryDialog> {
  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _memoryController = TextEditingController();
  DateTime? _date;
  bool _isLoss = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Loved One'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _relationController,
              decoration: const InputDecoration(labelText: 'Relation (e.g. aunt, grandpa)'),
            ),
            TextField(
              controller: _memoryController,
              decoration: const InputDecoration(labelText: 'Memory or Tag'),
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
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _date = picked);
              },
              child: Text(_date == null
                  ? 'Pick Date'
                  : 'Date: ${DateFormat('d MMM').format(_date!)}'),
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
            if (_nameController.text.trim().isEmpty || _date == null) return;
            Navigator.of(context).pop(RememberMeEntry(
              name: _nameController.text.trim(),
              date: _date!,
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
  final RememberMeEntry entry;
  const _RememberMeReminderCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final tribute = entry.isLoss
        ? "Σήμερα θα είχε γενέθλια ο/η ${entry.name}. Θες να του/της πεις κάτι σιωπηλά ή να ανάψουμε μαζί ένα ‘ψηφιακό κερί’;"
        : "Θυμάσαι που ${entry.memory.isNotEmpty ? entry.memory : entry.name}... Αύριο/σήμερα γιορτάζει. Ίσως ένα τηλεφώνημα, ένα γράμμα ή μια μικρή πράξη να είναι το δικό σου δώρο σήμερα.";
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
                  label: Text(entry.isLoss ? 'Light a candle' : 'Remember silently'),
                  onPressed: () {/* soft tribute action */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
