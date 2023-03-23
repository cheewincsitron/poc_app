part of 'counter_a_bloc.dart';

class CounterAState extends Equatable {
  final int count; //เป็น final จะได้ไม่ต้องเปลี่ยน state โดยตรง
  const CounterAState({required this.count});

  CounterAState copyWith({int? count}) {
    return CounterAState(count: count ?? this.count);
  }

  @override
  String toString() {
    return "count: $count";
  }

  @override
  List<Object> get props => [count]; //update ui เมื่อค่าพวกนี้เปลี่ยน
}
