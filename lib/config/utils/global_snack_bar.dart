import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

//global snackbar, shows error message
class GSnackBar {
  static get toastification => null;
  static show({
    required BuildContext context,
    required String text,
    Duration? duration,
    Color? color,
    Color? textColor,
    Gradient? gradient,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        elevation: 0,
        content: Center(
          //note: wrap to limit snackbar width
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: color ?? GColors.sunGlow,
                    gradient: gradient ?? GColors.logoGradient,
                    boxShadow: [
                      BoxShadow(
                        color: color != null
                            ? color.withValues(alpha: 0.2)
                            : GColors.sunGlow.withValues(alpha: 0.2),
                        blurRadius: 7,
                        offset: const Offset(4, 4),
                      )
                    ]),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.notifications_active_rounded,
                      color: GColors.white,
                      size: 30,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor ?? GColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
