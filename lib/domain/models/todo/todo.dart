import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required DateTime createDate,
    required DateTime dueDate,
    required bool isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);

  factory Todo.fromFirestore({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Todo(
      id: id,
      title: data['title'] as String,
      createDate: _toDateTime(data['createDate'])!,
      dueDate: _toDateTime(data['dueDate'])!,
      isDone: data['isDone'] as bool,
    );
  }

  static DateTime? _toDateTime(dynamic data) {
    return data != null
        ? (data is Timestamp
            ? data.toDate()
            : DateTime.tryParse(data as String))
        : null;
  }
}
