import 'package:flutter/material.dart';

class AnimatedCounterText extends StatelessWidget {
  final int counter;
  final int oldCounter;
  final TextStyle? style;

  const AnimatedCounterText({
    super.key,
    required this.counter,
    required this.oldCounter,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        Offset begin;
        if (counter > oldCounter) {
          begin = Offset(-2.5, 0);
        } else {
          begin = Offset(2.5, 0);
        }
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: Text(
        '$counter',
        key: ValueKey<int>(counter),
        style: style,
      ),
    );
  }
}
