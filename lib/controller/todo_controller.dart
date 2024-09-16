import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/database/database_service.dart';
import 'package:intl/intl.dart';
import 'package:getx_todo/utils/constants.dart';
import '../model/todo.dart';

class TodoController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();
  final StreamController<List<Todo>> streamController =
      StreamController<List<Todo>>();

  var todosList = <Todo>[];
  var filteredList = <Todo>[];
  var selectedDate = AppConstants().currentDate;
  var searchKeyword = '';

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  List<Todo> _applyFilters(List<Todo> todos) {
    String selectedFormattedDate =
        DateFormat('dd.MM.yyyy').format(selectedDate);
    List<Todo> filteredTodos = todos.where((todo) {
      bool matchesDate = todo.formattedDeadline == selectedFormattedDate;
      return matchesDate; //eger tarihler match olur ise todo listeye dahil edilir
    }).toList();

    //this is search filter
    if (searchKeyword.isNotEmpty) {
      filteredTodos = filteredTodos.where((todo) {
        return todo.name.toLowerCase().contains(searchKeyword.toLowerCase());
      }).toList();
    }
    return filteredTodos;
  }

  void updateSearchKeyword(String keyword) {
    searchKeyword = keyword;
    loadFilteredTodos();
  }

  void changeSelected(DateTime date) {
    selectedDate = date;
    loadFilteredTodos();
  }

  void loadTodos()  {
    _databaseService.getTodos().listen((querySnapshot) {
      todosList = querySnapshot.docs.map((doc) => doc.data()).toList();
      loadFilteredTodos();
    });
  }

  void loadFilteredTodos() {
    List<Todo> filteredTodos = _applyFilters(todosList);
    streamController.sink.add(filteredTodos);
  }

  Future<void> addTodo(Todo newTodo) async {
    todosList.add(newTodo);
    await _databaseService.addTodo(newTodo);
    loadFilteredTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    todosList.removeWhere((t) => t.id == todo.id);
    await _databaseService.deleteTodo(todo.id);
    loadFilteredTodos();
  }

  Future<void> changeTodo(Todo todo) async {
    todo.isDone = !todo.isDone;
    await _databaseService.updateTodo(todo);
    loadFilteredTodos();
  }


  @override
  void onClose() {
    streamController.close();
    super.onClose();
  }

  Color getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
