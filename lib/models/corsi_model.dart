class Corso {
  String nome;
  String descrizione;
  String orario;
  List<String> iscrittiEmail; // email degli utenti iscritti

  Corso({
    required this.nome,
    required this.descrizione,
    required this.orario,
    List<String>? iscrittiEmail,
  }) : iscrittiEmail = iscrittiEmail ?? [];
}

class CorsiModel {
  List<Corso> corsi;

  CorsiModel({List<Corso>? corsi}) : corsi = corsi ?? [];
}
