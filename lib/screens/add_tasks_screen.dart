import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskTitile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
            textAlign: TextAlign.center,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              newTaskTitile = value;
              // print(newTaskTitile);
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Provider.of<TaskData>(context, listen: false).addTask(
                    newTaskTitile);
                Navigator.pop(context);
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent))
        ],
      ),
    );
  }
}
