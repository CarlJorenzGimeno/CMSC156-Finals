import 'package:finals/backend/globals.dart';
import 'package:finals/choose_room.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Enter());
}

class Enter extends StatelessWidget {
  const Enter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EnterName(),
    );
  }
}

class EnterName extends StatelessWidget {
  EnterName({
    super.key,
  });

  final TextEditingController _nameController =
      TextEditingController();

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
                margin: const EdgeInsets.only(top: 80),
                height: 180,
                width: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('images/Logo_Final_White.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const Text(
                'WELCOME!',
                style: TextStyle(
                  color: Color(0xFF6D318D),
                  fontFamily: 'Times New Roman',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.7,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 40,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF6D318D),
                        style: BorderStyle.solid,
                        width: 10,
                      ),
                    ),
                    hintText: 'Enter username',
                    labelStyle: const TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color(0xFF6D318D),
                      fontSize: 25,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Missing Name"),
                            content: const Text(
                                "Please enter a username to use."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Ok"),
                              )
                            ],
                          );
                        });
                  } else {
                    name = _nameController.text;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Choose()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    foregroundColor: const Color(0xFF6D318D),
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 5),
                child: const Text(
                  'START',
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
