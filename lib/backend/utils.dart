import 'dart:math';

import 'package:finals/backend/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Random random = Random();

String getRandomString() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      6,
      (_) =>
          characters.codeUnitAt(random.nextInt(characters.length))));
}

List<int> randomizeTiles() {
  List<int> tileList = List.generate(20, (index) => index);
  tileList.shuffle();
  return tileList;
}

void showSnackBar(String text) {
  rootScaffoldMessengerKey.currentState
      ?.showSnackBar(SnackBar(content: Text(text)));
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
