import 'package:flutter/material.dart';

class QuizQuestion {
  bool get isMultiSelect =>
      text.toLowerCase().contains('(check all that apply)');

  int get maxSelections {
    // Assume all answers are correct for multi-select, or customize as needed
    // You may want to mark correct answers differently in the future
    return isMultiSelect ? answers.length : 1;
  }

  const QuizQuestion(this.text, this.answers, this.explanation);

  final String text;
  final List<String> answers;
  final String explanation;

  Widget getStyledExplanation() {
    List<TextSpan> textSpans = [];
    String currentText = '';
    int i = 0;

    void addCurrentText() {
      if (currentText.isNotEmpty) {
        textSpans.add(
          TextSpan(
            text: currentText,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        );
        currentText = '';
      }
    }

    while (i < explanation.length) {
      if (explanation[i] == '[') {
        // Handle square brackets content - bigger bold
        addCurrentText();
        int end = explanation.indexOf(']', i);
        if (end != -1) {
          textSpans.add(
            TextSpan(
              text: explanation.substring(i + 1, end),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
          i = end + 1;
          continue;
        }
      } else if (explanation[i] == '{') {
        // Handle curly braces content - smaller bold
        addCurrentText();
        int end = explanation.indexOf('}', i);
        if (end != -1) {
          textSpans.add(
            TextSpan(
              text: explanation.substring(i + 1, end),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
          i = end + 1;
          continue;
        }
      }
      currentText += explanation[i];
      i++;
    }

    addCurrentText();

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  List<String> getSufflens() {
    final shufans = List.of(answers);
    shufans.shuffle();
    return shufans;
  }
}
