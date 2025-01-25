import 'package:flutter/material.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match_widget.dart';
import 'package:rapid_rounds/features/room/presentation/pages/create_room_page.dart';
import 'package:rapid_rounds/features/room/presentation/pages/join_room_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty) {
                  //todo add snack bar or validate ?
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateRoomPage(
                      playerName: nameController.text,
                    ),
                  ),
                );
              },
              child: const Text('Create Room'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty) {
                  //todo add snack bar or validate ?
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JoinRoomPage(
                      playerName: nameController.text,
                    ),
                  ),
                );
              },
              child: const Text('Join Room'),
            ),
            //todo testing
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ColorMatchWidget(),
                  ),
                );
              },
              child: const Text('Test Room'),
            ),
          ],
        ),
      ),
    );
  }
}
