import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/constants.dart';
import 'package:getx_todo/controller/todo_controller.dart';
import 'package:getx_todo/model/todo.dart';
import 'package:getx_todo/widget/reusable_appbar.dart';
import 'package:intl/intl.dart';
import '../assets/icons/my_flutter_app_icons.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  TodoController todoController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? pickedDate;
  Priority _selectedPriority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(title: 'ADD NEW TODO'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _textController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter a description.';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: AppConstants().currentDate,
                            firstDate: AppConstants().currentDate,
                            lastDate: AppConstants()
                                .currentDate
                                .add(const Duration(days: 14)));
                        if (pickedDate != null) {
                          _dateController.text =
                              DateFormat('dd.MM.yyyy').format(pickedDate!);
                        }
                      },
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select a date',
                      ),
                    ),
                    DropdownButtonFormField<Priority>(
                      value: _selectedPriority,
                      items: Priority.values.map((priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (Priority? newValue) {
                        _selectedPriority = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Priority'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Todo newTodo = Todo(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _textController.text,
                    deadline: pickedDate,
                    priority: _selectedPriority);
                todoController.addTodo(newTodo); // new todo ekleniyor listeye
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: wheat.withOpacity(0.3), // Arka plan rengi floating button ile aynı
                foregroundColor: palette1, // Yazı rengi floating button ile aynı
                side: const BorderSide(
                  color: cafe_noir, // Kenar rengi floating button ile aynı
                  width: 0.5, // Kenar kalınlığı
                ),
                elevation: 0, // Gölgeyi kaldırmak için elevation'ı 0 yapıyoruz
                textStyle: const TextStyle(
                  fontSize: 18, // Yazı boyutu
                ),
              ),
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
