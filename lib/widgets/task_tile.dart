import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitile;
  final Function checkBoxCallback; 
  final Function longPressCallback;

  TaskTile({this.isChecked, this.taskTitile, this.checkBoxCallback, this.longPressCallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitile,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged:checkBoxCallback ,
      ),
    );
  }
}

