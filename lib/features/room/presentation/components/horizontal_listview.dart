import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class HorizontalListView extends StatefulWidget {
  final double itemSpacing;
  final int itemCount;
  final bool shrinkWrap;
  final double arrowsHeight;
  final Widget? Function(BuildContext, int) itemBuilder;

  const HorizontalListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.arrowsHeight,
    this.itemSpacing = 8.0,
    this.shrinkWrap = false,
  });

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final ScrollController scrollController = ScrollController();
  bool showRightArrow = true;
  bool showLeftArrow = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(checkScroll);
  }

  void checkScroll() {
    setState(() {
      showRightArrow =
          scrollController.offset < scrollController.position.maxScrollExtent;
      showLeftArrow =
          scrollController.offset > scrollController.position.minScrollExtent;
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(checkScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              scrollController.animateTo(
                scrollController.offset + pointerSignal.scrollDelta.dy,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          child: ScrollConfiguration(
            behavior: HorizontalScrollBehavior(),
            child: ListView.separated(
              shrinkWrap: widget.shrinkWrap,
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: widget.itemCount,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>
                  SizedBox(width: widget.itemSpacing),
              itemBuilder: widget.itemBuilder,
            ),
          ),
        ),
        if (showRightArrow)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                height: widget.arrowsHeight,
                decoration: BoxDecoration(
                  color: GColors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constants.outterRadius),
                    bottomLeft: Radius.circular(Constants.outterRadius),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (showLeftArrow)
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                height: widget.arrowsHeight,
                decoration: BoxDecoration(
                  color: GColors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Constants.outterRadius),
                    bottomRight: Radius.circular(Constants.outterRadius),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class HorizontalScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };

  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Disable the default glow effect
  }
}
