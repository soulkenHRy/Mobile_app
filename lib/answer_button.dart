import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
    this.answertxt,
    this.ontap, {
    super.key,
    this.isSelected = false,
    this.isCorrect,
  });

  final String answertxt;
  final void Function() ontap;
  final bool isSelected;
  final bool? isCorrect; // null: not answered, true: correct, false: wrong

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    double borderWidth = 2;
    Color buttonColor = const Color(0xFF4A3420); // Default cozy brown
    Color textColor = const Color(0xFFFFE4B5); // Default cream

    if (isCorrect != null) {
      if (isCorrect!) {
        // Green styling for correct answer
        borderColor = const Color(0xFF90EE90);
        buttonColor = const Color(0xFF228B22);
        textColor = const Color(0xFFFFFFFF);
        borderWidth = 3;
      } else if (isSelected) {
        // Red styling only for selected wrong answer
        borderColor = const Color(0xFFDC143C);
        buttonColor = const Color(0xFF8B0000);
        textColor = const Color(0xFFFFFFFF);
        borderWidth = 3;
      }
    } else if (isSelected) {
      // Orange styling for selected but not yet answered
      borderColor = const Color(0xFFFFD700);
      buttonColor = const Color(0xFF3D2817);
      textColor = const Color(0xFFFFE4B5);
      borderWidth = 3;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(
          color: borderColor ?? const Color(0xFFFFE4B5),
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(0), // Sharp corners for pixel style
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 0,
            offset: const Offset(3, 3), // Sharp shadow for pixel effect
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              answertxt,
              textAlign: TextAlign.center,
              style: GoogleFonts.saira(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
