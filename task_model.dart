import 'package:flutter/foundation.dart';

enum Category { Trabajo, Personal, Otros }

enum Priority { Baja, Media, Alta }

class Task {
  String title;
  bool isCompleted;
  Category category;
  Priority priority;
  DateTime? reminderDateTime;

  Task({
    required this.title,
    this.isCompleted = false,
    this.category = Category.Otros,
    this.priority = Priority.Baja,
    this.reminderDateTime,
  });

  // Método para convertir un objeto JSON a una instancia de Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
      category: Category.values[json['category']],
      priority: Priority.values[json['priority']],
      reminderDateTime: json['reminderDateTime'] != null
          ? DateTime.parse(json['reminderDateTime'])
          : null,
    );
  }

  // Método para convertir una instancia de Task a JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'category': category.index,
      'priority': priority.index,
      'reminderDateTime': reminderDateTime?.toIso8601String(),
    };
  }
}
