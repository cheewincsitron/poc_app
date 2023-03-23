// ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'todo_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_state.g.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

@JsonSerializable()
class Todo extends TodoState {
  late final List<Task> tasks;

  Todo({List<Task>? tasks}) {
    this.tasks = tasks ?? [];
  }

  @override
  List<Object> get props => [tasks];

  Todo copyWith({
    List<Task>? tasks,
  }) {
    return Todo(
      tasks: tasks ?? this.tasks,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  String toString() => 'Todo(tasks: $tasks)';
}

@JsonSerializable()
class Task {
  String text;
  String status;
  Task({required this.text, this.status = 'normal'});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  String toString() => 'Task(text: $text, status: $status)';
}

// flutter pub run build_runner build --delete-conflicting-outputs