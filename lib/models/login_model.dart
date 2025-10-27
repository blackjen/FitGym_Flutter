class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  // Verifica che i campi non siano vuoti
  bool verifica() {
    return email.isNotEmpty && password.isNotEmpty;
  }

}
