import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:todoey_flutter/model/task_data.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  SnackBar snackBar(TaskData taskData) => SnackBar(
        content: Text('You delted a task'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            taskData.retrieveTask();
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      //TODO NOTES
      builder: (context, task_data, child) {
        return ListView.builder(
          itemCount: task_data.tasks.length,
          itemBuilder: (context, index) {
            return TaskTile(
              taskTitile: task_data.tasks[index].name,
              //isChecked: Provider.of<TaskData>(context).tasks[index].isDone,
              //Provider.of<TaskData>(context).tasks = task_data. we would use LHS when we did not wrap with Consumer
              isChecked: task_data.tasks[index].isDone,
              checkBoxCallback: (bool checkboxState) {
                task_data.updateTask(task_data.tasks[index]);
                // setState(() {
                //   widget.Provider.of<TaskData>(context).tasks[index].toggleDone();
                // });
              },
              longPressCallback: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar(task_data));
                task_data.deleteTask(task_data.tasks[index]);
                HapticFeedback.heavyImpact();
              },
            );
          },
        );
      },
    );
  }
}
