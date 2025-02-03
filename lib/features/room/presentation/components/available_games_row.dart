import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: GColors.springWood.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(
            Constants.outterRadius,
          ),
        ),
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
            NeoPopButton(
              onTapUp: onTapUp,
              color: GColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  gamesShown ? Custom.arrow_small_up : Custom.arrow_small_down,
                  color: GColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
