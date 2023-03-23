import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poc_app/application/di/data/auth_datasource.dart';
import 'package:poc_app/application/di/domain/auth_repo.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/domain/failures/fetch_failure.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDatasource authDatasource;

  const AuthRepoImpl({required this.authDatasource});

  @override
  Future<Either<Failure, String>> login(
      {required String email, required String password}) async {
    try {
      var token = await authDatasource.login(email: email, password: password);

      return Right(token);
    } catch (e) {
      return Left(FetchFailure(message: "LoginsRepo - login failed"));
    }
  }

  @override
  Future<bool> hasToken() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String?> getToken() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    var value = await storage.read(key: 'token');
    return value;
  }

  @override
  Future<void> persistToken(String token) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteToken() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    storage.delete(key: 'token');
    storage.deleteAll();
  }
}
