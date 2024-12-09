import 'package:sales_assistant/models/task_model.dart';

abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksError extends TasksState {
  final String message;

  TasksError(this.message);
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}
