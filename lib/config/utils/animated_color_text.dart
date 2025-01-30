import 'package:flutter/material.dart';

class AnimatedColorText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final List<Color> colors;

  const AnimatedColorText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(seconds: 2),
    this.colors = const [Colors.red, Colors.blue, Colors.green],
  });

  @override
  State<AnimatedColorText> createState() => _AnimatedColorTextState();
}

class _AnimatedColorTextState extends State<AnimatedColorText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Color> colors = List.empty();

  @override
  void initState() {
    super.initState();

    //initialize the animation controller
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    //create a Tween for the gradient position
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: widget.colors,
          stops: [
            _animation.value - 0.5,
            _animation.value,
            _animation.value + 0.5,
          ],
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        widget.text,
        style: widget.style ??
            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
