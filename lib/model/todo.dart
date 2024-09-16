import 'package:cloud_firestore/cloud_firestore.dart';
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
    print('deneme ');
    return Todo(
      id: map['id'],
      name: map['name'],
      isDone: map['isDone'],
      deadline: map['deadline'] != null
          ? (map['deadline'] as Timestamp).toDate()
          : null,
      priority: Priority.values.firstWhere(
          (e) => e.toString().split('.').last == map['priority'],
          orElse: () => Priority.medium),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone,
      'deadline': deadline != null ? Timestamp.fromDate(deadline!) : null,
      'priority': priority.toString().split('.').last,
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
