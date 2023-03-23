abstract class AuthDatasource {
  Future<String> login({required String email, required String password});
}
