import 'package:task_management_app/model/task_model.dart';

abstract class TaskEvent {}

class FetchTasks extends TaskEvent {}

class AddOrUpdateTask extends TaskEvent {
  final TaskModel task;
  AddOrUpdateTask(this.task);
}
