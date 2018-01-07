import 'package:angel_client/flutter.dart';
import 'package:angel_flutter/ui/angel_animated_list.dart';
import 'package:example_common/example_common.dart';
import 'package:flutter/material.dart';
import 'widgets/todo_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Angel app;
  Service service;
  ServiceList todos;
  TextEditingController todoText = new TextEditingController();

  @override
  void initState() {
    super.initState();
    app = new Rest('http://localhost:3000');
    service = app.service('api/todos');
    todos = new ServiceList(service);
    service.index();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List (${todos.length})'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            child: new AlertDialog(
              title: const Text('New Todo'),
              content: new TextField(
                controller: todoText,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Todo Text',
                ),
              ),
              actions: [
                new FlatButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('CANCEL'),
                ),
                new FlatButton(
                  onPressed: () {
                    if (todoText.text.isNotEmpty) {
                      service.create({'text': todoText.text});
                      todoText.clear();
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: new RefreshIndicator(
        onRefresh: () => service.index().then((_) => null),
        child: new AngelAnimatedList(
          serviceList: todos,
          primary: true,
          defaultChild: (_) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          },
          emptyState: (_) {
            return const Center(
              child: const Text('No todos found.'),
            );
          },
          builder: (ctx, data, animation, index) {
            var todo = new Todo.fromJson(data);
            return new TodoItem(todo, service);
          },
        ),
      ),
    );
  }
}
