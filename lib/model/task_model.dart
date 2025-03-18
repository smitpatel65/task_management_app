class TaskModel {
  final int taskId;
  final String taskName;
  final String? taskDetails;
  final bool isFavourite;
  final DateTime createdDate;
  final DateTime updatedDate;

  TaskModel({
    required this.taskId,
    required this.taskName,
    this.taskDetails, // Nullable
    required this.isFavourite,
    required this.createdDate,
    required this.updatedDate,
  });

  // Factory method to create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'] ?? 0,
      taskName: json['task_name'] ?? "Unnamed Task",
      taskDetails: json['task_details'] ?? "No details available",
      isFavourite: json['is_favourite'] ?? false,
      createdDate:
          DateTime.tryParse(json['created_date'] ?? '') ?? DateTime.now(),
      updatedDate:
          DateTime.tryParse(json['updated_date'] ?? '') ?? DateTime.now(),
    );
  }

  // ✅ Define toJson method to convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task_name': taskName,
      'task_details': taskDetails,
      'is_favourite': isFavourite,
      'created_date': createdDate.toIso8601String(),
      'updated_date': updatedDate.toIso8601String(),
    };
  }
}
