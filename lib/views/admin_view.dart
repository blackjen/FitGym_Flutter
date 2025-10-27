import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/admin_controller.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final AdminController controller = AdminController();
  List<Map<String, String>> utenti = [];

  @override
  void initState() {
    super.initState();
    caricaUtenti();
  }

  // Carica utenti da SharedPreferences
  Future<void> caricaUtenti() async {
    final lista = await controller.getUtenti();
    setState(() {
      utenti = lista;
    });
  }

  // Elimina un utente
  void eliminaUtente(String email) async {
    await controller.rimuoviUtente(email);
    await caricaUtenti();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Utente $email eliminato!")),
    );
  }

  // Reset lista utenti
  void resetLista() async {
    await controller.resetUtenti();
    await caricaUtenti();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Lista utenti resettata!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Lista Utenti"),
        backgroundColor: Colors.blueAccent,
      ),
      body: utenti.isEmpty
          ? const Center(child: Text("Nessun utente registrato."))
          : ListView.builder(
        itemCount: utenti.length,
        itemBuilder: (context, index) {
          final utente = utenti[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListTile(
              title: Text("${utente['nome']} ${utente['cognome']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${utente['email']}"),
                  Text("Password: ${utente['password']}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => eliminaUtente(utente['email'] ?? ""),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetLista,
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.refresh),
        tooltip: "Reset Lista Utenti",
      ),
    );
  }
}
