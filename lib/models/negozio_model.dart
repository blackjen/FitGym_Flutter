class Prodotto {
  final String nome;
  final String descrizione;
  final double prezzo;
  final String tipo; // Ingresso, Abbonamento

  Prodotto({
    required this.nome,
    required this.descrizione,
    required this.prezzo,
    required this.tipo,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'descrizione': descrizione,
    'prezzo': prezzo,
    'tipo': tipo,
  };

  factory Prodotto.fromJson(Map<String, dynamic> json) => Prodotto(
    nome: json['nome'],
    descrizione: json['descrizione'],
    prezzo: json['prezzo'],
    tipo: json['tipo'],
  );
}
