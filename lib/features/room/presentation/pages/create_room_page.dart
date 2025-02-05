import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/background_image.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/global_loading.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_sub_appbar.dart';
import 'package:rapid_rounds/features/room/presentation/components/available_games_row.dart';
import 'package:rapid_rounds/features/room/presentation/components/create_room_counter_row.dart';
import 'package:rapid_rounds/features/room/presentation/components/game_list_item.dart';
import 'package:rapid_rounds/features/room/presentation/components/games_list.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_state.dart';
import 'room_page.dart';

class CreateRoomPage extends StatefulWidget {
  final String playerName;
  final int playerAvatar;

  const CreateRoomPage({
    super.key,
    required this.playerName,
    required this.playerAvatar,
  });

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late final RoomCubit roomCubit;

  final int maxRoundsCount = 30;
  final int minRoundsCount = 1;
  final int maxPlayersCount = 10;
  final int minPlayersCount = 1;
  int roundsCount = 5;
  int oldRoundsCount = 5;
  int playersCount = 3;
  int oldPlayersCount = 3;

  bool gamesShown = false;
  //todo comeback
  final List<Game> games = [
    ReactionButton(
      id: '0',
      type: 'ReactionButton',
      roomId: '0',
      enabled: true,
      description: 'Press the button when it turns green.',
      icon: Custom.reactionbutton,
    ),
    ColorMatch(
      id: '0',
      type: 'ColorMatch',
      roomId: '0',
      pattern: 0,
      enabled: true,
      description: 'Remember the board, after 3-seconds replicate it.',
      icon: Custom.colormatch,
    ),
  ];

  @override
  void initState() {
    super.initState();

    //get cubit
    roomCubit = context.read<RoomCubit>();
  }

  Future<void> createRoom() async {
    //create room
    final roomId = await roomCubit.createRoom(
      playerName: widget.playerName,
      playerAvatar: widget.playerAvatar,
      roundsCount: roundsCount,
      playersCount: playersCount,
    );

    //ensure mounted
    if (!mounted) return;

    //navigate to room
    context.replace(RoomPage(roomId: roomId));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: MainMenuSubAppbar(text: 'Create Room'),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: kListViewWidth,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      width: 400,
                      height: 580,
                      decoration: BoxDecoration(
                        color: GColors.gray,
                        borderRadius: BorderRadius.circular(kOutterRadius),
                      ),
                      child: Stack(
                        children: [
                          //* images
                          BackgroundImage(
                            left: 80,
                            bottom: 10,
                            width: 400,
                            height: 500,
                            imageUrl: 'https://i.ibb.co/mCd0rWrr/mon9.png',
                          ),
                          BackgroundImage(
                            right: 30,
                            top: -30,
                            angle: 10,
                            width: 100,
                            height: 100,
                            imageUrl: 'https://i.ibb.co/ynpK52vD/mon11.png',
                          ),
                          BackgroundImage(
                            left: -40,
                            bottom: 50,
                            angle: 26,
                            width: 150,
                            height: 150,
                            imageUrl: 'https://i.ibb.co/whPQYRQC/mon10.png',
                          ),

                          //* fields
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20,
                              children: [
                                Text(
                                  '• Create Room',
                                  style: TextStyle(
                                    color: GColors.black,
                                    fontSize: 20,
                                    fontFamily: 'Barr',
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: GColors.springWood
                                          .withValues(alpha: 0.8),
                                      borderRadius:
                                          BorderRadius.circular(kOutterRadius),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        CreateRoomCounterRow(
                                          text: 'Rounds Count',
                                          counter: roundsCount,
                                          oldCounter: oldRoundsCount,
                                          onIncrement: () {
                                            if (roundsCount >= maxRoundsCount) {
                                              return;
                                            }

                                            oldRoundsCount = roundsCount;
                                            setState(() => roundsCount++);
                                          },
                                          onDecrement: () {
                                            if (roundsCount <= minRoundsCount) {
                                              return;
                                            }

                                            oldRoundsCount = roundsCount;
                                            setState(() => roundsCount--);
                                          },
                                        ),
                                        CreateRoomCounterRow(
                                          text: 'Players Count',
                                          counter: playersCount,
                                          oldCounter: oldPlayersCount,
                                          onIncrement: () {
                                            if (playersCount >=
                                                maxPlayersCount) {
                                              return;
                                            }
                                            oldPlayersCount = playersCount;
                                            setState(() => playersCount++);
                                          },
                                          onDecrement: () {
                                            if (playersCount <=
                                                minPlayersCount) {
                                              return;
                                            }

                                            oldPlayersCount = playersCount;
                                            setState(() => playersCount--);
                                          },
                                        ),
                                        AvailableGamesRow(
                                          onTapUp: () => setState(
                                            () => gamesShown = !gamesShown,
                                          ),
                                          gamesShown: gamesShown,
                                        ),
                                        GamesList(
                                          gamesShown: gamesShown,
                                          games: games,
                                          itemBuilder: (context, index) {
                                            return GameListItem(
                                              game: games[index],
                                              onChanged: (value) => setState(
                                                () => games[index].enabled =
                                                    !games[index].enabled!,
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
                          //* create room button
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
                                      if (state is RoomLoading) {
                                        return;
                                      }

                                      await createRoom();
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Create Room',
                                                      style: TextStyle(
                                                        color: GColors.black,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Icon(
                                                      Custom.arrow_small_right,
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
          ),
        ));
  }
}
