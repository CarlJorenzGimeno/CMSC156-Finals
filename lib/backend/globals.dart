import 'package:flutter/material.dart';

GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

String name = "";
String currentRoom = "";
Set<int>? board;
int? guessing;
bool isHost = false;
bool start = false;
List<int?> guess = [null, null];
bool alert = false;

Map<String, dynamic> roomInfo = {
  "id": null, // Room Code
  "host": null, // Host User
  "other": null, // Other User
  "p1_name": name, // Host Name
  "p2_name": null, // Other Name
  "p1_guessed": null,
  "p2_guessed": null,
  "p1_chosen": null, // P1 chosen
  "p2_chosen": null, // P2 chosen
  "p1_win": 0,
  "p2_win": 0,
  "p1_guessCheck": false,
  "p2_guessCheck": false,
};

Map<int, ImageProvider> chars = {
  0: const AssetImage('assets/images/Edward.png'),
  1: const AssetImage('assets/images/Grace.png'),
  2: const AssetImage('assets/images/Phillip.png'),
  3: const AssetImage('assets/images/Julie.png'),
  4: const AssetImage('assets/images/Anton.png'),
  5: const AssetImage('assets/images/Joy.png'),
  6: const AssetImage('assets/images/Kevin.png'),
  7: const AssetImage('assets/images/Karla.png'),
  8: const AssetImage('assets/images/Michael.png'),
  9: const AssetImage('assets/images/Tina.png'),
  10: const AssetImage('assets/images/Sean.png'),
  11: const AssetImage('assets/images/Ashley.png'),
  12: const AssetImage('assets/images/Neil.png'),
  13: const AssetImage('assets/images/Ariel.png'),
  14: const AssetImage('assets/images/Victor.png'),
  15: const AssetImage('assets/images/Precious.png'),
  16: const AssetImage('assets/images/Justin.png'),
  17: const AssetImage('assets/images/Jade.png'),
  18: const AssetImage('assets/images/Carl.png'),
  19: const AssetImage('assets/images/Joseph.png'),
};
