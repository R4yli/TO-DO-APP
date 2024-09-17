import 'package:flutter/material.dart';
import 'task_model.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Tarea'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Título: ${task.title}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Categoría: ${task.category.toString().split('.').last}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Prioridad: ${task.priority.toString().split('.').last}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Recordatorio: ${task.reminderDateTime != null ? task.reminderDateTime!.toLocal().toString() : 'No hay recordatorio'}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Completada: ${task.isCompleted ? 'Sí' : 'No'}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
