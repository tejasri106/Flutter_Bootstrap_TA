import 'package:flutter/material.dart';
import 'package:study_planner_app/services/firestore_service.dart';
import 'package:study_planner_app/study_session.dart';
import 'add_study_session_screen.dart';

class StudyLogScreen extends StatelessWidget {
  const StudyLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Study Sessions')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddStudySessionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<StudySession>>(
        stream: firestoreService.getStudySessions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final sessions = snapshot.data!;

          if (sessions.isEmpty) {
            return const Center(child: Text('No study sessions yet'));
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];

              return ListTile(
                title: Text(session.subject),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${session.duration} minutes • '
                          '${session.date.month}/${session.date.day}/${session.date.year}',
                    ),
                    if (session.notes != null && session.notes!.isNotEmpty)
                      Text(
                        session.notes!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
