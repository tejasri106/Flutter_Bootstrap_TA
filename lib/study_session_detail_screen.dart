import 'package:flutter/material.dart';
import 'study_session.dart';

class StudySessionDetailScreen extends StatelessWidget {
  final StudySession session;

  const StudySessionDetailScreen({super.key, required this.session});

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Session Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.subject,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Duration: ${session.durationMinutes} minutes'),
            Text('Date: ${_formatDate(session.date)}'),
            const SizedBox(height: 16),
            const Text(
              'Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(session.notes ?? 'No notes provided'),
          ],
        ),
      ),
    );
  }
}
