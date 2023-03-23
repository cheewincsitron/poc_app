import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/entities/user.dart';
import 'package:poc_app/presentations/cubit/card/card_cubit.dart';
import 'package:poc_app/widgets/tinder_card.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CardCubit>().resetUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            buildCards(),
            buildButton(),
          ],
        ));
  }

  Widget buildCards() {
    final state = context.watch<CardCubit>().state;
    final users = state.users.toList();

    return users.isEmpty
        ? Center(
            child: Text("no more user"),
          )
        : Stack(
            children: users.map((user) {
              var index = users.indexOf(user);

              return TinderCard(
                user: User(
                    name: user.name, age: user.age, urlImage: user.urlImage),
                isFront: index == users.length - 1,
                idx: index,
              );
            }).toList(),
          );
  }

  Widget buildButton() {
    final state = context.watch<CardCubit>().state;
    final status = state.getStatus(force: true);
    final isLike = status == CardStatus.like;
    final isDisLike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.amber,
          ),
          // padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CardCubit>().resetUsers();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      maximumSize: const Size.square(80),
                      foregroundColor: Colors.grey,
                      backgroundColor: Colors.white),
                  child: const Icon(Icons.refresh),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CardCubit>().dislike();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      maximumSize: const Size.square(80),
                      foregroundColor: isDisLike ? Colors.white : Colors.red,
                      backgroundColor: isDisLike ? Colors.red : Colors.white),
                  child: Icon(Icons.close),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CardCubit>().like();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      maximumSize: Size.square(80),
                      foregroundColor: isLike ? Colors.white : Colors.green,
                      backgroundColor: isLike ? Colors.green : Colors.white),
                  child: Icon(Icons.favorite),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CardCubit>().superLike();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      maximumSize: Size.square(80),
                      foregroundColor: isSuperLike ? Colors.white : Colors.blue,
                      backgroundColor:
                          isSuperLike ? Colors.blue : Colors.white),
                  child: Icon(Icons.filter_vintage),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(
      Set<MaterialState> states, Color color, Color colorPressed, bool force) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return colorPressed;
    }
    return color;
  }

  MaterialStateProperty<Color> getColors(
      Color color, Color colorPressed, bool force) {
    return MaterialStateProperty.resolveWith(
        (states) => getColor(states, color, colorPressed, force));
  }
}
