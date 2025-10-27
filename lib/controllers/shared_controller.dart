import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_gym_flutter/models/shared_model.dart';

class SharedController {
  final model = SharedModel();

  // Carica nel model i dati dell'utente loggato
  Future<void> caricaUtenteLoggato() async {
    final prefs = await SharedPreferences.getInstance();
    final utenteJson = prefs.getString('utente_loggato');
    if (utenteJson == null) return;

    final utente = jsonDecode(utenteJson);
    model.nome = utente['nome'] ?? '';
    model.cognome = utente['cognome'] ?? '';
    model.email = utente['email'] ?? '';
    model.password = utente['password'] ?? '';
  }

  //
  Future<void> aggiornaUtente(String nome, String cognome, String email, String password) async {
    final nuovoUtente = {
      'nome': nome,
      'cognome': cognome,
      'email': email,
      'password': password,
    };
    await aggiornaUtenteCompleto(nuovoUtente);
  }

  // Salva in Shared i dati dell'utente attualmente loggato
  Future<void> salvaUtenteLoggato(Map<String, dynamic> utente) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('utente_loggato', jsonEncode(utente));
  }

  Future<void> aggiornaUtenteCompleto(Map<String, dynamic> utente) async {
    final prefs = await SharedPreferences.getInstance();
    final utentiJson = prefs.getString('utenti');
    if (utentiJson == null) return;

    List utenti = jsonDecode(utentiJson);

    // Usa la vecchia email per cercare l'utente
    final emailVecchia = model.email;
    final indice = utenti.indexWhere((u) => u['email'] == emailVecchia);

    if (indice != -1) {
      // Sostituisci i dati esistenti con quelli nuovi
      utenti[indice] = utente;
    } else {
      return;
    }

    await prefs.setString('utenti', jsonEncode(utenti));

    // Aggiorna anche l’utente loggato
    await salvaUtenteLoggato(utente);

    // Aggiorna il model
    model
      ..nome = utente['nome']
      ..cognome = utente['cognome']
      ..email = utente['email']
      ..password = utente['password'];
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('utente_loggato');
  }
}
