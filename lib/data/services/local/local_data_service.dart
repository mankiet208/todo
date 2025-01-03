import 'package:todo/domain/models/todo/todo.dart';

class LocalDataService {
  final sampleTodos = [
    Todo(
      id: 'id_1',
      title: 'title 1',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: true,
    ),
    Todo(
      id: 'id_2',
      title: 'title 2',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    ),
    Todo(
      id: 'id_3',
      title: 'title 3',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    ),
    Todo(
      id: 'id_4',
      title: 'title 4',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: true,
    ),
    Todo(
      id: 'id_5',
      title: 'title 5',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: true,
    ),
    Todo(
      id: 'id_6',
      title: 'title 6',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    ),
    Todo(
      id: 'id_7',
      title: 'title 7',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    ),
    Todo(
      id: 'id_8',
      title: 'title 8',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: true,
    ),
    Todo(
      id: 'id_9',
      title: 'title 9',
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    ),
  ];
}
