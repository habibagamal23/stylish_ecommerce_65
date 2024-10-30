class LoginRequestBody {
  final String username;
  final String password;

  LoginRequestBody({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
