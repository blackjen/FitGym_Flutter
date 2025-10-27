import 'package:fit_gym_flutter/controllers/negozio_controller.dart';
import 'package:fit_gym_flutter/controllers/shared_controller.dart';

class ProfiloController {
  final SharedController sharedController = SharedController();
  final NegozioController negozioController = NegozioController();

  Future<void> cambiaPassword(String vecchia, String nuova) async {
    final nuovoUtente = {
      'nome': sharedController.model.nome,
      'cognome': sharedController.model.cognome,
      'email': sharedController.model.email,
      'password': nuova,
    };
    await sharedController.aggiornaUtenteCompleto(nuovoUtente);
  }

}
