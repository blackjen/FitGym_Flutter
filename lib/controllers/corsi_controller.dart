import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_gym_flutter/models/corsi_model.dart';

class CorsiController {
  final CorsiModel model = CorsiModel();

  final List<Corso> corsiFissi = [
    Corso(
      nome: 'Yoga',
      descrizione: 'Lezione di Yoga rilassante',
      orario: '08:00',
    ),
    Corso(
      nome: 'Pilates',
      descrizione: 'Pilates per principianti',
      orario: '10:00',
    ),
    Corso(
      nome: 'Crossfit',
      descrizione: 'Allenamento di Crossfit',
      orario: '18:00',
    ),
    Corso(
      nome: 'Ciclismo',
      descrizione: 'Allenamento con Bike',
      orario: '15:00',
    ),
    Corso(
      nome: 'Calistenics',
      descrizione: 'Allenamento a corpo libero',
      orario: '12:00',
    ),
    Corso(
      nome: 'Funzionale',
      descrizione: 'Allenamento misto, pesi e corpo libero',
      orario: '20:00',
    ),
  ];

  Future<void> caricaCorsi() async {
    final prefs = await SharedPreferences.getInstance();
    final corsiJson = prefs.getString('iscrizioni');

    model.corsi = corsiFissi.map((c) => Corso(
      nome: c.nome,
      descrizione: c.descrizione,
      orario: c.orario,
      iscrittiEmail: [],
    )).toList();

    if (corsiJson != null) {
      final iscrizioni = jsonDecode(corsiJson) as Map<String, dynamic>;
      for (final corso in model.corsi) {
        final iscritti = iscrizioni[corso.nome];
        if (iscritti != null) {
          corso.iscrittiEmail = List<String>.from(iscritti);
        }
      }
    }
  }

  Future<void> salvaIscrizioni() async {
    final prefs = await SharedPreferences.getInstance();
    final iscrizioni = {
      for (var c in model.corsi) c.nome: c.iscrittiEmail,
    };
    await prefs.setString('iscrizioni', jsonEncode(iscrizioni));
  }

  Future<void> iscriviUtente(String email, Corso corso) async {
    if (!corso.iscrittiEmail.contains(email)) {
      corso.iscrittiEmail.add(email);
      await salvaIscrizioni();
    }
  }

  Future<void> disiscriviUtente(String email, Corso corso) async {
    corso.iscrittiEmail.remove(email);
    await salvaIscrizioni();
  }

  bool isIscritto(String email, Corso corso) {
    return corso.iscrittiEmail.contains(email);
  }
}
