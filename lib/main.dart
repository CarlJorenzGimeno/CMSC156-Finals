import 'package:finals/enter_name.dart';
import 'package:finals/firebase_options.dart';
import 'package:finals/mechanics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const RunMyApp());
}

class RunMyApp extends StatelessWidget {
  const RunMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/BGwithQ.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 170),
                height: 200,
                width: 360,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('images/Logo_Final_White.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EnterName()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF6D318D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Enter Game',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Mechanics()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 60),
                    foregroundColor: const Color(0xFF6D318D),
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'How to Play',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
