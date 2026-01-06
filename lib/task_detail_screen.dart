import 'package:flutter/material.dart';
import 'task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (task.description != null)
              Text(task.description!)
            else
              const Text('No description provided'),
            const SizedBox(height: 12),
            if (task.dueDate != null)
              Text(
                'Due: ${task.dueDate!.month}/${task.dueDate!.day}/${task.dueDate!.year}',
              ),
          ],
        ),
      ),
    );
  }
}
