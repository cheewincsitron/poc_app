// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/application/di/domain/auth_repo.dart';
import 'package:poc_app/di.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo = s<AuthRepo>();
  final AuthenticationBloc _authenticationBloc;

  LoginCubit(
    this._authenticationBloc,
  ) : super(LoginInitial());

  void onLoginButtonPressed(
      {required String email, required String password}) async {
    emit(LoginLoading());
    final Either<Failure, String> result = await _authRepo.login(
      email: email,
      password: password,
    );
    result.fold(
      (l) => {emit(LoginFailure(error: l.message))},
      (r) => {_authenticationBloc.add(LoggedIn(token: r))},
    );
  }
}
