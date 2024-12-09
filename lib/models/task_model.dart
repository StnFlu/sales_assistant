class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String? leadId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.leadId,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    String? leadId,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      leadId: leadId ?? this.leadId,
    );
  }
}
