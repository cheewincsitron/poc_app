// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_cubit.dart';

enum CardStatus { like, dislike, superLike }

abstract class CardState extends Equatable {
  const CardState();
}

class CardInitial extends CardState {
  late final Offset position;
  final bool isDragging;
  final Size screenSize;
  final double angle;
  late final List<User> users;

  CardInitial(
      {Offset? position,
      this.isDragging = false,
      this.screenSize = Size.zero,
      this.angle = 0,
      List<User>? users}) {
    this.position = position ?? Offset.zero;
    this.users = users ?? [];
  }

  CardInitial copyWith({
    Offset? position,
    bool? isDragging,
    Size? screenSize,
    double? angle,
    List<User>? users,
  }) {
    return CardInitial(
      position: position ?? this.position,
      isDragging: isDragging ?? this.isDragging,
      screenSize: screenSize ?? this.screenSize,
      angle: angle ?? this.angle,
      users: users ?? this.users,
    );
  }

  double getStatusOpacity() {
    const double delta = 100;
    final pos = max(position.dx.abs(), position.dy.abs());
    final opacity = pos / delta;
    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = position.dx;
    final y = position.dy;

    final forceSuperLike = x.abs() < 20;

    if (force) {
      const double delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      const double delta = 20;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta && forceSuperLike) {
        return CardStatus.superLike;
      }
    }
  }

  @override
  List<Object> get props => [position, isDragging, screenSize, angle, users];
}
