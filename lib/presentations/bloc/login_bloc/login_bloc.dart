import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'package:poc_app/repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
      {required UserRepository userRepository,
      required AuthenticationBloc authenticationBloc})
      : _userRepository = userRepository,
        _authenticationBloc = authenticationBloc,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  // on<LoginButtonPressed>((event, emit) async {
  //   emit(LoginLoading());

  //   try {
  //     final token = await userRepository.login(
  //       event.email,
  //       event.password,
  //     );
  //     authenticationBloc.add(LoggedIn(token: token));
  //     emit(LoginInitial());
  //   } catch (error) {
  //     emit(LoginFailure(error: error.toString()));
  //   }
  // });

  FutureOr<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final token = await _userRepository.login(
        event.email,
        event.password,
      );
      _authenticationBloc.add(LoggedIn(token: token));
      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
