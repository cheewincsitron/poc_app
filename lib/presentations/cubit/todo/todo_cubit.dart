import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poc_app/presentations/cubit/todo/todo_state.dart';

// part 'todo_state.dart';

class TodoCubit extends HydratedCubit<Todo> {
  TodoCubit() : super(Todo());

  void add(Task t) {
    final List<Task> newList = List.from(state.tasks)..add(t);
    emit(state.copyWith(tasks: newList));
  }

  void remove(Task t) {
    final List<Task> newList = List.from(state.tasks)..remove(t);
    emit(state.copyWith(tasks: newList));
  }

  @override
  Todo? fromJson(Map<String, dynamic> json) {
    return Todo.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Todo state) {
    return state.toJson();
  }
}
