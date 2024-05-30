import 'dart:math';

import 'package:finals/backend/globals.dart';
import 'package:flutter/material.dart';

Random random = Random();

String getRandomString() {
  const characters =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      6,
      (_) =>
          characters.codeUnitAt(random.nextInt(characters.length))));
}

void showSnackBar(String text) {
  rootScaffoldMessengerKey.currentState
      ?.showSnackBar(SnackBar(content: Text(text)));
}
