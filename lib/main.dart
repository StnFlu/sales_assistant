import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_assistant/blocs/leads/leads_bloc.dart';
import 'package:sales_assistant/blocs/leads/leads_event.dart';
import 'package:sales_assistant/blocs/tasks/tasks_bloc.dart';
import 'package:sales_assistant/blocs/tasks/tasks_event.dart';
import 'package:sales_assistant/blocs/theme/theme_bloc.dart';
import 'package:sales_assistant/blocs/theme/theme_state.dart';
import 'package:sales_assistant/login/view/login_page.dart';
import 'package:sales_assistant/repositories/lead_repository.dart';
import 'package:sales_assistant/repositories/task_repository.dart';
import 'package:sales_assistant/screens/create_lead_screen.dart';
import 'package:sales_assistant/screens/home_screen.dart';
import 'package:sales_assistant/screens/lead_details_screen.dart';
import 'package:sales_assistant/screens/leads_screen.dart';
import 'package:sales_assistant/screens/settings_screen.dart';
import 'package:sales_assistant/screens/tasks_screen.dart';
import 'package:sales_assistant/utils/bloc_observer.dart';
import 'package:sales_assistant/utils/extensions.dart';
import 'package:sales_assistant/utils/theme.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const AmptalkApp());
}

class AmptalkApp extends StatelessWidget {
  const AmptalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LeadRepository leadRepository = LeadRepository();
    final TaskRepository taskRepository = TaskRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()..loadThemeFromPreferences()),
        BlocProvider(
          create: (context) => LeadsBloc(leadRepository)..add(FetchLeads()),
        ),
        BlocProvider(
          create: (context) => TasksBloc(taskRepository)..add(FetchTasks()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData themeData;
          if (state is ThemeLoaded) {
            themeData = state.themeData;
          } else {
            themeData =
                context.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
          }

          return MaterialApp(
            title: 'Sales Assistant',
            home: const LoginPage(),
            theme: themeData,
            routes: {
              '/home': (_) => const HomeScreen(),
              '/leads': (_) => const LeadsScreen(),
              '/leads/create': (_) => const CreateLeadScreen(),
              '/tasks': (_) => const TasksScreen(),
              '/settings': (_) => const SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              final uri = Uri.parse(settings.name ?? '');

              if (uri.pathSegments.length == 2 &&
                  uri.pathSegments[0] == 'leads') {
                final leadId = uri.pathSegments[1];
                return MaterialPageRoute(
                  builder: (_) => LeadDetailsScreen(leadId: leadId),
                );
              }

              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('404: Page not found')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
