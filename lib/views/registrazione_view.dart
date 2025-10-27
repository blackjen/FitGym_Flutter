import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/registrazione_controller.dart';

class RegistrazioneView extends StatelessWidget {
  const RegistrazioneView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrazioneController controller = RegistrazioneController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff00bcd4), Color(0xffffc107)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "REGISTRAZIONE",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              const Icon(Icons.person_add, size: 120, color: Colors.white),
              const SizedBox(height: 40),

              // Campo Nome
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller.nomeController,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo Cognome
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller.cognomeController,
                  decoration: InputDecoration(
                    hintText: 'Cognome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo Email
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo Password
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo Conferma Password
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller.confermaPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Conferma Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Bottone Registrati
              ElevatedButton(
                onPressed: () => controller.registraUtente(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Registrati',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),

              // Scritta Torna al Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hai già un account? ",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Accedi!",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
