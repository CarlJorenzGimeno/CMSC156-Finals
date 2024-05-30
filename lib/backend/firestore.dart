import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/backend/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../select_character.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth authInstance = FirebaseAuth.instance;

Future<bool> checkIfDocExists(String docId) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = db.collection('rooms');
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}

Future<void> createRoom() async {
  String roomCode = "";
  bool doRoomExist = true;
  // Create room code
  while (doRoomExist) {
    roomCode = getRandomString();
    doRoomExist = await checkIfDocExists(roomCode);
  }

  // Create room document
  Map<String, dynamic> roomDoc = {
    "id": roomCode, // Room Code
    "host": authInstance.currentUser, // Host User
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

  // Upload document to firestore
  await db.collection("rooms").doc(roomCode).set(roomDoc).onError(
      (error, stackTrace) =>
          showSnackBar("Error creating room. Please try again."));

  await db
      .collection("chat")
      .doc(roomCode)
      .set({}).onError((error, stackTrace) {
    showSnackBar("Error creating room. Please try again.");
  });

  currentRoom = roomCode;
  isHost = true;
}

Future<void> joinRoom(String roomCode, BuildContext context) async {
  // Check if document exist
  bool isRoomExists;

  isRoomExists = await checkIfDocExists(roomCode);

  // Check if room code is already used
  if (isRoomExists) {
    final docRef = db.collection('rooms').doc(roomCode);
    if (await docRef.get().then((value) {
      return value.data()?['p2_name'] != null;
    })) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Matching Failed"),
              content: Text("Game is already in session"),
            );
          });
      return;
    }
    final Map<String, dynamic> data = {
      'other': authInstance.currentUser,
      'p2_name': name,
    };
    docRef.update(data);
    roomInfo = (await docRef.get()).data() ?? roomInfo;
    debugPrint(roomInfo.toString());
    currentRoom = roomCode;
    if (context.mounted) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Select()));
    }
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Matching Failed"),
            content: Text("Room does not exist"),
          );
        });
    return;
  }
}

Future<void> exitRoom() async {
  if (isHost) {
    await db.collection('rooms').doc(currentRoom).delete();
  } else {
    final data = {
      "other": null,
      "p2_name": null,
    };
    await db.collection('rooms').doc(currentRoom).update(data);
  }
  currentRoom = "";
}

Future<void> addWin() async {
  String player = 'p2_win';
  int win = roomInfo['p2_win'];

  if (isHost) {
    player = 'p1_win';
    win = roomInfo['p1_win'];
  }

  win++;

  db.collection('rooms').doc(currentRoom).update({player: win});
  await updateRoom();
}

Future<void> updateRoom() async {
  roomInfo =
      (await db.collection('rooms').doc(currentRoom).get()).data() ??
          roomInfo;
}

Future<void> startGame() async {
  board =
      Set.from(List<int>.generate(24, (index) => index)..shuffle());
  guessing = random.nextInt(24);
  Map<String, dynamic> data;

  // Assign guessing to player
  if (isHost) {
    data = {
      "p1_chosen": guessing,
    };
  } else {
    data = {
      "p2_chosen": guessing,
    };
  }

  await db
      .collection('rooms')
      .doc(currentRoom)
      .set(data, SetOptions(merge: true));
}

void sendMessage(String message) {
  var chat = db.collection('chat').doc(currentRoom);
  Map<String, dynamic> messagePacket = {
    DateTime.now().toIso8601String(): [name, message],
  };
  chat.set(messagePacket, SetOptions(merge: true));
}
