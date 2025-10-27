import 'package:fit_gym_flutter/views/admin_view.dart';
import 'package:fit_gym_flutter/views/benvenuto_view.dart';
import 'package:fit_gym_flutter/views/registrazione_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/views/login_view.dart';
import 'package:fit_gym_flutter/views/home_view.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Gym',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Schermata iniziale
      home:  BenvenutoView(),

      // Rotte per la navigazione
      routes: {
        '/benvenuto': (context) => const BenvenutoView(),
        '/login': (context) => const LoginView(),
        '/registrazione': (context) => const RegistrazioneView(),
        '/home': (context) => const HomeView(),
        '/admin': (context) => const AdminView(),
      },
    );
  }
}
