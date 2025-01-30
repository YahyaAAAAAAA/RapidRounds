import 'package:flutter/material.dart';

//used for ripple effect on containers
class BaseInkWell extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const BaseInkWell({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
