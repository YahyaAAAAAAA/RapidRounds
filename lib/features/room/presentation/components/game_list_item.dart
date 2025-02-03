import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/games/game.dart';

class GameListItem extends StatelessWidget {
  final Game game;
  final void Function(bool value)? onChanged;

  const GameListItem({
    super.key,
    required this.game,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: GColors.gray,
          borderRadius: BorderRadius.circular(
            Constants.innerRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //todo display description
                  Icon(
                    Icons.info_outline_rounded,
                    color: GColors.black,
                    size: 15,
                  ),
                ],
              ),
              Icon(
                game.icon,
                color: GColors.black,
              ),
              Text(
                game.type,
                style: TextStyle(
                  color: GColors.black,
                  fontFamily: 'Barr',
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  trackColor: WidgetStatePropertyAll(
                    GColors.black,
                  ),
                  activeColor: GColors.white,
                  inactiveThumbColor: GColors.gray,
                  value: game.enabled ?? true,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
