import 'package:finals/backend/firestore.dart';
import 'package:finals/select_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(Join());
}

class Join extends StatelessWidget {
  Join({super.key});

  final TextEditingController _roomCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgwithQ.png"),
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
                      image: AssetImage('assets/Logo_Final_White.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 150,
                width: 320,
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF6D318D),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 4,
                    color: Colors.white70,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Enter Room Code:",
                        style: TextStyle(
                          color: Color(0xFFE4CD9D),
                          fontFamily: 'Times New Roman',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _roomCode,
                        textAlign: TextAlign.center,
                        textCapitalization:
                            TextCapitalization.characters,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF6D318D),
                              width: 5,
                            ),
                          ),
                          hintText: 'Enter room code',
                          labelStyle: const TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Color(0xFF6D318D),
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  debugPrint("Rawr");
                  debugPrint(_roomCode.text);
                  await joinRoom(_roomCode.text, context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Select()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    foregroundColor: const Color(0xFF6D318D),
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Join',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    foregroundColor: Colors.red,
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Cancel',
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
