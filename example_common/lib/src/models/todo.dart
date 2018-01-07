library example_common.src.models.todo;

import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'todo.g.dart';

@serializable
class _Todo extends Model {
  String text;
  bool completed;
}
