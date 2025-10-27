class SharedModel {
  String nome = '';
  String cognome = '';
  String email = '';
  String password = '';

  SharedModel();

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'cognome': cognome,
    'email': email,
    'password': password,
  };

  factory SharedModel.fromJson(Map<String, dynamic> json) => SharedModel()
    ..nome = json['nome'] ?? ''
    ..cognome = json['cognome'] ?? ''
    ..email = json['email'] ?? ''
    ..password = json['password'] ?? '';
}
