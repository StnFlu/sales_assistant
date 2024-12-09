import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_assistant/blocs/leads/leads_bloc.dart';
import 'package:sales_assistant/blocs/leads/leads_state.dart';
import 'package:collection/collection.dart';
import 'package:sales_assistant/blocs/tasks/tasks_bloc.dart';
import 'package:sales_assistant/blocs/tasks/tasks_state.dart';

class LeadDetailsScreen extends StatelessWidget {
  final String leadId;

  const LeadDetailsScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    final leadsState = context.watch<LeadsBloc>().state;

    if (leadsState is LeadsLoaded) {
      final lead = leadsState.leads.firstWhereOrNull(
        (lead) => lead.id == leadId,
      );

      if (lead != null) {
        return Scaffold(
          appBar: AppBar(title: Text(lead.name)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${lead.name}\n${lead.email}\nStatus: ${lead.status}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Associated Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, state) {
                    if (state is TasksLoaded) {
                      final tasksForLead = state.tasks
                          .where((task) => task.leadId == lead.id)
                          .toList();
                      if (tasksForLead.isEmpty) {
                        return const Center(
                            child: Text('No tasks for this lead.'));
                      }
                      return ListView.builder(
                        itemCount: tasksForLead.length,
                        itemBuilder: (context, index) {
                          final task = tasksForLead[index];
                          return ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            trailing: task.isCompleted
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : const Icon(Icons.circle_outlined),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return const Scaffold(
          body: Center(child: Text('Lead not found.')),
        );
      }
    } else {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
