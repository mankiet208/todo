import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/data/repositories/todo/todo_repository.dart';
import 'package:todo/data/services/firebase/model/todo_request/todo_request.dart';
import 'package:todo/domain/models/todo/todo.dart';
import 'package:todo/utils/command.dart';
import 'package:todo/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required AuthRepository authRepository,
    required TodoRepository todoRepository,
  })  : _authRepository = authRepository,
        _todoRepository = todoRepository {
    load = Command0(_load)..execute();
    createTodo = Command1(_createTodo);
    updateTodo = Command1(_updateTodo);
    deleteTodo = Command1(_deleteTodo);
  }

  final AuthRepository _authRepository;
  final TodoRepository _todoRepository;
  final _log = Logger('HomeViewModel');

  late Command0 load;
  late Command1<void, TodoRequest> createTodo;
  late Command1<void, Todo> updateTodo;
  late Command1<void, String> deleteTodo;

  List<Todo> _todos = [];
  late final Stream<List<Todo>> _todosStream;

  List<Todo> get todos => _todos;
  Stream<List<Todo>> get todosStream => _todosStream;
  String get userId => _authRepository.currentUser?.uid ?? '';

  Future<Result> _load() async {
    _log.fine('Start loading todos');

    try {
      return await _getTodos();
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _createTodo(TodoRequest todo) async {
    try {
      final createTodoResult = await _todoRepository.createToDo(
        userId: userId,
        todo: todo,
      );

      switch (createTodoResult) {
        case Ok<String>():
          _log.fine('Created todo ${createTodoResult.value}');
        case Error<String>():
          _log.warning('Failed to create todo', createTodoResult.exception);
          return createTodoResult;
      }

      return await _getTodos();
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _updateTodo(Todo newTodo) async {
    // Update local data
    final oldTodoIndex = _todos.indexWhere((todo) => todo.id == newTodo.id);
    final oldTodo = _todos[oldTodoIndex];

    _todos[oldTodoIndex] = oldTodo.copyWith(
      isDone: newTodo.isDone,
    );

    _sortTodos();

    // Update UI
    notifyListeners();

    // Update Firestore
    final updateResult = await _todoRepository.updateToDo(
      userId: userId,
      todo: newTodo,
    );

    switch (updateResult) {
      case Ok<void>():
        _log.fine('Updated todo ${newTodo.id}');

      case Error<void>():
        _todos[oldTodoIndex] = oldTodo;
        notifyListeners();

        _log.warning(
            'Failed to update todo ${newTodo.id}', updateResult.exception);
        return updateResult;
    }

    return updateResult;
  }

  Future<Result> _deleteTodo(String id) async {
    try {
      final deleteResult = await _todoRepository.deleteTodo(
        userId: userId,
        todoId: id,
      );

      switch (deleteResult) {
        case Ok<void>():
          _log.fine('Deleted todo $id');
        case Error<void>():
          _log.warning('Failed to delete todo $id', deleteResult.exception);
          return deleteResult;
      }

      return await _getTodos();
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _getTodos() async {
    final result = await _todoRepository.getTodos(userId);

    switch (result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        _log.fine('Loaded todos');
      case Error<List<Todo>>():
        _log.warning('Failed to load todos', result.exception);
        return result;
    }

    _sortTodos();

    return result;
  }

  // ignore: unused_element
  Result _getTodosStream() {
    final result = _todoRepository.getTodosStream(userId);

    switch (result) {
      case Ok<Stream<List<Todo>>>():
        _todosStream = result.value;
        _log.fine('Loaded todos');
      case Error<Stream<List<Todo>>>():
        _log.warning('Failed to load todos', result.exception);
        return result;
    }

    return result;
  }

  void _sortTodos() {
    _todos.sort((a, b) => b.isDone ? -1 : 1);
  }
}
