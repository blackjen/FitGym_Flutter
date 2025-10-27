class RegistrazioneModel {
  final String nome;
  final String cognome;
  final String email;
  final String password;
  final String confermaPassword;

  RegistrazioneModel({
    required this.nome,
    required this.cognome,
    required this.email,
    required this.password,
    required this.confermaPassword,
  });

  // Controlla campi vuoti
  bool verificaCampiVuoti() {
    return nome.isNotEmpty &&
        cognome.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confermaPassword.isNotEmpty;
  }

  // Controlla che le password coincidano
  bool verificaPassword() {
    return password == confermaPassword;
  }
}
