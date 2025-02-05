import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:rapid_rounds/config/enums/avatars.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/enums/player_state.dart';
import 'package:rapid_rounds/config/extensions/int_extensions.dart';
import 'package:rapid_rounds/config/utils/background_image.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/global_loading.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';
import 'package:rapid_rounds/config/utils/smooth_listview.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match_widget.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button_widget.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_sub_appbar.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_states.dart';

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

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocConsumer<RoomCubit, RoomStates>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RoomWaiting) {
            final players = state.roomDetailed.players;

            return _buildRoomWaiting(players);
          }

          if (state is RoomInGame) {
            return _buildMiniGame(
                state.roomDetailed.room, state.roomDetailed.games);
          }

          if (state is RoomBetweenRounds) {
            final players = state.roomDetailed.players;

            return _buildBetweenRounds(players, state);
          }

          if (state is RoomGameOver) {
            final players = state.roomDetailed.players;
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
            final players = state.roomDetailed.players;
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kOutterRadius),
                topRight: Radius.circular(kOutterRadius),
              ),
              child: BottomAppBar(
                color: GColors.gray,
                child: Center(
                  child: SmoothListView(
                    shrinkWrap: true,
                    itemCount: players.length,
                    arrowsHeight: 60,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => VerticalDivider(
                      color: GColors.black,
                      thickness: 0.2,
                      endIndent: 10,
                      indent: 10,
                    ),
                    itemBuilder: (context, index) => Column(
                      children: [
                        Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              AvatarIcon.values[players[index].avatar].icon,
                              color: GColors.black,
                            ),
                            Icon(
                              players[index].state == PlayerState.playing
                                  ? Custom.duration
                                  : Custom.progress_complete,
                              size: 15,
                              color: players[index].state == PlayerState.playing
                                  ? Colors.red
                                  : Colors.green,
                            )
                          ],
                        ),
                        Text(
                          players[index].name,
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: 15,
                            fontFamily: 'Barr',
                          ),
                        ),
                      ],
                    ),
                  ),
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
    return AppScaffold(
      appBar: MainMenuSubAppbar(
        text: 'Scores',
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kListViewWidth),
            child: ListView.builder(
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
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemBuilder: (context, jndex) {
                          return Text(
                            players[index].fails[jndex]
                                ? 'Failed'
                                : players[index]
                                    .finishTimes[jndex]
                                    .toReadableTime(),
                            style: TextStyle(
                              color: players[index].fails[jndex]
                                  ? Colors.red
                                  : players[index].finishTimes[jndex] ==
                                          state.minTime
                                      ? Colors.green
                                      : Colors.black,
                              fontWeight: players[index].fails[jndex]
                                  ? FontWeight.normal
                                  : players[index].finishTimes[jndex] ==
                                          state.minTime
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomWaiting(List<Player> players) {
    return Scaffold(
      appBar: MainMenuSubAppbar(
        text: 'Rapid Rounds',
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(8),
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: 400,
                height: 620,
                decoration: BoxDecoration(
                  color: GColors.gray,
                  borderRadius: BorderRadius.circular(kOutterRadius),
                ),
                child: Stack(
                  children: [
                    //* images
                    BackgroundImage(
                      bottom: -60,
                      right: -40,
                      width: 300,
                      height: 650,
                      imageUrl: 'https://i.ibb.co/dsdQG6ht/mon13.png',
                    ),
                    BackgroundImage(
                      bottom: 5,
                      left: -55,
                      width: 250,
                      height: 300,
                      imageUrl: 'https://i.ibb.co/Q7SbMRzX/mon14.png',
                    ),
                    //* room code text
                    Positioned(
                      right: 80,
                      top: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Room Code',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Barr',
                            ),
                          ),
                          Transform.rotate(
                            angle: 7,
                            child: Icon(
                              Custom.down,
                              color: GColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    //* room code button
                    Positioned(
                      right: 10,
                      top: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PopButton.text(
                            text: '#${widget.roomId}',
                            textSize: 30,
                            backgroundColor: GColors.springWood,
                            isSelectable: true,
                          ),
                          PopButton.icon(
                            onTapUp: () async {
                              await Clipboard.setData(
                                ClipboardData(
                                  text: widget.roomId,
                                ),
                              );

                              if (mounted) {
                                //todo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Copied to clipboard!')),
                                );
                              }
                            },
                            icon: Icons.copy_rounded,
                            iconSize: 43,
                            backgroundColor: GColors.springWood,
                          ),
                        ],
                      ),
                    ),
                    //* players text and list
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          const Text(
                            '• Players:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Barr',
                            ),
                          ),
                          AnimatedContainer(
                            width: 180,
                            duration: Duration(milliseconds: 300),
                            constraints: BoxConstraints(maxHeight: 450),
                            decoration: BoxDecoration(
                              color: GColors.springWood.withValues(alpha: 0.8),
                              borderRadius:
                                  BorderRadius.circular(kOutterRadius),
                            ),
                            child: SmoothListView(
                              itemCount: players.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) => Divider(
                                color: GColors.gray,
                                thickness: 1,
                              ),
                              arrowsWidth: 180,
                              itemBuilder: (context, index) {
                                final player = players[index];
                                return SizedBox(
                                  width: 100,
                                  child: ListTile(
                                    leading: Icon(
                                      AvatarIcon
                                          .values[players[index].avatar].icon,
                                      color: GColors.black,
                                      size: 24,
                                    ),
                                    title: Text(
                                      player.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Barr',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: isCreator
                                        ? Text(
                                            'Owner',
                                            style: TextStyle(
                                              color: GColors.black,
                                              fontSize: 15,
                                              fontFamily: 'Barr',
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //* start game
                    BlocBuilder<RoomCubit, RoomStates>(
                      builder: (context, state) {
                        //loading (when done will navigate out)
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: NeoPopTiltedButton(
                              isFloating: true,
                              onTapUp: () async {
                                if (!isCreator) {
                                  return;
                                }
                                if (state is RoomLoading) {
                                  return;
                                }

                                await roomCubit.startGame(widget.roomId);
                              },
                              decoration: NeoPopTiltedButtonDecoration(
                                color: GColors.sunGlow,
                                showShimmer: true,
                                shadowColor:
                                    GColors.black.withValues(alpha: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 80.0,
                                  vertical: 15,
                                ),
                                child: AnimatedContainer(
                                  width: state is RoomLoading ? 60 : 150,
                                  duration: Duration(milliseconds: 300),
                                  child: state is RoomLoading
                                      ? FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: GLoading(
                                            color: GColors.black,
                                          ),
                                        )
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                isCreator
                                                    ? 'Start Game'
                                                    : 'Waiting',
                                                style: TextStyle(
                                                  color: GColors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(
                                                isCreator
                                                    ? Custom.arrow_small_right
                                                    : Custom.duration_alt,
                                                color: GColors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
              return ReactionButtonWidget(reactionButton: reactionButton);
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

    return miniGames[currentRound - 1];
  }

  Widget _buildLeaderboard(List<Player> players) {
    final sortedPlayers = List.of(players)
      ..sort((a, b) => b.points.compareTo(a.points));

    return AppScaffold(
      appBar: MainMenuSubAppbar(
        text: 'Leaderboard',
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kListViewWidth),
            child: ListView(
              // shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: [
                const Text(
                  'Game Over! Leaderboard:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
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
                ElevatedButton(
                  onPressed: _leaveRoom,
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
