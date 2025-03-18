import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/block/task_bloc.dart';
import 'package:task_management_app/block/task_event.dart';
import 'package:task_management_app/model/task_model.dart';

class TaskFormScreen extends StatefulWidget {
  final TaskModel? task;
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _taskNameController;
  late TextEditingController _taskDetailsController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing values if editing
    _taskNameController = TextEditingController(
      text: widget.task?.taskName ?? "",
    );
    _taskDetailsController = TextEditingController(
      text: widget.task?.taskDetails ?? "",
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDetailsController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final updatedTask = TaskModel(
        taskId: widget.task?.taskId ?? 0, // Default ID for new tasks
        taskName: _taskNameController.text,
        taskDetails: _taskDetailsController.text,
        createdDate: widget.task?.createdDate ?? DateTime.now(),
        updatedDate: DateTime.now(),
        isFavourite: widget.task?.isFavourite ?? false,
      );

      context.read<TaskBloc>().add(AddOrUpdateTask(updatedTask));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: "Task Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task Name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _taskDetailsController,
                decoration: InputDecoration(
                  labelText: "Task Details",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task Details are required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveTask, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
