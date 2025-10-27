import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_gym_flutter/models/login_model.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final model = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!model.verifica()) {
      _mostraMessaggio(context, 'Inserisci email e password.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final utentiJson = prefs.getString('utenti');
    if (utentiJson == null) {
      _mostraMessaggio(context, 'Nessun utente registrato.');
      return;
    }

    final utenti = jsonDecode(utentiJson);
    final utenteTrovato = utenti.firstWhere(
      (u) => u['email'] == model.email && u['password'] == model.password,
      orElse: () => {},
    );

    if (utenteTrovato.isNotEmpty) {
      await prefs.setString('utente_loggato', jsonEncode(utenteTrovato));

      _mostraMessaggio(context, 'Accesso effettuato!');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _mostraMessaggio(context, 'Credenziali non valide.');
    }
  }

  void vaiAllaRegistrazione(BuildContext context) {
    Navigator.pushNamed(context, '/registrazione');
  }

  void _mostraMessaggio(BuildContext context, String messaggio) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(messaggio)));
  }

  // Funzione per aprire il popup di accesso admin
  void accediAdmin(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      barrierDismissible: false, // obbliga a premere Entra o Annulla
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Accesso Admin'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Inserisci la password per accedere all\'area Admin.',
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: errorText,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // chiudi dialog
                  child: const Text('Annulla'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_passwordController.text == '1234') {
                      Navigator.of(context).pop(); // chiudo dialog
                      Navigator.pushNamed(context, '/admin'); // apri AdminView
                    } else {
                      setState(() {
                        errorText = 'Password errata';
                      });
                    }
                  },
                  child: const Text('Entra'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
