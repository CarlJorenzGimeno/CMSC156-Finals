import 'package:finals/backend/firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/game_room.dart';
import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  final bool guessing;
  const Select({super.key, this.guessing = false});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  int? glow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgwithQ.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Choose a Character',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 530,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: chars.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          guessing = index;
                          setState(() {
                            glow = guessing;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: (glow == index)
                                  ? Colors.purple
                                  : Colors.yellow,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: chars[index] ??
                                    const AssetImage("assets/images/Anon.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.guessing) {
                    guess = guessing;
                    guessCheck = true;
                    Navigator.of(context).pop();
                  } else {
                    //Set which field to change
                    String player = 'p2_chosen';
                    if (isHost) {
                      player = 'p1_chosen';
                    }
                    // Save chosen
                    db
                        .collection('rooms')
                        .doc(currentRoom)
                        .update({player: guessing});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Game()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    foregroundColor: const Color(0xFF6D318D),
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: Text(
                  (widget.guessing) ? 'Guess' : 'Select',
                  style: const TextStyle(
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
