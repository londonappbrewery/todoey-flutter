import 'dart:convert';
import 'package:todoey_flutter/services/storage.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey_flutter/model/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  Task removedTask;

  TaskData() {
    init();
  }
  SharedPreferences sharedPreferences = Storage().sharedPreferences;
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks {
    //we are creating getter as we set the main tasks to private. we did so , so that we remember that we can just add items to it using provider. we need to use the addTask method which we created.
    return UnmodifiableListView(_tasks); //also the above is unmodifieable
  }

  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    saveData();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    saveData();
    notifyListeners();
  }

  void deleteTask(Task task) {
    removedTask = task;

    _tasks.remove(task);
    notifyListeners();
    saveData();
  }

  void saveData() {
    List<String> spList =
        _tasks.map((item) => json.encode(item.toMap())).toList();
    print(spList);
    sharedPreferences.setStringList('list', spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    _tasks = spList.map((item) => Task.fromMap(json.decode(item))).toList();
    notifyListeners();
  }

  void retrieveTask() {
    _tasks.add(removedTask);
    saveData();
    notifyListeners();
  }
}
