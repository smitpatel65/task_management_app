import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:task_management_app/model/task_model.dart';

class TaskService {
  static const String baseUrl = "https://hushed-foggy-dollar.glitch.me/api";

  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(Uri.parse("$baseUrl/glitch-tasks"));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      log(jsonList.toString());
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  Future<TaskModel> addOrUpdateTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add-task"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body)['task']);
    } else {
      throw Exception("Failed to add/update task");
    }
  }
}
