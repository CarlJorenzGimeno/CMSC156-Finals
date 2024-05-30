import 'package:flutter/material.dart';

GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

String name = "";
String currentRoom = "";
Set<int>? board;
int? guessing;
bool isHost = false;
Map<String, dynamic>? roomInfo;
Map<int, ImageProvider> chars = {
  0: const AssetImage('images/Edward.png'),
  1: const AssetImage('images/Grace.png'),
  2: const AssetImage('images/Phillip.png'),
  3: const AssetImage('images/Julie.png'),
  4: const AssetImage('images/Anton.png'),
  5: const AssetImage('images/Joy.png'),
  6: const AssetImage('images/Kevin.png'),
  7: const AssetImage('images/Karla.png'),
  8: const AssetImage('images/Michael.png'),
  9: const AssetImage('images/Tina.png'),
  10: const AssetImage('images/Sean.png'),
  11: const AssetImage('images/Ashley.png'),
  12: const AssetImage('images/Neil.png'),
  13: const AssetImage('images/Ariel.png'),
  14: const AssetImage('images/Victor.png'),
  15: const AssetImage('images/Precious.png'),
  16: const AssetImage('images/Justin.png'),
  17: const AssetImage('images/Jade.png'),
  18: const AssetImage('images/Carl.png'),
  19: const AssetImage('images/Joseph.png'),
};
