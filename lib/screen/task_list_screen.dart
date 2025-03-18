import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/task_bloc.dart';
import 'package:task_management_app/bloc/task_event.dart';
import 'package:task_management_app/bloc/task_state.dart';
import 'package:task_management_app/model/task_model.dart';
import 'task_form_screen.dart';

/// Displays a list of tasks and allows users to add, edit, and mark tasks as favorite.
/// Uses BLoC for state management.
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Management")),

      /// BLoC Builder listens to state changes and updates UI accordingly
      body: Stack(
        children: [
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Show loading indicator
              } else if (state is TaskLoaded) {
                if (state.tasks.isEmpty) {
                  return const Center(
                    child: Text("No tasks available"),
                  ); // Show message if no tasks
                }
                return ListView.separated(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index]; // Get current task

                    return ListTile(
                      title: Text(task.taskName),
                      subtitle: Text(
                        task.taskDetails ?? "No details",
                      ), // Handle null details
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Edit Task Button
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TaskFormScreen(
                                        task: task,
                                      ), // Open form screen
                                ),
                              );
                            },
                          ),

                          /// Favorite/Unfavorite Button
                          IconButton(
                            icon: Icon(
                              task.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  task.isFavourite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                task.isFavourite =
                                    !task.isFavourite; // Toggle favorite status
                              });

                              final updatedTask = TaskModel(
                                taskId: task.taskId, // Keep the same ID
                                taskName: task.taskName,
                                taskDetails: task.taskDetails,
                                createdDate: task.createdDate,
                                updatedDate: DateTime.now(), // Update timestamp
                                isFavourite:
                                    task.isFavourite, // Toggle favorite status
                              );

                              log(
                                "Task favorite status: ${updatedTask.isFavourite}",
                              );
                              context.read<TaskBloc>().add(
                                AddOrUpdateTask(updatedTask),
                              ); // Update task in Bloc
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                );
              } else if (state is TaskError) {
                return Center(
                  child: Text("Error: ${state.message}"),
                ); // Show error message
              } else {
                return const Center(child: Text("Unexpected state"));
              }
            },
          ),

          /// Bottom Center Button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TaskFormScreen(),
                    ), // Open add task form
                  );
                },
                child: const Text("Add Task"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
