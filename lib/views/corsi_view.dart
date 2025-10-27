import 'package:fit_gym_flutter/views/negozio_view.dart';
import 'package:fit_gym_flutter/views/profilo_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/corsi_controller.dart';
import 'package:fit_gym_flutter/views/home_view.dart';
import 'package:fit_gym_flutter/controllers/shared_controller.dart';

class CorsiView extends StatefulWidget {
  const CorsiView({super.key});

  @override
  State<CorsiView> createState() => _CorsiViewState();
}

class _CorsiViewState extends State<CorsiView> {
  final CorsiController controller = CorsiController();
  final SharedController datiController = SharedController();
  String emailUtente = '';
  int _selectedIndex = 1; // Corsi è l'indice 1 nella navigation bar

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    await datiController.caricaUtenteLoggato();
    setState(() {
      emailUtente =
      "${datiController.model.email}";
    });
    await controller.caricaCorsi();
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        break;
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
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Corsi disponibili",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.model.corsi.length,
                  itemBuilder: (context, index) {
                    final corso = controller.model.corsi[index];
                    final isIscritto = controller.isIscritto(
                      emailUtente,
                      corso,
                    );

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  corso.nome,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${corso.descrizione}\nOrario: ${corso.orario}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (isIscritto) {
                                // disiscrizione
                                await controller.disiscriviUtente(
                                  emailUtente,
                                  corso,
                                );
                              } else {
                                // iscrizione
                                await controller.iscriviUtente(
                                  emailUtente,
                                  corso,
                                );
                              }
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isIscritto
                                  ? Colors.grey
                                  : Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              isIscritto ? 'Disiscriviti' : 'Iscriviti',
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
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
}
