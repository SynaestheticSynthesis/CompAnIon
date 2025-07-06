import 'package:flutter/material.dart';
import 'reminder_model.dart';
import 'package:uuid/uuid.dart';

class AddReminderScreen extends StatefulWidget {
  final void Function(ReminderModel) onSave;
  const AddReminderScreen({required this.onSave, super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _memoryController = TextEditingController();
  DateTime? _date;
  bool _isLoss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(18),
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
                  : 'Date: ${_date!.day}/${_date!.month}'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isEmpty || _date == null) return;
                widget.onSave(ReminderModel(
                  id: const Uuid().v4(),
                  name: _nameController.text.trim(),
                  date: _date!,
                  relation: _relationController.text.trim(),
                  memory: _memoryController.text.trim(),
                  isLoss: _isLoss,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
