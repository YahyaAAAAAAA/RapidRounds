import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: GColors.springWood.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(
            Constants.outterRadius,
          ),
        ),
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
            NeoPopButton(
              onTapUp: onIncrement,
              color: GColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  color: GColors.black,
                ),
              ),
            ),
            NeoPopButton(
              disabledColor: GColors.gray,
              color: GColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  counter.toString(),
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            NeoPopButton(
              onTapUp: onDecrement,
              color: GColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.remove,
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
