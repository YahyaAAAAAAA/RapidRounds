import 'package:flutter/material.dart';

Future<Object?> dialog({
  required BuildContext context,
  required Widget Function(BuildContext, Animation<double>, Animation<double>)
      pageBuilder,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: pageBuilder,
    barrierLabel: '',
    barrierDismissible: true,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: child,
      );
    },
  );
}
