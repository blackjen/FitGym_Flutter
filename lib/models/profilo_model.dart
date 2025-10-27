class Utente {
  String nome;
  String cognome;
  String email;
  String password;

  Utente({
    required this.nome,
    required this.cognome,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'cognome': cognome,
    'email': email,
    'password': password,
  };

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
    nome: json['nome'],
    cognome: json['cognome'],
    email: json['email'],
    password: json['password'],
  );
}

class UtenteModel {
  late Utente utente;
}
