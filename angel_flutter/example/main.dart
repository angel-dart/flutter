import 'package:angel_client/flutter.dart';
import 'package:angel_flutter/ui/angel_animated_list.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Todo List'),
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
          builder: (ctx, item, animation, index) {
            // Add item-builder code here!
          },
        ),
      ),
    );
  }
}
