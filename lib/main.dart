import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/block/task_bloc.dart';
import 'package:task_management_app/block/task_event.dart';
import 'package:task_management_app/repository/task_repo.dart';
import 'package:task_management_app/screen/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(TaskService())..add(FetchTasks()),
      child: MaterialApp(home: TaskListScreen()),
    );
  }
}
