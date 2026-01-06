import 'package:cloud_firestore/cloud_firestore.dart';

class StudySession {
  final String id;
  final String subject;
  final int duration;
  final DateTime date;
  final String? notes;

  StudySession({
    required this.id,
    required this.subject,
    required this.duration,
    required this.date,
    this.notes,
  });

  factory StudySession.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudySession(
      id: doc.id,
      subject: data['subject'],
      duration: data['duration'],
      date: (data['date'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'duration': duration,
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'createdAt': Timestamp.now(),
    };
  }
}
