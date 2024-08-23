
import 'package:intl/intl.dart';

enum Priority { low, medium, high }

class Todo {
  String id;
  String name;
  bool isDone;
  DateTime? deadline; //nullable property
  Priority priority;

  Todo(
      {required this.id,
      required this.name,
      this.isDone = false,
      this.deadline,
      this.priority = Priority.medium});

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'].toString(),
      name: map['name'],
      isDone: map['isDone'] == 1 ? true : false,
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      priority: Priority.values[map['priority']],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone ? 1 : 0,
      'deadline': deadline?.toIso8601String(),
      'priority': priority.index,
    };
  }

  String get formattedDeadline {
    if (deadline != null) {
      return DateFormat('dd.MM.yyyy').format(deadline!);
    } else {
      return '';
    }
  }
}
