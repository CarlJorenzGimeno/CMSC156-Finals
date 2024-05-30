import 'package:finals/backend/globals.dart';
import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/BGwithQ.png"),
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
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.purple,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: chars[index] ??
                                  const AssetImage('images/Anon.png'),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    foregroundColor: const Color(0xFF6D318D),
                    backgroundColor: const Color(0xFFE4CD9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 3),
                child: const Text(
                  'Select',
                  style: TextStyle(
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
