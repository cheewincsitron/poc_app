import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poc_app/entities/User.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardInitial> {
  CardCubit() : super(CardInitial());

  void startPosition(DragStartDetails details) {
    emit(state.copyWith(
      position: Offset.zero,
      isDragging: true,
    ));
  }

  void updatePosition(DragUpdateDetails details) {
    final Offset newPosition = state.position + details.delta;
    final x = newPosition.dx;
    final newAngle = 45 * x / state.screenSize.width;

    emit(state.copyWith(
      position: newPosition,
      angle: newAngle,
    ));
  }

  void endPosition(DragEndDetails details) {
    emit(state.copyWith(
      isDragging: false,
    ));

    final status = state.getStatus(force: true);
    print(status);

    if (status != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: status.toString().split('.').last.toUpperCase(), fontSize: 36);
    }

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }
  }

  resetPosition() {
    emit(state.copyWith(
      position: Offset.zero,
      isDragging: false,
      angle: 0,
    ));
  }

  void setScreenSize(Size size) {
    emit(state.copyWith(screenSize: size));
  }

  void resetUsers() {
    final List<User> users = [
      User(
          name: "Jason",
          age: 20,
          urlImage:
              "https://images.unsplash.com/photo-1595986630530-969786b19b4d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
      User(
          name: "Jason",
          age: 20,
          urlImage:
              "https://images.unsplash.com/photo-1595986630530-969786b19b4d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
      User(
          name: "Jason",
          age: 20,
          urlImage:
              "https://images.unsplash.com/photo-1595986630530-969786b19b4d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
      User(
          name: "Jason",
          age: 20,
          urlImage:
              "https://images.unsplash.com/photo-1595986630530-969786b19b4d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    ].reversed.toList();
    emit(state.copyWith(users: users));
  }

  void like() {
    emit(state.copyWith(
        angle: 20, position: Offset(2 * state.screenSize.width, 0)));
    _nextCard();
  }

  Future _nextCard() async {
    if (state.users.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    final newList = state.users.removeLast();
    emit(state.copyWith(users: state.users));
    resetPosition();
  }

  void dislike() {
    emit(state.copyWith(
        angle: -20, position: Offset(-2 * state.screenSize.width, 0)));
    _nextCard();
  }

  void superLike() {
    emit(state.copyWith(
        angle: 0, position: Offset(0, -state.screenSize.height)));
    _nextCard();
  }
}
