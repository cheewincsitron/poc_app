import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/application/di/domain/auth_repo.dart';
import 'package:poc_app/di.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   AuthenticationBloc() : super(AuthenticationUninitialized()) {
//     final UserRepository userRepository = UserRepository();

//     on<AppStarted>((event, emit) async {
//       final bool hasToken = await userRepository.hasToken();
//       if (hasToken) {
//         emit(AuthenticationAuthenticated());
//       } else {
//         emit(AuthenticationUnauthenticated());
//       }
//     });

//     on<LoggedIn>((event, emit) async {
//       emit(AuthenticationLoading());
//       await userRepository.persistToken(event.token);
//       emit(AuthenticationAuthenticated());
//     });
//   }
// }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo _authRepo = s<AuthRepo>();
  // final UserRepository _userRepository = s<UserRepository>();
// final UserRepository _userRepository;

  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    // {
    //   on<AppStarted>(_onAppStarted);
    //   on<LoggedIn>(_onLoggedIn);
    // }

    // Future<void> _onAppStarted(
    //   AppStarted event,
    //   Emitter<AuthenticationState> emit,
    // ) async {
    //   final bool hasToken = await _userRepository.hasToken();
    //   if (hasToken) {
    //     return emit(AuthenticationAuthenticated());
    //   } else {
    //     return emit(AuthenticationUnauthenticated());
    //   }
    // }

    // Future<void> _onLoggedIn(
    //   LoggedIn event,
    //   Emitter<AuthenticationState> emit,
    // ) async {
    //   emit(AuthenticationLoading());
    //   await _userRepository.persistToken(event.token);
    //   return emit(AuthenticationAuthenticated());
    // }

    on<AppStarted>((event, emit) async {
      // final bool hasToken = await _authRepo.hasToken();
      // if (hasToken) {
      //   emit(AuthenticationAuthenticated());
      // } else {
      //   emit(AuthenticationUnauthenticated());
      // }
      final token = await _authRepo.getToken();
      if (token != null) {
        emit(AuthenticationAuthenticated(token: token));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await _authRepo.persistToken(event.token);
      emit(AuthenticationAuthenticated(token: event.token));
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await _authRepo.deleteToken();
      emit(AuthenticationUnauthenticated());
    });
  }
}
