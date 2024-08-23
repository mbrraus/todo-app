import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/database/database_service.dart';
import 'package:intl/intl.dart';
import 'package:getx_todo/constants.dart';
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
    loadTodos();
  }

  void changeSelected(DateTime date) {
    selectedDate = date;
    loadFilteredTodos();
  }

  Future<void> loadTodos() async {
    todosList = await _databaseService.getAllTodos();
    loadFilteredTodos();
  }

  void loadFilteredTodos() {
    List<Todo> filteredTodos = _applyFilters(todosList);
    streamController.sink.add(filteredTodos);
    print('loaded');
  }

  Future<void> addTodo(Todo newTodo) async {
    // todoList.add(newTodo);
    // filteredTodos = getTodosByDate();
    // update();
    //
    // try {
    //   await _databaseService.addTodo(newTodo); // Veritabanına kaydet
    // } catch (e) {
    //   todoList.remove(newTodo);
    //   filteredTodos = getTodosByDate();
    //   update();
    //   print('Veritabanına eklerken hata oluştu: $e');
    // }
    await _databaseService.addTodo(newTodo);
    loadTodos();
  }

  void deleteTodo(Todo todo) async {
    // todoList.remove(todo);
    // filteredTodos = getTodosByDate();
    // update();
    //
    // await DatabaseService().deleteTodo(todo.id);
    await _databaseService.deleteTodo(todo.id);
    loadTodos();
  }

  void changeTodo(Todo todo) async {
    todo.isDone = !todo.isDone;
    await _databaseService.updateTodo(todo);
    loadTodos();
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
