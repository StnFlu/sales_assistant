import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final bool isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
    this.width,
    this.height = 48.0,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 4.0,
                ),
              ),
            Opacity(
              opacity: isLoading ? 0.0 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingIcon != null)
                    Icon(
                      leadingIcon,
                      color: textColor ?? Colors.white,
                      size: 20,
                    ),
                  if (leadingIcon != null) const SizedBox(width: 8), // Spacing
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (trailingIcon != null) const SizedBox(width: 8), // Spacing
                  if (trailingIcon != null)
                    Icon(
                      trailingIcon,
                      color: textColor ?? Colors.white,
                      size: 20,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateContentWidth() {
    final textLength = text.length;
    double baseWidth = textLength * 8.0; // Approximation: ~8px per character
    if (leadingIcon != null) baseWidth += 28; // Space for leading icon
    if (trailingIcon != null) baseWidth += 28; // Space for trailing icon
    return baseWidth;
  }
}
