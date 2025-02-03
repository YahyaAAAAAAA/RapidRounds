import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/room/presentation/components/horizontal_listview.dart';

class GamesList extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool gamesShown;
  final List<Game> games;
  final Widget? Function(BuildContext, int) itemBuilder;

  const GamesList({
    super.key,
    required this.gamesShown,
    required this.games,
    required this.itemBuilder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: gamesShown ? 140 : 0,
      width: 250,
      decoration: BoxDecoration(
        color: GColors.springWood.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(
          Constants.outterRadius,
        ),
      ),
      padding: EdgeInsets.all(12),
      child: HorizontalListView(
        itemCount: games.length,
        arrowsHeight: 110,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
