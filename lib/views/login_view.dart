import 'package:fit_gym_flutter/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff00bcd4), Color(0xffffc107)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            Icon(Icons.person, size: 150, color: Colors.white),
            SizedBox(height: 50),

            // Campo Email
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
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

            SizedBox(height: 20),

            // Campo Password
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
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

            SizedBox(height: 30),

            // Bottone Accedi
            ElevatedButton(
              onPressed: () => controller.login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Accedi',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),

            SizedBox(height: 30),

            // Scritta cliccabile Registrati
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Non hai un account? ",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => controller.vaiAllaRegistrazione(context),
                  child: Text(
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
            // Bottone Admin
            ElevatedButton(
              onPressed: () {
                controller.accediAdmin(context);
              },
              child: const Text("Apri Admin"),
            ),
          ],
        ),
      ),
    );
  }
}
