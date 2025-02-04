import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_loading.dart';

class BackgroundImage extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double? width;
  final double? height;
  final double? angle;
  final String imageUrl;

  const BackgroundImage({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    this.angle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: angle ?? 0,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, progress) => GLoading(
            value: progress.progress,
          ),
          errorWidget: (context, url, error) => SizedBox(),
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
