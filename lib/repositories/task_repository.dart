import '../models/task_model.dart';

class TaskRepository {
  List<Task> _mockTasks = [
    Task(
        id: '1',
        title: 'Follow up with John',
        description: 'Call John at 3 PM',
        isCompleted: false,
        leadId: '1'),
    Task(
        id: '2',
        title: 'Prepare report',
        description: 'Sales performance for Q1',
        isCompleted: false,
        leadId: '2'),
  ];

  Future<List<Task>> fetchTasks() async {
    return _mockTasks;
  }

  Future<void> changeTaskStatus(String id, bool status) async {
    _mockTasks = _mockTasks.map((task) {
      return task.id == id ? task.copyWith(isCompleted: status) : task;
    }).toList();
  }
}
