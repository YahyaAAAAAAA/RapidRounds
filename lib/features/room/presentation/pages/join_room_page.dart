import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'room_page.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final TextEditingController _roomCodeController = TextEditingController();

  @override
  void dispose() {
    _roomCodeController.dispose();
    super.dispose();
  }

  void navigateToRoom(String roomId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RoomPage(roomId: roomId),
      ),
    );
  }

  void showErrorMessage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Invalid Room Code!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  int time = DateTime.now().second;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                time = DateTime.now().second;
              });
            },
            child: Text(
              time.toString(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomCodeController,
              decoration: const InputDecoration(
                labelText: 'Room Code',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final roomId = _roomCodeController.text.trim();
                final success =
                    await context.read<RoomCubit>().joinRoom(roomId);

                if (!mounted) return;

                if (success) {
                  navigateToRoom(roomId);
                } else {
                  showErrorMessage();
                }
              },
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
