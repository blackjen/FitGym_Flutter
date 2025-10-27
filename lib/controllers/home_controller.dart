import 'dart:math';
import 'package:fit_gym_flutter/models/home_model.dart';

class HomeController {
  final HomeModel model = HomeModel();

  // Ritorna il nome completo dell’utente loggato
  String getNomeCompleto() {
    return "${model.nome} ${model.cognome}";
  }

  // Genera un codice casuale e lo salva nel model
  String generaCodiceCasuale() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String codice = List.generate(
      8,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
    model.codice = codice;
    return codice;
  }

  // Ritorna il codice attuale
  String getCodice() => model.codice;
}
