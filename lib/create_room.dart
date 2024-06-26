import 'package:finals/backend/firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/select_character.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Create());
}

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  void initState() {
    super.initState();
    db
        .collection('rooms')
        .doc(currentRoom)
        .snapshots()
        .listen((event) {
      var data = event.data();
      debugPrint(data.toString());
      if (data?['p2_name'] != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Select()));
      }
    });
  }

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
                      image:
                          AssetImage('assets/Logo_Final_White.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 150,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.purple[600],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 4,
                    color: const Color(0xFFE4CD9D),
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
                        "Your Room Code:",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 3,
                            color: Colors.white70,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Text(
                          //PUT ROOM CODE HERE
                          currentRoom,
                          style: const TextStyle(
                              fontFamily: 'Times New Roman',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: CircularProgressIndicator(),
              ),
              // StreamBuilder(
              //     stream: db
              //         .collection('rooms')
              //         .doc(currentRoom)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else {
              //         Navigator.of(context).pop();
              //       }
              //     }),
              const SizedBox(height: 40),
              const Text(
                'Waiting for Other Players...',
                style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    foregroundColor: Colors.red,
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 16,
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
