import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'room_page.dart';

class JoinRoomPage extends StatefulWidget {
  final String playerName;

  const JoinRoomPage({
    super.key,
    required this.playerName,
  });

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  late final RoomCubit roomCubit;
  final TextEditingController roomCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    roomCubit = context.read<RoomCubit>();
  }

  @override
  void dispose() {
    roomCodeController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: roomCodeController,
              decoration: const InputDecoration(
                labelText: 'Room Code',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final roomId = roomCodeController.text.trim();
                final success =
                    await roomCubit.joinRoom(roomId, widget.playerName);

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
