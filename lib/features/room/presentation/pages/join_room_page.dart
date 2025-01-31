import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_appbar.dart';
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
      appBar: MainMenuAppbar(),
      body: SafeArea(
        child: Padding(
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
              NeoPopTiltedButton(
                // color: GColors.gray,
                onTapUp: () {},
                decoration: NeoPopTiltedButtonDecoration(
                  color: GColors.sunGlow,
                  showShimmer: true,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 15,
                  ),
                  child: Text('data'),
                ),
              ),
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
      ),
    );
  }
}
