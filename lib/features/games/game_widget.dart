import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/features/room/presentation/components/game_appbar.dart';

class GameWidget extends StatelessWidget {
  final List<Widget> children;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final double? maxWidth;
  final int? solveTime;
  final String title;

  const GameWidget({
    super.key,
    required this.title,
    required this.children,
    this.shrinkWrap = true,
    this.physics = const BouncingScrollPhysics(),
    this.padding = const EdgeInsets.all(8),
    this.maxWidth = kListViewWidth,
    this.solveTime,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: GameAppbar(
        text: title,
        solveTime: solveTime!,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth!,
            ),
            child: ListView(
              physics: physics,
              shrinkWrap: shrinkWrap!,
              padding: padding,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
