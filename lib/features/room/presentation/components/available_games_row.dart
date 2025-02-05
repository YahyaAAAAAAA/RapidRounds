import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

class AvailableGamesRow extends StatelessWidget {
  final void Function()? onTapUp;
  final bool gamesShown;

  const AvailableGamesRow({
    super.key,
    required this.gamesShown,
    required this.onTapUp,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              'Available Games',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontFamily: 'Barr',
              ),
            ),
            SizedBox(width: 10),
            PopButton.icon(
              onTapUp: onTapUp,
              padding: const EdgeInsets.all(4),
              icon:
                  gamesShown ? Custom.arrow_small_up : Custom.arrow_small_down,
            ),
          ],
        ),
      ),
    );
  }
}
