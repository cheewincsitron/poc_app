// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poc_app/entities/user.dart';
import 'package:poc_app/presentations/cubit/card/card_cubit.dart';

class TinderCard extends StatefulWidget {
  final User user;
  final bool isFront;
  final int idx;

  const TinderCard({
    Key? key,
    required this.user,
    required this.isFront,
    required this.idx,
  }) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  Offset position = Offset(0, 0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      context.read<CardCubit>().setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront ? buildFrontCard() : buildCard();
  }

  Widget buildFrontCard() {
    return GestureDetector(
      child: BlocBuilder<CardCubit, CardInitial>(
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final position = state.position;
            final milliseconds = state.isDragging ? 0 : 400;

            final center = constraints.biggest.center(Offset.zero);
            // final center = Offset(200, 200);
            final angle = state.angle * pi / 180;
            final rotateMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              // color: Colors.amber,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotateMatrix..translate(position.dx, position.dy),
              child: Stack(children: [buildCard(), buildStamps()]),
            );
          });
        },
      ),
      onPanStart: (details) {
        // print("onPanStart $details");
        context.read<CardCubit>().startPosition(details);
        // setState(() {
        //   position = Offset(0, 0);
        // });
      },
      onPanUpdate: (details) {
        // print("onPanUpdate $details");
        // setState(() {
        //   position += details.delta;
        // });
        context.read<CardCubit>().updatePosition(details);
      },
      onPanEnd: (details) {
        // print("onPanEnd $details");
        // setState(() {
        //   position = Offset(0, 0);
        // });
        context.read<CardCubit>().endPosition(details);
      },
    );
  }

  Widget buildCard() {
    final state = context.watch<CardCubit>().state;

    return Container(
      color: widget.idx % 2 == 0 ? Colors.grey[100] : Colors.white,
      // child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(widget.user.urlImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text("100"),
                  ),
                ),
              ],
            ),
          ),
          Text(widget.user.name),
          Text(widget.user.age.toString()),
          // Text("isDragging: ${state.isDragging.toString()}"),
          // Text("screenSize.width: ${state.screenSize.width.toString()}"),
          // Text("angle: ${state.angle.toString()}"),
          // SizedBox(
          //   height: 500,
          // )
        ],
      ),
      // ),
    );
  }

  Widget buildCard2() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // height: MediaQuery.of(context).size.height / 1.5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.user.urlImage),
              fit: BoxFit.cover,
              alignment: Alignment(-0.3, 0)),
        ),
        // child: Container(padding: EdgeInsets.all(20), child: Text("100")),
      ),
    );
  }

  Widget buildStamps() {
    final state = context.watch<CardCubit>().state;
    final status = state.getStatus();
    final opacity = state.getStatusOpacity();

    switch (status) {
      case CardStatus.like:
        final child = buildStamp(
          angle: -0.5,
          color: Colors.green,
          text: 'LIKE',
          opacity: opacity,
        );
        return Positioned(top: 50, left: 50, child: child);
      case CardStatus.dislike:
        final child = buildStamp(
          angle: 0.5,
          color: Colors.red,
          text: 'DISLIKE',
          opacity: opacity,
        );
        return Positioned(top: 50, right: 50, child: child);
      case CardStatus.superLike:
        final child = Center(
          child: buildStamp(
            color: Colors.blue,
            text: 'SUPER\nLIKE',
            opacity: opacity,
          ),
        );
        return Positioned(bottom: 120, left: 0, right: 0, child: child);
      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required MaterialColor color,
    required String text,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
