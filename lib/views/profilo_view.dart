import 'package:fit_gym_flutter/views/negozio_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/shared_controller.dart';
import 'package:fit_gym_flutter/controllers/profilo_controller.dart';
import 'login_view.dart';
import 'home_view.dart';
import 'corsi_view.dart';

class ProfiloView extends StatefulWidget {
  const ProfiloView({super.key});

  @override
  State<ProfiloView> createState() => _ProfiloViewState();
}

class _ProfiloViewState extends State<ProfiloView> {
  final SharedController datiController = SharedController();
  final ProfiloController controller = ProfiloController();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool editNome = false;
  bool editCognome = false;
  bool editEmail = false;

  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    await datiController.caricaUtenteLoggato();
    setState(() {
      nomeController.text = datiController.model.nome;
      cognomeController.text = datiController.model.cognome;
      emailController.text = datiController.model.email;
      passwordController.text = datiController.model.password;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CorsiView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NegozioView()),
        );
        break;
      case 3:
        // già su Profilo
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff00bcd4), Color(0xffffc107)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Profilo Utente",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                _buildField("Nome", nomeController, editNome, () {
                  setState(() => editNome = !editNome);
                }),
                const SizedBox(height: 20),

                _buildField("Cognome", cognomeController, editCognome, () {
                  setState(() => editCognome = !editCognome);
                }),
                const SizedBox(height: 20),

                _buildField("Email", emailController, editEmail, () {
                  setState(() => editEmail = !editEmail);
                }),
                const SizedBox(height: 20),

                // Password (blurrata, modificabile tramite popup)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enabled: false,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _modificaPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                      ),
                      child: const Text("Modifica"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Salva modifiche
                ElevatedButton(
                  onPressed: () async {
                    await datiController.aggiornaUtente(
                      nomeController.text,
                      cognomeController.text,
                      emailController.text,
                      passwordController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Modifica profilo completata"),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    setState(() {
                      editNome = false;
                      editCognome = false;
                      editEmail = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Salva",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    await datiController.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff00bcd4),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 50),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined, size: 50),
            label: 'Corsi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 50),
            label: 'Negozio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 50),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }

  // Indica che
  Widget _buildField(
    String label,
    TextEditingController controller,
    bool edit,
    VoidCallback clickModifica,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            enabled: edit,
            decoration: InputDecoration(
              hintText: label,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: clickModifica,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          child: const Text("Modifica"),
        ),
      ],
    );
  }

  void _modificaPassword() async {
    final vecchiaController = TextEditingController();
    final nuovaController = TextEditingController();

    final vecchiaInserita = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inserisci la vecchia password"),
        content: TextField(
          controller: vecchiaController,
          obscureText: true,
          decoration: const InputDecoration(hintText: "Vecchia password"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, vecchiaController.text),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (vecchiaInserita == null ||
        vecchiaInserita != datiController.model.password) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password vecchia errata")));
      return;
    }

    final nuovaInserita = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inserisci la nuova password"),
        content: TextField(
          controller: nuovaController,
          obscureText: true,
          decoration: const InputDecoration(hintText: "Nuova password"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, nuovaController.text),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (nuovaInserita != null && nuovaInserita.isNotEmpty) {
      await controller.cambiaPassword(vecchiaInserita, nuovaInserita);
      passwordController.text = nuovaInserita;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password aggiornata")));
    }
  }
}
