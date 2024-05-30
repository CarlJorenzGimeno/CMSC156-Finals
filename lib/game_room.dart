import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/backend/firestore.dart';
import 'package:finals/backend/globals.dart';
import 'package:finals/backend/utils.dart';
import 'package:finals/select_character.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<int> tileList = randomizeTiles();
  final TextEditingController _message = TextEditingController();
  final ValueNotifier<int> willGuess = ValueNotifier(guess!);

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

  @override
  void initState() {
    super.initState();
    String check = (isHost) ? 'p1_chosen' : 'p2_chosen';
    db
        .collection('rooms')
        .doc(currentRoom)
        .snapshots()
        .listen((event) {
      var data = event.data();
      if (data == null) {
        leaveGame();
      }
      bool win = data?[check] == guess;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("$name guessed"),
                  Image(
                    image:
                        chars[guess] ?? const AssetImage('Anon.png'),
                  ),
                  FutureBuilder(
                      future: addWin(),
                      builder: (context, snapshot) {
                        return Text(win
                            ? "$name wins. ${roomInfo['p1_win']} - ${roomInfo['p2_win']}"
                            : "Wrong");
                      }),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            restartGame();
                          },
                          child: const Text('Continue')),
                      TextButton(
                          onPressed: leaveGame,
                          child: const Text('Leave')),
                    ],
                  )
                ],
              ),
            );
          });
    });
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
            ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("BGwithQ.png"),
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
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return CharTile(
                                    tileList: tileList, index: index);
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
                                    const AssetImage('Anon.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Game Chat Tab
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("BGwithQ.png"),
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
                            AsyncSnapshot<DocumentSnapshot>
                                snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          var data = snapshot.data?.data()
                              as Map<String, dynamic>;
                          return ListView(
                            children: data.entries.map((e) {
                              return ListTile(
                                title: Text(
                                    e.value[0] + ': ' + e.value[1]),
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
                        width: MediaQuery.sizeOf(context).width * 0.8,
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
                          controller: _message,
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
                            sendMessage(_message.text);
                            _message.clear();
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
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6D318D),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Select(
                                          guessing: true,
                                        )));
                          },
                          icon: const Icon(
                            Icons.send_rounded,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
                  image: AssetImage('Anon.png'), fit: BoxFit.cover),
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
                          const AssetImage('Anon.png'),
                      fit: BoxFit.cover),
                ),
              )),
        ],
      ),
    );
  }
}
