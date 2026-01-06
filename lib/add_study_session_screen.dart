import 'package:flutter/material.dart';
import 'package:study_planner_app/services/firestore_service.dart';
import 'package:study_planner_app/study_session.dart';

class AddStudySessionScreen extends StatefulWidget {
  const AddStudySessionScreen({super.key});

  @override
  State<AddStudySessionScreen> createState() => _AddStudySessionScreenState();
}

class _AddStudySessionScreenState extends State<AddStudySessionScreen> {
  final _subjectController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  final firestoreService = FirestoreService();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveSession() async {
    if (_subjectController.text.trim().isEmpty ||
        _durationController.text.trim().isEmpty) return;

    final session = StudySession(
      id: '',
      subject: _subjectController.text.trim(),
      duration: int.parse(_durationController.text.trim()),
      date: _selectedDate,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    await firestoreService.addStudySession(session);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Study Session')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _durationController,
              decoration:
              const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _notesController,
              decoration:
              const InputDecoration(labelText: 'Notes (optional)'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Date: ${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSession,
              child: const Text('Save Session'),
            ),
          ],
        ),
      ),
    );
  }
}
