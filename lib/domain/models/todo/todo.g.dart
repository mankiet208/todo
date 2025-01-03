// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createDate': instance.createDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'isDone': instance.isDone,
    };
