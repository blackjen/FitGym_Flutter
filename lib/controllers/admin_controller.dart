import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AdminController {
  // Recupera tutti gli utenti registrati
  Future<List<Map<String, String>>> getUtenti() async {
    final prefs = await SharedPreferences.getInstance();
    final utentiJson = prefs.getString('utenti');
    if (utentiJson == null) return [];
    final List<dynamic> decoded = jsonDecode(utentiJson);
    // Convertiamo ogni utente in Map<String,String> (nome, cognome, email, password)
    return decoded.map((e) => Map<String, String>.from(e)).toList();
  }

  // Rimuove un utente dalla lista
  Future<void> rimuoviUtente(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final utentiJson = prefs.getString('utenti');
    if (utentiJson == null) return;

    List<dynamic> utenti = jsonDecode(utentiJson);
    utenti.removeWhere((u) => u['email'] == email);
    await prefs.setString('utenti', jsonEncode(utenti));
  }

  // Reset della lista completa
  Future<void> resetUtenti() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('utenti');
  }
}
