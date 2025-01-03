import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo_request.freezed.dart';
part 'todo_request.g.dart';

@freezed
class TodoRequest with _$TodoRequest {
  const factory TodoRequest({
    required String title,
    required DateTime createDate,
    required DateTime dueDate,
    required bool isDone,
  }) = _TodoRequest;

  factory TodoRequest.fromJson(Map<String, Object?> json) =>
      _$TodoRequestFromJson(json);
}
