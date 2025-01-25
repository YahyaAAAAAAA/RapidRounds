import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'room_page.dart';

class CreateRoomPage extends StatefulWidget {
  final String playerName;

  const CreateRoomPage({
    super.key,
    required this.playerName,
  });

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late final RoomCubit roomCubit;

  @override
  void initState() {
    super.initState();

    //get cubit
    roomCubit = context.read<RoomCubit>();

    createRoom();
  }

  Future<void> createRoom() async {
    //create room
    final roomId = await roomCubit.createRoom(widget.playerName);

    //ensure mounted
    if (!mounted) return;

    //navigate to room
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RoomPage(roomId: roomId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
