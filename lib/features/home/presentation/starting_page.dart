import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
import 'package:rapid_rounds/config/utils/animated_color_icon.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/home_page.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: GColors.sunGlow,
      opacity: 0.1,
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: 'https://i.ibb.co/DDFTPWtC/bg10.png',
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.centerRight,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: NeoPopButton(
                    // padding: EdgeInsets.all(20),
                    onTapUp: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                    color: GColors.gray,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AnimatedColorIcon(
                        icon: Custom.mon_5,
                        colors: [
                          GColors.black,
                          Colors.grey.shade800,
                          Colors.grey.shade900,
                          GColors.black,
                        ],
                        colorDuration: Duration(seconds: 3),
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
