// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'tasks': instance.tasks,
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      text: json['text'] as String,
      status: json['status'] as String? ?? 'normal',
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'text': instance.text,
      'status': instance.status,
    };
