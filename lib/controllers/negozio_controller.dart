import 'dart:convert';
import 'package:fit_gym_flutter/models/negozio_model.dart';
import 'package:fit_gym_flutter/controllers/shared_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NegozioController {
  final SharedController sharedController = SharedController();

  // Ottiene l'email dell'utente loggato (usata come ID)
  Future<String?> _getUserEmail() async {
    await sharedController.caricaUtenteLoggato();
    final email = sharedController.model.email;
    if (email.isEmpty) return null;
    return email;
  }

  // Acquisto di un prodotto per l'utente loggato
  Future<void> acquistaProdotto(Prodotto prodotto) async {
    final prefs = await SharedPreferences.getInstance();
    final email = await _getUserEmail();
    if (email == null) return;

    // Chiavi personalizzate per utente
    final acquistiKey = 'acquisti_$email';
    final scadenzaKey = 'scadenza_abbonamento_$email';
    final ingressiKey = 'ingressi_disponibili_$email';

    // Carica acquisti esistenti e aggiunge il nuovo acquisto
    final acquistiJson = prefs.getString(acquistiKey) ?? '[]';
    final List list = jsonDecode(acquistiJson);
    list.add(prodotto.toJson());
    await prefs.setString(acquistiKey, jsonEncode(list));


    if (prodotto.tipo == 'abbonamento') {
      int mesi = 0;
      if (prodotto.nome.contains("Mensile")) mesi = 1;
      if (prodotto.nome.contains("Trimestrale")) mesi = 3;
      if (prodotto.nome.contains("Semestrale")) mesi = 6;
      if (prodotto.nome.contains("Annuale")) mesi = 12;

      await _aggiornaScadenzaAbbonamento(mesi, prefs, scadenzaKey);
    } else if (prodotto.tipo == 'ingresso') {
      await _aggiungiIngresso(prefs, ingressiKey);
    }
  }

  // Carica acquisti dell’utente
  Future<List<Prodotto>> caricaAcquistiUtente() async {
    final prefs = await SharedPreferences.getInstance();
    final email = await _getUserEmail();
    if (email == null) return [];
    final acquistiJson = prefs.getString('acquisti_$email');
    if (acquistiJson == null) return [];
    final List list = jsonDecode(acquistiJson);
    return list.map((e) => Prodotto.fromJson(e)).toList();
  }

  // Cancella tutti gli acquisti dell’utente
  Future<void> cancellaAcquistiUtente() async {
    final prefs = await SharedPreferences.getInstance();
    final email = await _getUserEmail();
    if (email == null) return;
    await prefs.remove('acquisti_$email');
  }

  // Aggiorna la scadenza dell’abbonamento
  Future<void> _aggiornaScadenzaAbbonamento(
      int mesi, SharedPreferences prefs, String key) async {
    final scadenzaString = prefs.getString(key);
    DateTime nuovaScadenza;

    if (scadenzaString != null) {
      final scadenzaAttuale = DateTime.parse(scadenzaString);
      if (scadenzaAttuale.isAfter(DateTime.now())) {
        nuovaScadenza = DateTime(
          scadenzaAttuale.year,
          scadenzaAttuale.month + mesi,
          scadenzaAttuale.day,
        );
      } else {
        nuovaScadenza = DateTime(
          DateTime.now().year,
          DateTime.now().month + mesi,
          DateTime.now().day,
        );
      }
    } else {
      nuovaScadenza = DateTime(
        DateTime.now().year,
        DateTime.now().month + mesi,
        DateTime.now().day,
      );
    }

    await prefs.setString(key, nuovaScadenza.toIso8601String());
  }

  // Aggiunge un ingresso per utente
  Future<void> _aggiungiIngresso(SharedPreferences prefs, String key) async {
    int ingressi = prefs.getInt(key) ?? 0;
    ingressi++;
    await prefs.setInt(key, ingressi);
  }

  // Ottiene lo stato utente (scadenza e ingressi)
  Future<Map<String, dynamic>> getStatoUtente() async {
    final prefs = await SharedPreferences.getInstance();
    final email = await _getUserEmail();
    if (email == null) return {'scadenza': null, 'ingressi': 0};

    final scadenzaStr = prefs.getString('scadenza_abbonamento_$email');
    final ingressi = prefs.getInt('ingressi_disponibili_$email') ?? 0;

    DateTime? scadenza;
    if (scadenzaStr != null) {
      scadenza = DateTime.parse(scadenzaStr);
      if (scadenza.isBefore(DateTime.now())) {
        await prefs.remove('scadenza_abbonamento_$email');
        scadenza = null;
      }
    }

    return {'scadenza': scadenza, 'ingressi': ingressi};
  }

}
