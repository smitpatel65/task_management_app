import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/block/task_bloc.dart';
import 'package:task_management_app/block/task_state.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Management")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return Center(child: Text("No tasks available"));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.taskName),
                  subtitle: Text(
                    task.taskDetails ?? "No details",
                  ), // Handle null case
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskFormScreen(task: task),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("Unexpected state"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskFormScreen()),
          );
        },
      ),
    );
  }
}
