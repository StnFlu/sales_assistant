import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _DashboardTile(
                    icon: Icons.people,
                    label: 'Leads',
                    onTap: () => Navigator.pushNamed(context, '/leads'),
                  ),
                  _DashboardTile(
                    icon: Icons.task,
                    label: 'Tasks',
                    onTap: () => Navigator.pushNamed(context, '/tasks'),
                  ),
                  _DashboardTile(
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  _DashboardTile(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {
                      // Handle notifications
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
