import 'package:task_management_app/model/task_model.dart';

/// Base class for all task-related states.
/// This is used to define different states in the TaskBloc.
abstract class TaskState {}

/// Represents the loading state when tasks are being fetched.
/// This state is emitted while waiting for data to load from an API or database.
class TaskLoading extends TaskState {}

/// Represents the successful loading of tasks.
/// This state holds a list of `TaskModel` objects.
class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  /// Constructor to initialize the list of tasks.
  /// This state is emitted when tasks are successfully retrieved.
  TaskLoaded(this.tasks);
}

/// Represents an error state when fetching or processing tasks fails.
/// This state holds an error message describing the issue.
class TaskError extends TaskState {
  final String message;

  /// Constructor to initialize the error message.
  /// This state is emitted when an error occurs.
  TaskError(this.message);
}
