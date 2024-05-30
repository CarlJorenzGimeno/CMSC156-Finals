import 'package:finals/backend/firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/create_room.dart';
import 'package:finals/join_room.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Choose());
}

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("BGwithQ.png"),
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
                          AssetImage('Logo_Final_White.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Text(
                //Insert user name here
                'WELCOME, $name',
                style: const TextStyle(
                  color: Color(0xFF6D318D),
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 220,
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF6D318D),
                  border: Border.all(
                    color: Colors.white70,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Would you like to:',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          await createRoom();
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Create()));
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 50),
                            foregroundColor: const Color(0xFF6D318D),
                            backgroundColor: const Color(0xFFE4CD9D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 3),
                        child: const Text(
                          'Create Room',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Join()));
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 50),
                            foregroundColor: const Color(0xFF6D318D),
                            backgroundColor: const Color(0xFFE4CD9D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 3),
                        child: const Text(
                          'Join Room',
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 35),
                    foregroundColor: Colors.red,
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 18,
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
