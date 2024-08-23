import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_todo/constants.dart';
import 'package:getx_todo/controller/todo_controller.dart';
import '../assets/icons/my_flutter_app_icons.dart';

import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  TodoItem({super.key, required this.todo});

  TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => todoController.changeTodo(todo),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: palette1,
          ),
          title: Text(
            todo.name,
            style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Wrap(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: todoController.getPriorityColor(todo.priority),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.8,
                        offset: Offset(0, 1))
                  ]),
            ),
            const SizedBox(width: 5),
            IconButton(
              icon: const Icon(MyFlutterApp.trash_empty,color: palette1,),
              onPressed: () => todoController.deleteTodo(todo),
            ),
          ]),
        ),
      ),
    );
  }
}
