import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/task_bloc.dart';
import 'package:task_management_app/bloc/task_event.dart';
import 'package:task_management_app/repository/task_repo.dart';
import 'package:task_management_app/screen/task_list_screen.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Providing `TaskBloc` at the top level of the app.
      /// The `FetchTasks` event is dispatched immediately to load tasks from API.
      create: (_) => TaskBloc(TaskService())..add(FetchTasks()),

      /// Setting up the main application with `MaterialApp`.
      child: const MaterialApp(
        debugShowCheckedModeBanner: false, // Removes debug banner
        home: TaskListScreen(), // Main screen displaying task list
      ),
    );
  }
}
