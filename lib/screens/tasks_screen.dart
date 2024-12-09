import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../blocs/tasks/tasks_event.dart';
import '../blocs/tasks/tasks_state.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return CheckboxListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    log('Task ${task.id} is completed: $value');
                    if (value == true) {
                      context
                          .read<TasksBloc>()
                          .add(UpdateTaskStatus(task.id, true));
                    } else {
                      context
                          .read<TasksBloc>()
                          .add(UpdateTaskStatus(task.id, false));
                    }
                  },
                );
              },
            );
          }
          return const Center(child: Text('No tasks available.'));
        },
      ),
    );
  }
}

class UncompleteTask {}
