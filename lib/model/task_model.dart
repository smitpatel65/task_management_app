/// Represents a task in the Task Management app.
class TaskModel {
  /// Unique identifier for the task.
  final int taskId;

  /// Name/title of the task.
  final String taskName;

  /// Optional details or description about the task.
  final String? taskDetails;

  /// Indicates whether the task is marked as a favorite.
  bool isFavourite;

  /// Timestamp for when the task was created.
  final DateTime createdDate;

  /// Timestamp for when the task was last updated.
  final DateTime updatedDate;

  /// Constructor for initializing a TaskModel instance.
  TaskModel({
    required this.taskId,
    required this.taskName,
    this.taskDetails,
    required this.isFavourite,
    required this.createdDate,
    required this.updatedDate,
  });

  /// Factory constructor to create a `TaskModel` from a JSON map.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'] ?? 0, // Default ID to 0 if missing
      taskName: json['task_name'] ?? "Unnamed Task", // Default name if missing
      taskDetails:
          json['task_details'] ?? "No details available", // Default details
      isFavourite: json['is_favourite'] ?? false, // Default to false if missing
      createdDate:
          DateTime.tryParse(json['created_date'] ?? '') ??
          DateTime.now(), // Handle invalid/missing date
      updatedDate:
          DateTime.tryParse(json['updated_date'] ?? '') ?? DateTime.now(),
    );
  }

  /// Converts the `TaskModel` instance into a JSON map for API communication.
  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task_name': taskName,
      'task_details': taskDetails,
      'is_favourite': isFavourite,
      'created_date':
          createdDate.toIso8601String(), // Convert DateTime to string
      'updated_date': updatedDate.toIso8601String(),
    };
  }
}
