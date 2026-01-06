import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../task.dart';
import '../study_session.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;


  Stream<List<Task>> getTasks() {
    return _db
        .collection('users')
        .doc(_uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Future<void> addTask(Task task) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('tasks')
        .add(task.toMap());
  }

  Future<void> toggleTaskCompletion(Task task) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('tasks')
        .doc(task.id)
        .update({
      'isCompleted': !task.isCompleted,
    });
  }



  Stream<List<StudySession>> getStudySessions() {
    return _db
        .collection('users')
        .doc(_uid)
        .collection('study_sessions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => StudySession.fromFirestore(doc))
        .toList());
  }

  Future<void> addStudySession(StudySession session) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('study_sessions')
        .add(session.toMap());
  }
}
