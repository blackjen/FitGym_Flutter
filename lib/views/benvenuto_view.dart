import 'package:flutter/material.dart';
import 'package:fit_gym_flutter/controllers/benvenuto_controller.dart';

class BenvenutoView extends StatelessWidget {
  const BenvenutoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BenvenutoController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/Logo.png",
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            const Text(
              "BENVENUTO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 60),

            // Bottone LOGIN
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.vaiAlLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Bottone REGISTRATI
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.vaiAllaRegistrazione(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  "Registrati",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
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
