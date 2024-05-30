import 'package:flutter/material.dart';

GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

String name = "";
String currentRoom = "";
Set<int>? board;
int? guessing;
bool isHost = false;
bool start = false;
int? guess;

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
};

Map<int, ImageProvider> chars = {
  0: const AssetImage('Edward.png'),
  1: const AssetImage('Grace.png'),
  2: const AssetImage('Phillip.png'),
  3: const AssetImage('Julie.png'),
  4: const AssetImage('Anton.png'),
  5: const AssetImage('Joy.png'),
  6: const AssetImage('Kevin.png'),
  7: const AssetImage('Karla.png'),
  8: const AssetImage('Michael.png'),
  9: const AssetImage('Tina.png'),
  10: const AssetImage('Sean.png'),
  11: const AssetImage('Ashley.png'),
  12: const AssetImage('Neil.png'),
  13: const AssetImage('Ariel.png'),
  14: const AssetImage('Victor.png'),
  15: const AssetImage('Precious.png'),
  16: const AssetImage('Justin.png'),
  17: const AssetImage('Jade.png'),
  18: const AssetImage('Carl.png'),
  19: const AssetImage('Joseph.png'),
};
