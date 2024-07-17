import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  // the box
  final _todoBox = Hive.box('todoBox');

  void createInitialData() {
    todoList = [
      {'taskName': 'Buy groceries', 'taskCompleted': false},
      {'taskName': 'Walk the dog', 'taskCompleted': true},
      {'taskName': 'Cook dinner', 'taskCompleted': false},
    ];
  }

  void loadData() {
    todoList = _todoBox.get('todoList');
  }

  void updateData() {
    _todoBox.put('todoList', todoList);
  }
}
