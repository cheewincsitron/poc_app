import 'package:dartz/dartz.dart';

import '../../../domain/failures/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> login(
      {required String email, required String password});

  Future<bool> hasToken();

  Future<String?> getToken();

  Future<void> persistToken(String token);

  Future<void> deleteToken();
}
