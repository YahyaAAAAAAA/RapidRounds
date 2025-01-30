import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/enums/player_state.dart';
import 'package:rapid_rounds/config/extensions/int_extensions.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match_widget.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button_widget.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_state.dart';

class RoomPage extends StatefulWidget {
  final String roomId;

  const RoomPage({super.key, required this.roomId});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final RoomCubit roomCubit;
  late bool isCreator = false;

  @override
  void initState() {
    super.initState();

    roomCubit = context.read<RoomCubit>();
    roomCubit.listenToRoom(widget.roomId);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isCreator = await roomCubit.isCreator(widget.roomId);
      setState(() {});
    });
  }

  Future<void> _leaveRoom() async {
    await roomCubit.leaveRoom(widget.roomId);
    pop();
  }

  void pop() {
    Navigator.of(context).pop();
  }

  void _startGame() {
    roomCubit.startGame(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _leaveRoom,
          ),
        ],
      ),
      body: BlocConsumer<RoomCubit, RoomStates>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RoomWaiting) {
            final players = state.roomWithPlayers.players;

            return _buildRoomWaiting(players);
          }

          if (state is RoomInGame) {
            return _buildMiniGame(
                state.roomWithPlayers.room, state.roomWithPlayers.games);
          }

          if (state is RoomBetweenRounds) {
            final players = state.roomWithPlayers.players;

            return _buildBetweenRounds(players, state);
          }

          if (state is RoomGameOver) {
            final players = state.roomWithPlayers.players;
            return _buildLeaderboard(players);
          }

          if (state is RoomError) {
            return Center(child: Text(state.message));
          }

          if (state is RoundDone) {
            return SizedBox();
          }

          return const Center(child: Text('Unexpected state'));
        },
        listener: (context, state) async {
          if (state is RoundDone) {
            await roomCubit.nextRound(widget.roomId);
          }
        },
      ),
      //display all room players state (finished or playing)
      bottomNavigationBar: BlocBuilder<RoomCubit, RoomStates>(
        builder: (context, state) {
          if (state is RoomInGame) {
            final players = state.roomWithPlayers.players;

            return BottomAppBar(
              child: ListView.separated(
                // shrinkWrap: true,
                itemCount: players.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) => Wrap(
                  children: [
                    Text(players[index].name),
                    const SizedBox(width: 5),
                    players[index].state == PlayerState.playing
                        ? const Icon(Icons.circle, color: Colors.red)
                        : const Icon(Icons.circle, color: Colors.green),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBetweenRounds(List<Player> players, RoomBetweenRounds state) {
    return ListView.builder(
      itemCount: players.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(8),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              players[index].name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            //todo change this to Wrap
            SizedBox(
              height: 50,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: players[index].finishTimes.length,
                scrollDirection: Axis.horizontal,
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemBuilder: (context, jndex) {
                  return Text(
                    players[index].fails[jndex]
                        ? 'Failed'
                        : players[index].finishTimes[jndex].toReadableTime(),
                    style: TextStyle(
                      color: players[index].fails[jndex]
                          ? Colors.red
                          : players[index].finishTimes[jndex] == state.minTime
                              ? Colors.green
                              : Colors.black,
                      fontWeight: players[index].fails[jndex]
                          ? FontWeight.normal
                          : players[index].finishTimes[jndex] == state.minTime
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRoomWaiting(List<Player> players) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectableText(
          'Room Code: ${widget.roomId}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Players:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return ListTile(
                title: Text(
                  player.name,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text('Score: ${player.points}'),
              );
            },
          ),
        ),
        if (isCreator)
          ElevatedButton(
            onPressed: _startGame,
            child: const Text('Start Game'),
          ),
      ],
    );
  }

  //todo comeback
  Widget _buildMiniGame(Room room, List<Game> games) {
    final miniGames = List<Widget>.generate(
      games.length,
      (i) {
        switch (games[i].type) {
          case 'ReactionButton':
            final reactionButton = games[i];
            if (reactionButton is ReactionButton) {
              return ReactionButtonWidget(
                reactionButton: reactionButton,
                roomCubit: roomCubit,
              );
            }
          case 'ColorMatch':
            final colorMatch = games[i];
            if (colorMatch is ColorMatch) {
              return ColorMatchWidget(colorMatch: colorMatch);
            }
          default:
            return Text('error');
        }

        return Text('error 2');
      },
    );

    final currentRound = room.currentRound;
    if (currentRound < 1 || currentRound > miniGames.length) {
      return const Center(
          child: Text('No mini-game available for this round.'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Round $currentRound / ${games.length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(child: miniGames[currentRound - 1]),
      ],
    );
  }

  Widget _buildLeaderboard(List<Player> players) {
    final sortedPlayers = List.of(players)
      ..sort((a, b) => b.points.compareTo(a.points));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Game Over! Leaderboard:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: sortedPlayers.length,
            itemBuilder: (context, index) {
              final player = sortedPlayers[index];
              return ListTile(
                leading: Text('#${index + 1}'),
                title: Text(player.name),
                // trailing: Text('${player.points} points'),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _leaveRoom,
          child: const Text('Exit'),
        ),
      ],
    );
  }
}
