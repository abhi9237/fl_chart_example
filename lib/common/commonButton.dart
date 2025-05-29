import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_constant.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double? width;
  final double? buttonHeight;
  final TextStyle? textStyle;
  // final EdgeInsetsGeometry padding;

  const CommonButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = Colors.blue, // Default background color
      this.textColor, // Default text color
      this.borderRadius = 8.0, // Default border radius
      this.width,
      this.buttonHeight,
      this.textStyle
      // this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Default padding
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight ?? 48,
        width: width,
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width, minWidth: 100),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: textColor ?? AppColorConstant.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
