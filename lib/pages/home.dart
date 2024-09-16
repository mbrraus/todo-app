import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controller/todo_controller.dart';
import 'package:getx_todo/database/database_service.dart';
import 'package:getx_todo/pages/add_todo.dart';
import 'package:getx_todo/widget/custom_date_picker.dart';
import 'package:getx_todo/widget/reusable_appbar.dart';
import 'package:getx_todo/widget/search_box.dart';
import '../constants.dart';
import '../model/todo.dart';
import '../widget/todo_item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(title: 'TODO APP'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomDatePicker(),
            const SizedBox(
              height: 15,
            ),
            SearchBox(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<List<Todo>>(
                stream: todoController.streamController.stream,
                //this returns query snapshot (stream)
                builder: (context, snapshot) {
                  print(snapshot.connectionState);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('Error loading todos'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No todos available'));
                  } else {
                    final todos = snapshot.data!;
                    print(todos);
                    print(todos.length);
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              return TodoItem(todo: todos[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: FloatingActionButton(
          elevation: 0,
          // Gölgeyi kaldırıyoruz
          shape: const CircleBorder(
            side: BorderSide(
              color: cafe_noir, // Kenarlık rengi cafe_noir
              width: 0.5, // Kenarlık kalınlığı
            ),
          ),
          onPressed: () {
            Get.to(() => AddTodo());
          },
          backgroundColor: wheat.withOpacity(0.3),
          // Arka plan rengi saydamlıkla ayarlandı
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 35,
              color: palette1, // Yazı rengi palette1
            ),
          ),
        ),
      ),
    );
  }
}
