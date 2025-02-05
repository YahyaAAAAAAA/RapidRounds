import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;
  final Color? backgroundColor;
  final String backgroundImage;
  final double? opacity;
  final List<MeshGradientPoint>? points;
  final Widget? bottomSheet;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.backgroundImage = 'assets/images/bg.png',
    this.bottomNavigationBar,
    this.opacity,
    this.points,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      bottomSheet: bottomSheet,
      body: MeshGradient(
        options: MeshGradientOptions(
          noiseIntensity: 0,
        ),
        points: points ?? GColors.scaffoldMesh,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: opacity ?? 0.1,
                child: CachedNetworkImage(
                  imageUrl: 'https://i.ibb.co/tpnYSJcB/bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            body,
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor ?? GColors.springWood,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
