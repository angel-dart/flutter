import 'package:angel_client/angel_client.dart';
import 'package:example_common/example_common.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Service service;

  TodoItem(this.todo, this.service);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Checkbox(
          value: todo.completed == true,
          onChanged: (value) {
            todo.completed = value;
            service.modify(todo.id, todo.toJson());
          }),
      title: new Text(todo.text),
      subtitle: new Text(todo.createdAt?.toIso8601String() ?? ''),
      trailing: new IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => service.remove(todo.id),
      ),
    );
  }
}
