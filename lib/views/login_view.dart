import 'package:fit_gym_flutter/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = LoginController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.only(top: 50),
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
                "LOGIN",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              const Icon(Icons.person, size: 150, color: Colors.white),
              const SizedBox(height: 50),

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

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => controller.login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Accedi',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Non hai un account? ",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => controller.vaiAllaRegistrazione(context),
                    child: const Text(
                      "Registrati!",
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

              const SizedBox(height: 120),

              ElevatedButton(
                onPressed: () => controller.accediAdmin(context),
                child: const Text("Apri Admin"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
