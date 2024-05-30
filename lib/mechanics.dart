import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Mechanics()));
}

class Mechanics extends StatelessWidget {
  const Mechanics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("BGwithQ.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'How to Play',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D318D),
                    border: Border.all(
                      color: Colors.white70,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        stepStyle('1. Player will enter their username.'),
                        stepStyle('2. Player will choose to create or join a room.'),
                        stepStyle('3. If creating a room, the player will receive a room code to share.'),
                        stepStyle('4. If joining a room, the player will enter the received room code.'),
                        stepStyle('5. Both players will choose a random character from a set of characters.'),
                        stepStyle("6. Players will take turns asking yes/no questions, based on chosen custom game mode, to deduce the opponent's character."),
                        stepStyle('7. Players will use answers to eliminate characters on their board.'),
                        stepStyle("8. At any time during their turn, players can guess the opponent's character."),
                        stepStyle("9. The game continues until one player correctly guesses the opponent's character."),
                        stepStyle('10. The player who guesses correctly wins the game.'),
                        const SizedBox(height: 10),
                        const Text(
                          'Custom Game Modes',
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        customGameModeStyle('Vibes-Vibes Baby',
                            'Players will take turns giving and guessing vibe-based clues about their character.'),
                        customGameModeStyle("Hue's Who?",
                            "Players will ask questions related to colors associated with the characters, such as their clothing, accessories, or background elements."),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 35),
                      foregroundColor: const Color(0xFF6D318D),
                      backgroundColor: const Color(0xFFE4CD9D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 3),
                  child: const Text(
                    'Back',
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
      ),
    );
  }

  Widget stepStyle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Times New Roman',
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget customGameModeStyle(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF9162A6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
