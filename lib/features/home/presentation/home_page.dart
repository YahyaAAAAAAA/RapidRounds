import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match_widget.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/features/room/presentation/pages/create_room_page.dart';
import 'package:rapid_rounds/features/room/presentation/pages/join_room_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<RoomCubit>(),
                      child: const CreateRoomPage(),
                    ),
                  ),
                );
              },
              child: const Text('Create Room'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JoinRoomPage(),
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
