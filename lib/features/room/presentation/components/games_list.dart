import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/config/utils/smooth_listview.dart';

class GamesList extends StatelessWidget {
  final bool gamesShown;
  final List<Game> games;
  final Widget Function(BuildContext, int) itemBuilder;

  const GamesList({
    super.key,
    required this.gamesShown,
    required this.games,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: gamesShown ? 140 : 0,
      width: 250,
      decoration: BoxDecoration(
        color: GColors.transparent,
        borderRadius: BorderRadius.circular(
          kOutterRadius,
        ),
      ),
      padding: EdgeInsets.all(12),
      child: SmoothListView(
        arrowsHeight: 120,
        itemCount: games.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: itemBuilder,
        separatorBuilder: (context, index) => SizedBox(width: 8),
      ),
    );
  }
}
