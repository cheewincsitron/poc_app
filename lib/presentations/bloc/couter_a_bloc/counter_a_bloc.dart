import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_a_event.dart';
part 'counter_a_state.dart';

class CounterABloc extends Bloc<CounterAEvent, CounterAState> {
  CounterABloc() : super(CounterAState(count: 0)) {
    //Add Event
    on<CounterAEventAdd>((event, emit) {
      // state.count = state.count + 1; ไม่ควรทำแบบนี้ ควรจะใช้ copy
      emit(state.copyWith(count: state.count + 1));
    });

    //Add Event
    on<CounterAEventReset>((event, emit) {
      emit(state.copyWith(count: 0));
    });
  }
}
