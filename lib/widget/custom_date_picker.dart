import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_todo/controller/todo_controller.dart';
import 'package:getx_todo/constants.dart';

class CustomDatePicker extends StatelessWidget {
  CustomDatePicker({super.key});

  TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 14)),
        initialSelectedDate: DateTime.now(),
        selectionColor: palette1,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          todoController.changeSelected(date);
        },
      ),
    );
  }
}
