import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/backend/firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/backend/utils.dart';
import 'package:finals/select_character.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var gameRoom = db.collection('rooms').doc(currentRoom);

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<int> tileList = randomizeTiles();
  final TextEditingController _message = TextEditingController();

  void restartGame() {
    Navigator.of(context).pop();
  }

  void leaveGame() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text("Leaving Match"),
            ],
          ));
        });
    await exitRoom();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // void checkWin() async {
  //   await updateRoom();
  //   // debugPrint(roomInfo.toString());
  //   bool isWin = await scoring();
  //   // debugPrint(roomInfo.toString());
  //   // debugPrint(isWin.toString());
  //   bool guessCheck1 = roomInfo['p1_guessCheck'] ?? false;
  //   bool guessCheck2 = roomInfo['p2_guessCheck'] ?? false;
  //   if ((guessCheck1 || guessCheck2) && context.mounted) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text("$name guessed"),
  //                 Image(
  //                   image: chars[guessing] ??
  //                       const AssetImage('Anon.png'),
  //                 ),
  //                 Text(isWin
  //                     ? "$name wins. ${roomInfo['p1_win']} - ${roomInfo['p2_win']}"
  //                     : "Wrong"),
  //                 Visibility(
  //                     visible: isWin,
  //                     child: Row(
  //                       children: [
  //                         TextButton(
  //                             onPressed: () {
  //                               restartGame();
  //                             },
  //                             child: const Text('Continue')),
  //                         TextButton(
  //                             onPressed: leaveGame,
  //                             child: const Text('Leave')),
  //                       ],
  //                     ))
  //               ],
  //             ),
  //           );
  //         });
  //     await addWin();
  //     db.collection('rooms').doc(currentRoom).update({
  //       'p1_guessCheck': false,
  //       'p2_guessCheck': false,
  //     });
  //   }
  // }

  void showGuess(int win) {
    String guess = 'p2_guessed';

    if (win == 1) {
      guess = 'p1_guessed';
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$name guessed'),
                Image(
                    image: chars[roomInfo[guess]] ??
                        const AssetImage('assets/images/Anon.png')),
                Text((win == 0) ? "Wrong" : "Correct"),
                Visibility(
                    visible: !(win == 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              restartGame();
                            },
                            child: const Text('New Game')),
                        TextButton(
                            onPressed: () {
                              leaveGame();
                            },
                            child: const Text('Leave Room')),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  Future<void> clearCheck() async {
    await gameRoom
        .update({'p2_guessCheck': false, 'p1_guessCheck': false});
    await updateRoom();
  }

  Future<void> addWin(int win) async {
    if (win == 0) {
    } else {
      var data = roomInfo[(win == 1) ? 'p1_win' : 'p2_win'] + 1;
      await gameRoom.update({
        (win == 1) ? 'p1_win' : 'p2_win': data,
      });
      await updateRoom();
    }
  }

  @override
  void initState() {
    super.initState();
    gameRoom.snapshots().listen((event) {
      try {
        var data = event.data();
        if (data == null) {
          leaveGame();
        }
        int win = 0;
        bool check =
            (data?['p1_guessCheck'] == roomInfo['p1_guessCheck']) ||
                (data?['p2_guessCheck'] == roomInfo['p2_guessCheck']);
        roomInfo = data ?? roomInfo;
        if (roomInfo['p1_guessCheck']) {
          if (roomInfo['p1_guessed'] == roomInfo['p2_chosen']) {
            win = 1;
          }
        } else if (roomInfo['p2_guessCheck']) {
          if (roomInfo['p2_guessed'] == roomInfo['p1_chosen']) {
            win = 2;
          }
        }

        debugPrint(alert.toString() + check.toString());
        if (alert) {
          alert = false;
          showGuess(win);
          addWin(win).whenComplete(() => alert = true);
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      clearCheck().whenComplete(() {
        debugPrint(roomInfo.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //Back Button
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Leave Match"),
                          content: const Text(
                              "Are you sure you want to leave the match?"),
                          actions: [
                            TextButton(
                              onPressed: leaveGame,
                              child: const Text("Yes"),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No"))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 25,
                ))
          ],
          toolbarHeight: 60,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6D318D),
          title: Container(
            margin: const EdgeInsets.only(left: 80),
            height: 110,
            width: 110,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Logo_Final_White.png')),
            ),
          ),
          bottom: const TabBar(
            unselectedLabelColor: Colors.white60,
            labelColor: Color(0xFFE4CD9D),
            indicatorColor: Color(0xFFE4CD9D),
            indicatorWeight: 2,
            labelStyle: TextStyle(
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            tabs: [
              Tab(text: 'Character Deck'),
              Tab(text: 'Game Chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Character Deck Tab
            CharacterDeck(tileList: tileList),

            //Game Chat Tab
            GameChat(message: _message)
          ],
        ),
      ),
    );
  }
}

class GameChat extends StatefulWidget {
  const GameChat({
    super.key,
    required TextEditingController message,
  }) : _message = message;

  final TextEditingController _message;

  @override
  State<GameChat> createState() => _GameChatState();
}

class _GameChatState extends State<GameChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("bgwithQ.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: 450,
            width: 380,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE4CD9D),
                  width: 5,
                )),
            child: StreamBuilder<DocumentSnapshot>(
                stream: db
                    .collection('chat')
                    .doc(currentRoom)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  var data =
                      snapshot.data?.data() as Map<String, dynamic>;
                  return ListView(
                    children: data.entries.map((e) {
                      return ListTile(
                        title: Text(e.value[0] + ': ' + e.value[1]),
                      );
                    }).toList(),
                  );
                }),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.7,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 40,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: widget._message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF6D318D),
                        style: BorderStyle.solid,
                        width: 10,
                      ),
                    ),
                    hintText: 'Type a message',
                    labelStyle: const TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color(0xFF6D318D),
                      fontSize: 25,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF6D318D),
                ),
                child: IconButton(
                  onPressed: () {
                    sendMessage(widget._message.text);
                    widget._message.clear();
                  },
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 50,
                width: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF6D318D),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Select(
                              guessing: true,
                            )));
                  },
                  child: const Text(
                    'Guess',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CharacterDeck extends StatefulWidget {
  const CharacterDeck({
    super.key,
    required this.tileList,
  });

  final List<int> tileList;

  @override
  State<CharacterDeck> createState() => _CharacterStateDeck();
}

class _CharacterStateDeck extends State<CharacterDeck>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgwithQ.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 500,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      primary: false,
                      itemCount: chars.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return CharTile(
                            tileList: widget.tileList, index: index);
                      },
                    ),
                  ),
                ),

                //Character to be Guessed
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: chars[guessing] ??
                            const AssetImage('assets/images/Anon.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CharTile extends StatefulWidget {
  const CharTile({
    super.key,
    required this.tileList,
    required this.index,
  });

  final List<int> tileList;
  final int index;

  @override
  State<CharTile> createState() => _CharTileState();
}

class _CharTileState extends State<CharTile> {
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hide = !hide;
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.purple,
              ),
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  image: AssetImage("images/Anon.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Visibility(
              visible: !hide,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.purple,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: chars[widget.tileList[widget.index]] ??
                          const AssetImage("images/Anon.png"),
                      fit: BoxFit.cover),
                ),
              )),
        ],
      ),
    );
  }
}
