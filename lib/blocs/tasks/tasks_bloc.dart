import 'package:bloc/bloc.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';
import '../../repositories/task_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc(this.taskRepository) : super(TasksInitial()) {
    on<FetchTasks>((event, emit) async {
      emit(TasksLoading());
      try {
        final tasks = await taskRepository.fetchTasks();
        emit(TasksLoaded(tasks));
      } catch (e) {
        emit(TasksError('Failed to fetch tasks.'));
      }
    });

    on<UpdateTaskStatus>((event, emit) async {
      if (state is TasksLoaded) {
        try {
          await taskRepository.changeTaskStatus(
              event.taskId, event.isCompleted);
          final updatedTasks = (state as TasksLoaded).tasks.map((task) {
            return task.id == event.taskId
                ? task.copyWith(isCompleted: event.isCompleted)
                : task;
          }).toList();
          emit(TasksLoaded(updatedTasks));
        } catch (e) {
          emit(TasksError('Failed to complete task.'));
        }
      }
    });
  }
}
