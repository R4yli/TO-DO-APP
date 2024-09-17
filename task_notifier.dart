import 'package:state_notifier/state_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_model.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  void searchTasks(String query) {
    final filteredTasks = state.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
    state = filteredTasks;
  }

  void deleteCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
    _saveTasks(); // Guarda las tareas actualizadas
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks') ?? '[]';
    final List<dynamic> taskList = jsonDecode(tasksJson);
    state = taskList.map((task) => Task.fromJson(task)).toList();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(state.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  void addTask(String title, Category category, [Priority priority = Priority.Baja, DateTime? reminderDateTime]) {
    final newTask = Task(title: title, category: category, priority: priority, reminderDateTime: reminderDateTime);
    state = [...state, newTask];
    _saveTasks();
  }

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            isCompleted: !state[i].isCompleted,
            category: state[i].category,
            priority: state[i].priority,
            reminderDateTime: state[i].reminderDateTime,
          )
        else
          state[i],
    ];
    _saveTasks();
  }
}