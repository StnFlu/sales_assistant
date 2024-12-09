class AuthRepository {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    return email == 'test@test.com' && password == 'password';
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate logout
  }
}
