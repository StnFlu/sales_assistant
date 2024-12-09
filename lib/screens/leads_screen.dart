import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/leads/leads_bloc.dart';
import '../blocs/leads/leads_state.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leads')),
      body: BlocBuilder<LeadsBloc, LeadsState>(
        builder: (context, state) {
          if (state is LeadsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LeadsLoaded) {
            return ListView.builder(
              itemCount: state.leads.length,
              itemBuilder: (context, index) {
                final lead = state.leads[index];
                return ListTile(
                  title: Text(lead.name),
                  subtitle: Text(lead.email),
                  trailing: Text(lead.status),
                  onTap: () {
                    Navigator.pushNamed(context, '/leads/${lead.id}');
                  },
                );
              },
            );
          } else if (state is LeadsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No leads available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/leads/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
