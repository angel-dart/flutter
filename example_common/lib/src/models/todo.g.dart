// GENERATED CODE - DO NOT MODIFY BY HAND

part of example_common.src.models.todo;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Todo extends _Todo {
  @override
  String id;

  @override
  String text;

  @override
  bool completed;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  Todo({this.id, this.text, this.completed, this.createdAt, this.updatedAt});

  factory Todo.fromJson(Map data) {
    return new Todo(
        id: data['id'],
        text: data['text'],
        completed: data['completed'],
        createdAt: data['created_at'] is DateTime
            ? data['created_at']
            : (data['created_at'] is String
                ? DateTime.parse(data['created_at'])
                : null),
        updatedAt: data['updated_at'] is DateTime
            ? data['updated_at']
            : (data['updated_at'] is String
                ? DateTime.parse(data['updated_at'])
                : null));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'completed': completed,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static Todo parse(Map map) => new Todo.fromJson(map);

  Todo clone() {
    return new Todo.fromJson(toJson());
  }
}
