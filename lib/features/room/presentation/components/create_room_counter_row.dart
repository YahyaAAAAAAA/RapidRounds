import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/animated_counter_text.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

class CreateRoomCounterRow extends StatelessWidget {
  final String text;
  final int counter;
  final int oldCounter;

  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const CreateRoomCounterRow({
    super.key,
    required this.text,
    required this.counter,
    required this.oldCounter,
    this.onIncrement,
    this.onDecrement,
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
              text,
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontFamily: 'Barr',
              ),
            ),
            SizedBox(width: 10),
            PopButton.icon(
              onTapUp: onIncrement,
              icon: Icons.add,
            ),
            PopButton.child(
              backgroundColor: GColors.gray,
              padding: EdgeInsets.all(8),
              child: AnimatedCounterText(
                counter: counter,
                oldCounter: oldCounter,
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PopButton.icon(
              onTapUp: onDecrement,
              icon: Icons.remove,
            ),
          ],
        ),
      ),
    );
  }
}
