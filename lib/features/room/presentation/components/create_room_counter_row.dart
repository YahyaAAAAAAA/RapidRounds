import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

class CreateRoomCounterRow extends StatelessWidget {
  final String text;
  final int counter;

  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const CreateRoomCounterRow({
    super.key,
    required this.text,
    required this.counter,
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
              onTap: onIncrement,
              icon: Icons.add,
            ),
            PopButton.text(
              text: counter.toString(),
              fontWeight: FontWeight.bold,
            ),
            PopButton.icon(
              onTap: onDecrement,
              icon: Icons.remove,
            ),
          ],
        ),
      ),
    );
  }
}
