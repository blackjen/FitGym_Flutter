import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_gym_flutter/models/registrazione_model.dart';

class RegistrazioneController {
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confermaPasswordController = TextEditingController();

  Future<void> registraUtente(BuildContext context) async {
    final model = RegistrazioneModel(
      nome: nomeController.text.trim(),
      cognome: cognomeController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confermaPassword: confermaPasswordController.text.trim(),
    );

    if (!model.verificaCampiVuoti()) {
      _mostraMessaggio(context, 'Compila tutti i campi.');
      return;
    }

    if (!model.verificaPassword()) {
      _mostraMessaggio(context, 'Le password non coincidono.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final utentiJson = prefs.getString('utenti');
    List utenti = utentiJson != null ? jsonDecode(utentiJson) : [];

    final esiste = utenti.any((u) => u['email'] == model.email);
    if (esiste) {
      _mostraMessaggio(context, 'Utente già registrato.');
      return;
    }

    utenti.add({
      'nome': model.nome,
      'cognome': model.cognome,
      'email': model.email,
      'password': model.password
    });

    await prefs.setString('utenti', jsonEncode(utenti));

    _mostraMessaggio(context, 'Registrazione completata!');
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _mostraMessaggio(BuildContext context, String messaggio) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(messaggio)),
    );
  }
}
