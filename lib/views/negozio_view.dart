import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/negozio_controller.dart';
import 'package:fit_gym_flutter/models/negozio_model.dart';
import 'home_view.dart';
import 'corsi_view.dart';
import 'profilo_view.dart';

class NegozioView extends StatefulWidget {
  const NegozioView({super.key});

  @override
  State<NegozioView> createState() => _NegozioViewState();
}

class _NegozioViewState extends State<NegozioView> {
  final NegozioController controller = NegozioController();
  int _selectedIndex = 2;

  List<Prodotto> acquistiUtente = [];

  @override
  void initState() {
    super.initState();
    _caricaAcquisti();
  }

  Future<void> _caricaAcquisti() async {
    final acquisti = await controller.caricaAcquistiUtente();
    setState(() => acquistiUtente = acquisti);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
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
        // già su Negozio
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfiloView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista completa dei prodotti
    final List<Prodotto> prodotti = [
      Prodotto(
        nome: "Ingresso Singolo",
        descrizione: "Un singolo accesso alla palestra",
        prezzo: 10.0,
        tipo: "ingresso",
      ),
      Prodotto(
        nome: "Abbonamento Mensile",
        descrizione: "Accesso illimitato per 30 giorni",
        prezzo: 50.0,
        tipo: "abbonamento",
      ),
      Prodotto(
        nome: "Abbonamento Trimestrale",
        descrizione: "Accesso illimitato per 3 mesi",
        prezzo: 130.0,
        tipo: "abbonamento",
      ),
      Prodotto(
        nome: "Abbonamento Semestrale",
        descrizione: "Accesso illimitato per 6 mesi",
        prezzo: 240.0,
        tipo: "abbonamento",
      ),
      Prodotto(
        nome: "Abbonamento Annuale",
        descrizione: "Accesso illimitato per 12 mesi",
        prezzo: 450.0,
        tipo: "abbonamento",
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Negozio",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _mostraAcquisti,
                      icon: const Icon(Icons.receipt_long),
                      label: const Text("I miei acquisti"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: _mostraStatoUtente,
                      icon: const Icon(Icons.info_outline),
                      label: const Text("Stato"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Mostra tutti i prodotti
                ...prodotti.map(_buildCard).toList(),

                const SizedBox(height: 40),
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

  Widget _buildCard(Prodotto prodotto) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white.withOpacity(0.9),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Testo del prodotto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prodotto.nome,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    prodotto.descrizione,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Prezzo e pulsante
            Column(
              children: [
                Text(
                  "€ ${prodotto.prezzo.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _confermaAcquisto(prodotto),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Acquista",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confermaAcquisto(Prodotto prodotto) async {
    final confermato = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Conferma acquisto"),
        content: Text(
          "Sei sicuro di voler acquistare '${prodotto.nome}' al costo di €${prodotto.prezzo.toStringAsFixed(2)}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annulla"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
            ),
            child: const Text("Conferma"),
          ),
        ],
      ),
    );

    if (confermato == true) {
      await controller.acquistaProdotto(prodotto);
      await _caricaAcquisti();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${prodotto.nome} acquistato con successo!"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _mostraStatoUtente() async {
    final stato = await controller.getStatoUtente();

    final scadenza = stato['scadenza'] as DateTime?;
    final ingressi = stato['ingressi'] as int;

    String scadenzaStr = scadenza != null
        ? "${scadenza.day.toString().padLeft(2, '0')}/${scadenza.month.toString().padLeft(2, '0')}/${scadenza.year}"
        : "Nessun abbonamento attivo";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Stato Utente"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Scadenza abbonamento: $scadenzaStr"),
            const SizedBox(height: 10),
            Text("🎟️ Ingressi disponibili: $ingressi"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Chiudi"),
          ),
        ],
      ),
    );
  }

  Future<void> _mostraAcquisti() async {
    final acquisti = await controller.caricaAcquistiUtente();
    if (acquisti.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nessun acquisto effettuato.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("I miei acquisti"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: acquisti
                .map(
                  (p) => ListTile(
                    title: Text(p.nome),
                    subtitle: Text(p.descrizione),
                    trailing: Text("€ ${p.prezzo.toStringAsFixed(2)}"),
                  ),
                )
                .toList(),
          ),
        ),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.cancellaAcquistiUtente();
                  Navigator.pop(context);
                },
                child: const Text("Pulisci Acquisti"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Chiudi"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
