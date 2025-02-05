import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class WaitText extends StatelessWidget {
  const WaitText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 720,
        decoration: BoxDecoration(
          color: GColors.transparent,
          borderRadius: BorderRadius.circular(kOutterRadius),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: GColors.gray.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(kOutterRadius),
            ),
            child: Text(
              'You Answerd \n Please Wait',
              style: TextStyle(
                fontFamily: 'Barr',
                fontSize: 40,
                color: GColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
