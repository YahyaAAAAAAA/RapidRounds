import 'package:flutter/material.dart';

class AnimatedColorIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final Duration colorDuration;
  final Duration rotationDuration;
  final double rotationAngle;
  final List<Color> colors;

  const AnimatedColorIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.colorDuration = const Duration(seconds: 2),
    this.rotationDuration = const Duration(seconds: 1),
    this.rotationAngle = 10.0,
    this.colors = const [Colors.red, Colors.blue, Colors.green],
  });

  @override
  State<AnimatedColorIcon> createState() => _AnimatedColorIconState();
}

class _AnimatedColorIconState extends State<AnimatedColorIcon>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    //initialize the color animation controller
    _colorController = AnimationController(
      duration: widget.colorDuration,
      vsync: this,
    )..repeat();

    //create a TweenSequence for smooth color transitions
    final colorTweens = <TweenSequenceItem<Color?>>[];
    for (int i = 0; i < widget.colors.length; i++) {
      colorTweens.add(
        TweenSequenceItem<Color?>(
          tween: ColorTween(
            begin: widget.colors[i],
            end: widget.colors[(i + 1) % widget.colors.length],
          ),
          weight: 1.0,
        ),
      );
    }

    _colorAnimation =
        TweenSequence<Color?>(colorTweens).animate(_colorController);

    //initialize the rotation animation controller
    _rotationController = AnimationController(
      duration: widget.rotationDuration,
      vsync: this,
    )..repeat(reverse: true);

    //create a rotation animation (from -angle to +angle degrees)
    _rotationAnimation = Tween<double>(
      begin:
          //convert degrees to radians
          -widget.rotationAngle * (3.14159 / 180),
      end: widget.rotationAngle * (3.14159 / 180),
    ).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _colorController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_colorController, _rotationController]),
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Icon(
            widget.icon,
            size: widget.size,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
