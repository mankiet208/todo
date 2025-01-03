import 'package:todo/data/services/firebase/firestore_manager.dart';
import 'package:todo/data/services/firebase/model/todo_request/todo_request.dart';
import 'package:todo/domain/models/todo/todo.dart';
import 'package:todo/utils/exception.dart';
import 'package:todo/utils/result.dart';

class TodoFirestoreService {
  Result<Stream<List<Todo>>> getTodosStream(String userId) {
    try {
      final userDocRef =
          FirestoreManager.instance.getCollectionRef('users').doc(userId);
      final snapshotStream = userDocRef.collection('todos').snapshots();
      final todoStream = snapshotStream.map((snapshot) {
        return snapshot.docs.map((doc) {
          return Todo.fromFirestore(id: doc.id, data: doc.data());
        }).toList();
      });
      return Result.ok(todoStream);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }

  Future<Result<List<Todo>>> getTodos(String userId) async {
    try {
      final userDocRef =
          FirestoreManager.instance.getCollectionRef('users').doc(userId);
      final todoQuerySnapshot = await userDocRef.collection('todos').get();
      final todoDocs = todoQuerySnapshot.docs;
      final todos = todoDocs
          .map((doc) => Todo.fromFirestore(
                id: doc.id,
                data: doc.data(),
              ))
          .toList();

      return Result.ok(todos);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }

  Future<Result<String>> createTodo({
    required String userId,
    required TodoRequest todo,
  }) async {
    try {
      final doc = await FirestoreManager.instance
          .getCollectionRef('users')
          .doc(userId)
          .collection("todos")
          .add(todo.toJson());

      return Result.ok(doc.id);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }

  Future<Result> updateTodo({
    required String userId,
    required Todo todo,
  }) async {
    try {
      await FirestoreManager.instance
          .getCollectionRef('users')
          .doc(userId)
          .collection("todos")
          .doc(todo.id)
          .set(todo.toJson());

      return Result.ok(null);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }

  Future<Result> deleteTodo({
    required String userId,
    required String todoId,
  }) async {
    try {
      await FirestoreManager.instance
          .getCollectionRef('users')
          .doc(userId)
          .collection("todos")
          .doc(todoId)
          .delete();

      return Result.ok(null);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }
}
