import 'package:flutter/material.dart';

class BenvenutoController {
  void vaiAlLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void vaiAllaRegistrazione(BuildContext context) {
    Navigator.pushNamed(context, '/registrazione');
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
                  const Text('Inserisci la password per accedere all\'area Admin.'),
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
