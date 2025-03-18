import 'package:task_management_app/model/task_model.dart';

/// Abstract class representing all task-related events.
/// This is the base class for all events handled by the TaskBloc.
abstract class TaskEvent {}

/// Event to fetch tasks from the API or database.
/// This event is dispatched when the app starts or when the task list needs to be refreshed.
class FetchTasks extends TaskEvent {}

/// Event to add a new task or update an existing one.
/// This event carries a [TaskModel] object containing the task details.
class AddOrUpdateTask extends TaskEvent {
  final TaskModel task;

  /// Constructor to initialize the task.
  /// This event is triggered when a user adds or edits a task.
  AddOrUpdateTask(this.task);
}
