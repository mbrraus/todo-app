import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_todo/controller/todo_controller.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});

  TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 13),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Lighter shadow
            offset: const Offset(0, 3), // Shadow position: 3 pixels down
            blurRadius: 1, // Blur radius
          ),
        ],
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (enteredKeyword) => todoController.updateSearchKeyword(enteredKeyword),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
