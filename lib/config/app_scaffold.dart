import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:rapid_rounds/config/global_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Color? backgroundColor;
  final String backgroundImage;
  final double? opacity;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.backgroundImage = 'assets/images/bg.png',
    this.bottomNavigationBar,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      body: MeshGradient(
        options: MeshGradientOptions(),
        points: GColors.scaffoldMesh,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? GColors.transparent,
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
              opacity: opacity ?? 0.2,
            ),
          ),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
