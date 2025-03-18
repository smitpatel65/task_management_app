import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/repository/task_repo.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc(this.taskService) : super(TaskLoading()) {
    //get data from api
    on<FetchTasks>((event, emit) async {
      try {
        final tasks = await taskService.fetchTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddOrUpdateTask>((event, emit) async {
      try {
        await taskService.addOrUpdateTask(event.task);
        add(FetchTasks()); // Refresh tasks after update
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
