import 'package:todo/data/repositories/todo/todo_repository.dart';
import 'package:todo/data/services/model/todo_request/todo_request.dart';
import 'package:todo/data/services/firebase/todo_firestore_service.dart';
import 'package:todo/domain/models/todo/todo.dart';
import 'package:todo/utils/result.dart';

class TodoFirebaseRepository implements TodoRepository {
  TodoFirebaseRepository({
    required TodoFirestoreService service,
  }) : _service = service;

  final TodoFirestoreService _service;

  @override
  Result<Stream<List<Todo>>> getTodosStream(String userId) {
    return _service.getTodosStream(userId);
  }

  @override
  Future<Result<List<Todo>>> getTodos(String userId) {
    return _service.getTodos(userId);
  }

  @override
  Future<Result<String>> createToDo({
    required String userId,
    required TodoRequest todo,
  }) {
    return _service.createTodo(userId: userId, todo: todo);
  }

  @override
  Future<Result<void>> updateToDo({
    required String userId,
    required Todo todo,
  }) {
    return _service.updateTodo(userId: userId, todo: todo);
  }

  @override
  Future<Result<void>> deleteTodo({
    required String userId,
    required String todoId,
  }) {
    return _service.deleteTodo(userId: userId, todoId: todoId);
  }
}
