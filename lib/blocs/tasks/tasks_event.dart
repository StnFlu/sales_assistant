abstract class TasksEvent {}

class FetchTasks extends TasksEvent {}

class UpdateTaskStatus extends TasksEvent {
  final String taskId;
  final bool isCompleted;

  UpdateTaskStatus(this.taskId, this.isCompleted);
}
