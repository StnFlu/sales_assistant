class Lead {
  final String id;
  final String name;
  final String email;
  final String status;
  final List<String> taskIds;

  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.taskIds,
  });

  Lead copyWith({
    String? name,
    String? email,
    String? status,
    List<String>? taskIds,
  }) {
    return Lead(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      taskIds: taskIds ?? this.taskIds,
    );
  }
}
