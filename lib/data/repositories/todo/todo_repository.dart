import 'package:todo/data/services/firebase/model/todo_request/todo_request.dart';
import 'package:todo/domain/models/todo/todo.dart';
import 'package:todo/utils/result.dart';

abstract class TodoRepository {
  Result<Stream<List<Todo>>> getTodosStream(String userId);
  Future<Result<List<Todo>>> getTodos(String userId);
  Future<Result<String>> createToDo({
    required String userId,
    required TodoRequest todo,
  });
  Future<Result<void>> updateToDo({
    required String userId,
    required Todo todo,
  });
  Future<Result<void>> deleteTodo({
    required String userId,
    required String todoId,
  });
}
