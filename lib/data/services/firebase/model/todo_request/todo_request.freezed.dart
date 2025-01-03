// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoRequest _$TodoRequestFromJson(Map<String, dynamic> json) {
  return _TodoRequest.fromJson(json);
}

/// @nodoc
mixin _$TodoRequest {
  String get title => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  /// Serializes this TodoRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoRequestCopyWith<TodoRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoRequestCopyWith<$Res> {
  factory $TodoRequestCopyWith(
          TodoRequest value, $Res Function(TodoRequest) then) =
      _$TodoRequestCopyWithImpl<$Res, TodoRequest>;
  @useResult
  $Res call({String title, DateTime createDate, DateTime dueDate, bool isDone});
}

/// @nodoc
class _$TodoRequestCopyWithImpl<$Res, $Val extends TodoRequest>
    implements $TodoRequestCopyWith<$Res> {
  _$TodoRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createDate = null,
    Object? dueDate = null,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoRequestImplCopyWith<$Res>
    implements $TodoRequestCopyWith<$Res> {
  factory _$$TodoRequestImplCopyWith(
          _$TodoRequestImpl value, $Res Function(_$TodoRequestImpl) then) =
      __$$TodoRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, DateTime createDate, DateTime dueDate, bool isDone});
}

/// @nodoc
class __$$TodoRequestImplCopyWithImpl<$Res>
    extends _$TodoRequestCopyWithImpl<$Res, _$TodoRequestImpl>
    implements _$$TodoRequestImplCopyWith<$Res> {
  __$$TodoRequestImplCopyWithImpl(
      _$TodoRequestImpl _value, $Res Function(_$TodoRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createDate = null,
    Object? dueDate = null,
    Object? isDone = null,
  }) {
    return _then(_$TodoRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoRequestImpl with DiagnosticableTreeMixin implements _TodoRequest {
  const _$TodoRequestImpl(
      {required this.title,
      required this.createDate,
      required this.dueDate,
      required this.isDone});

  factory _$TodoRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoRequestImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime createDate;
  @override
  final DateTime dueDate;
  @override
  final bool isDone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoRequest(title: $title, createDate: $createDate, dueDate: $dueDate, isDone: $isDone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoRequest'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('isDone', isDone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, createDate, dueDate, isDone);

  /// Create a copy of TodoRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoRequestImplCopyWith<_$TodoRequestImpl> get copyWith =>
      __$$TodoRequestImplCopyWithImpl<_$TodoRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoRequestImplToJson(
      this,
    );
  }
}

abstract class _TodoRequest implements TodoRequest {
  const factory _TodoRequest(
      {required final String title,
      required final DateTime createDate,
      required final DateTime dueDate,
      required final bool isDone}) = _$TodoRequestImpl;

  factory _TodoRequest.fromJson(Map<String, dynamic> json) =
      _$TodoRequestImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get createDate;
  @override
  DateTime get dueDate;
  @override
  bool get isDone;

  /// Create a copy of TodoRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoRequestImplCopyWith<_$TodoRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
