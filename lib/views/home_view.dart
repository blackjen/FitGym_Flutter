import 'package:fit_gym_flutter/controllers/shared_controller.dart';
import 'package:fit_gym_flutter/views/negozio_view.dart';
import 'package:fit_gym_flutter/views/profilo_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/home_controller.dart';
import 'package:fit_gym_flutter/views/corsi_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = HomeController();
  final SharedController datiController = SharedController();
  final TextEditingController codiceController = TextEditingController();

  String nomeUtente = '';
  String codice = '';
  String cittaSelezionata = 'Ancona';
  int _selectedIndex = 0; // Home è l'indice 0 nella navigation bar

  @override
  // Libera la memoria
  void dispose() {
    codiceController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _caricaUtente();
  }

  Future<void> _caricaUtente() async {
    await datiController.caricaUtenteLoggato();
    setState(() {
      nomeUtente =
          "${datiController.model.nome} ${datiController.model.cognome}";
    });
  }

  void _ottieniCodice() {
    setState(() {
      codice = controller.generaCodiceCasuale();
      codiceController.text = codice;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CorsiView()),
        );
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NegozioView()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfiloView()),
        );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),

            Text(
              "Ciao, $nomeUtente",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),

            Image.asset("images/Logo.png", height: 250),

            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: cittaSelezionata,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                underline: const SizedBox(),
                dropdownColor: const Color(0xff00bcd4),
                items: const [
                  DropdownMenuItem(
                    value: 'Ancona',
                    child: Text(
                      'Ancona',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Roma',
                    child: Text('Roma', style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'Milano',
                    child: Text(
                      'Milano',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      cittaSelezionata = value;
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 40),

            // Pulsante e Codice
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _ottieniCodice,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00bcd4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      "Ottieni\nCodice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: codiceController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Codice",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.lightBlueAccent.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: codiceController.text),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Codice copiato negli appunti!"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Icon(Icons.copy, color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff00bcd4),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 50), //index 0
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined, size: 50), //index 1
            label: 'Corsi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 50), //index 2
            label: 'Negozio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 50), //index 3
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
