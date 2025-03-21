// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoRequestImpl _$$TodoRequestImplFromJson(Map<String, dynamic> json) =>
    _$TodoRequestImpl(
      title: json['title'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$$TodoRequestImplToJson(_$TodoRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createDate': instance.createDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'isDone': instance.isDone,
    };
