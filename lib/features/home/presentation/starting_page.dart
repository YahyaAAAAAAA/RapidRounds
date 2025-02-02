import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
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
      points: GColors.scaffoldMeshSun,
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
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: NeoPopTiltedButton(
                    isFloating: true,
                    onTapUp: () => context.replace(HomePage()),
                    decoration: NeoPopTiltedButtonDecoration(
                      color: GColors.gray,
                      showShimmer: true,
                      shadowColor: GColors.black.withValues(alpha: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Custom.mon_5,
                            color: GColors.black,
                            size: 80,
                          ),
                        ],
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
