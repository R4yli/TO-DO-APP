import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app2/task_model.dart';
import 'task_notifier.dart'; // Asegúrate de que la importación sea correcta

class AddTaskDialog extends ConsumerStatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();
  Category _selectedCategory = Category.Otros; // Valor predeterminado
  Priority _selectedPriority = Priority.Baja; // Valor predeterminado
  DateTime? _reminderDateTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nueva tarea'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Ingrese el nombre de la tarea'),
            ),
            DropdownButton<Category>(
              value: _selectedCategory,
              onChanged: (Category? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: Category.values.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
            ),
            DropdownButton<Priority>(
              value: _selectedPriority,
              onChanged: (Priority? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              items: Priority.values.map((Priority priority) {
                return DropdownMenuItem<Priority>(
                  value: priority,
                  child: Text(priority.toString().split('.').last),
                );
              }).toList(),
            ),
            ListTile(
              title: Text(_reminderDateTime == null ? 'No hay recordatorio' : 'Recordatorio: ${_reminderDateTime!.toLocal()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _reminderDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final title = _controller.text;
            if (title.isNotEmpty) {
              // Llamar a addTask con todos los parámetros necesarios
              ref.read(taskProvider.notifier).addTask(
                title,
                _selectedCategory,
                _selectedPriority,
                _reminderDateTime,
              );
              Navigator.pop(context);
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}