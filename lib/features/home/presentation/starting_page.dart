import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/home_page.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );

    // Initialize the slide animation
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start from the left (fully off-screen)
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // Add a smooth easing curve
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return AppScaffold(
      backgroundColor: GColors.sunGlow,
      opacity: 0.1,
      body: SafeArea(
        child: Stack(
          children: [
            // Slide-in image
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                      _animation.value.dx * screenWidth, _animation.value.dy),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: CachedNetworkImage(
                        imageUrl: 'https://i.ibb.co/DDFTPWtC/bg10.png',
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.centerRight,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FittedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Rapid Rounds',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Barr',
                        color: GColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(GColors.sunGlow),
                    backgroundColor: WidgetStatePropertyAll(GColors.black),
                    elevation: WidgetStatePropertyAll(12),
                    overlayColor: WidgetStatePropertyAll(
                      GColors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: GColors.white,
                    size: 30,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.all(12),
                    child: FittedBox(
                      child: Text(
                        'Start Playing',
                        style: TextStyle(
                          color: GColors.white,
                          fontSize: 30,
                        ),
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
