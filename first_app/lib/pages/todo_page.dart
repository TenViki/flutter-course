import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoDatabase db = TodoDatabase();

  // ui dialog text editing controller
  TextEditingController controller = TextEditingController();
  final _todoBox = Hive.box('todoBox');

  @override
  void initState() {
    if (_todoBox.get('todoList') == null) {
      db.createInitialData();
    } else {
      // theres already some data in the box
      db.loadData();
    }

    super.initState();
  }

  void checkboxChanged(bool? checked, int index) {
    setState(() {
      db.todoList[index]['taskCompleted'] = checked;
    });

    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add({
        'taskName': controller.text,
        'taskCompleted': false,
      });
    });
    Navigator.pop(context);
    controller.text = '';

    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });

    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: db.todoList.length,
        itemBuilder: (context, index) => TodoTile(
          taskName: db.todoList[index]["taskName"],
          taskCompleted: db.todoList[index]["taskCompleted"],
          onChanged: (checked) => checkboxChanged(checked, index),
          onDelete: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
