import 'dart:convert'; // For encoding/decoding JSON
import 'dart:developer'; // For logging debug messages
import 'package:http/http.dart' as http; // HTTP package for API calls
import 'package:task_management_app/model/task_model.dart'; // Importing TaskModel

/// Service class responsible for making API requests related to tasks.
class TaskService {
  /// Base URL of the API
  static const String baseUrl = "https://hushed-foggy-dollar.glitch.me/api";

  /// Fetches the list of tasks from the API.
  Future<List<TaskModel>> fetchTasks() async {
    // Send a GET request to fetch all tasks
    final response = await http.get(Uri.parse("$baseUrl/glitch-tasks"));

    // If the response is successful, parse the JSON data
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body); // Decode JSON
      log(jsonList.toString()); // Log the response for debugging

      // Convert each JSON object to a TaskModel instance
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      // Throw an exception if the request fails
      throw Exception("Failed to load tasks");
    }
  }

  /// Adds a new task or updates an existing task in the API.
  Future<TaskModel> addOrUpdateTask(TaskModel task) async {
    // Send a POST request with the task data
    final response = await http.post(
      Uri.parse("$baseUrl/add-task"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()), // Convert task to JSON format
    );

    // If the response is successful, return the updated task model
    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body)['task']);
    } else {
      // Throw an exception if the request fails
      throw Exception("Failed to add/update task");
    }
  }
}
