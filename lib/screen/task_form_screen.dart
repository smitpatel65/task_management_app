import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/task_bloc.dart';
import 'package:task_management_app/bloc/task_event.dart';
import 'package:task_management_app/model/task_model.dart';

/// A screen that allows users to create or edit a task.
/// - Uses form validation to ensure all required fields are filled.
/// - Uses Bloc to manage task state updates.
class TaskFormScreen extends StatefulWidget {
  final TaskModel? task;

  /// Constructor: If a task is provided, the form will be pre-filled for editing.
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  late TextEditingController
  _taskNameController; // Controller for task name input
  late TextEditingController
  _taskDetailsController; // Controller for task details input

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing values if editing
    _taskNameController = TextEditingController(
      text: widget.task?.taskName ?? "",
    );
    _taskDetailsController = TextEditingController(
      text: widget.task?.taskDetails ?? "",
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free memory when the screen is closed
    _taskNameController.dispose();
    _taskDetailsController.dispose();
    super.dispose();
  }

  /// Validates the form and saves the task if inputs are valid.
  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final updatedTask = TaskModel(
        taskId:
            widget.task?.taskId ??
            0, // Assign task ID if editing, otherwise default to 0
        taskName: _taskNameController.text, // Get task name from user input
        taskDetails:
            _taskDetailsController.text, // Get task details from user input
        createdDate:
            widget.task?.createdDate ??
            DateTime.now(), // Preserve existing date or assign new one
        updatedDate: DateTime.now(), // Update timestamp
        isFavourite:
            widget.task?.isFavourite ?? false, // Preserve favorite status
      );

      // Dispatch event to update or add task
      context.read<TaskBloc>().add(AddOrUpdateTask(updatedTask));

      // Close the form screen and return to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? "Add Task" : "Edit Task",
        ), // Change title based on action
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign form key for validation
          child: Column(
            children: [
              /// Task Name Input Field
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: "Task Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task Name is required"; // Validation message if empty
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              /// Task Details Input Field
              TextFormField(
                controller: _taskDetailsController,
                decoration: InputDecoration(
                  labelText: "Task Details",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task Details are required"; // Validation message if empty
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              /// Save Button
              ElevatedButton(
                onPressed: _saveTask, // Call function to save the task
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
