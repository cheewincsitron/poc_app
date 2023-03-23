import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/presentations/cubit/todo/todo_cubit.dart';
import 'package:poc_app/presentations/cubit/todo/todo_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Chat")), body: _taskBuider());
  }

  Widget _taskBuider() {
    final todoCubit = context.watch<TodoCubit>().state;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: todoCubit.tasks
                .map((e) => ListTile(
                      title: Text(e.text),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoCubit>().remove(e);
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
              )),
              TextButton(
                  onPressed: () {
                    context.read<TodoCubit>().add(Task(text: controller.text));
                    controller.clear();
                  },
                  child: Text('Add')),
            ],
          ),
        ),
      ],
    );
  }
}
