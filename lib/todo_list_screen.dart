import 'package:flutter/material.dart';
import 'package:study_planner_app/services/firestore_service.dart';
import 'package:study_planner_app/task.dart';
import 'add_task_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Task>>(
        stream: firestoreService.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks yet'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return CheckboxListTile(
                value: task.isCompleted,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted ? Colors.grey : null,
                  ),
                ),
                subtitle: task.dueDate != null
                    ? Text(
                  'Due ${task.dueDate!.month}/${task.dueDate!.day}/${task.dueDate!.year}',
                  style: TextStyle(
                    color: task.isCompleted ? Colors.grey : null,
                  ),
                )
                    : null,
                onChanged: (_) {
                  firestoreService.toggleTaskCompletion(task);
                },
              );
            },
          );
        },
      ),
    );
  }
}
