import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './answer_button.dart';
import './quiz_statistics.dart';
import './question_data.dart';
import './question_data2.dart';
import './question_data3.dart';
import './question_data4.dart';
import './pre_start_screen.dart';
import 'dart:async';
import 'dart:math';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String get timerString {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min}min ${sec.toString().padLeft(2, '0')}sec';
  }

  int seconds = 2700;
  Timer? _timer;
  DateTime? _quizStartTime;
  bool _quizResultsSaved = false;

  @override
  void initState() {
    super.initState();

    // Shuffle questions once when quiz starts (same pattern as answer shuffling)
    allQuestions = List.of(_originalQuestions);
    allQuestions.shuffle();

    _quizStartTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else if (idxcounts < allQuestions.length) {
        setState(() {
          idxcounts = allQuestions.length;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Combine all questions from all files
  final List _originalQuestions = [
    ...questions1,
    ...questions2,
    ...questions3,
    ...questions4,
  ];

  // Shuffled version of questions (shuffled once when quiz starts)
  late final List allQuestions;

  final Map<int, List<String>> _shuffledAnswers = {};
  var idxcounts = 0;
  List<List<String>> chosenAnswers = [];
  List<String> selectedAnswers = [];
  String? selectedAnswer; // For single-select
  bool answered = false;

  void changingidx(
    String answer, {
    bool isMultiSelect = false,
    int maxSelections = 1,
  }) {
    if (answered) return;
    setState(() {
      final currentquestion = allQuestions[idxcounts];
      if (questions2.contains(currentquestion) ||
          questions3.contains(currentquestion) ||
          questions4.contains(currentquestion)) {
        // Multi-select: toggle selection, allow as many as available
        if (selectedAnswers.contains(answer)) {
          selectedAnswers.remove(answer);
        } else {
          selectedAnswers.add(answer);
        }
      } else {
        // Single-select: set selected answer only
        selectedAnswer = answer;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      idxcounts++;
      selectedAnswer = null;
      selectedAnswers.clear();
      answered = false;
    });
  }

  void showResultDialog(bool isCorrect, {bool missedAnswers = false}) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
            content: Text(
              isCorrect
                  ? 'You selected the correct answer.'
                  : missedAnswers
                  ? 'Oops you missed some answers'
                  : 'Your answer was incorrect.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void showExplanation() {
    final currentquestion = allQuestions[idxcounts];
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Explanation'),
            content: SingleChildScrollView(
              child: currentquestion.getStyledExplanation(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  // Show quit confirmation dialog
  Future<bool> _showQuitDialog() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: const Text('Do you want to quit?'),
                content: const Text('Are you sure you want to go back?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false); // Return false (don't quit)
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true); // Return true (quit)
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false; // Return false if dialog is dismissed
  }

  void _showSystemDesignHelp() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFFF6B35), width: 2),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: Color(0xFFFF6B35),
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'What is System Design?',
              style: GoogleFonts.saira(
                color: const Color(0xFFFFE4B5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'System design is making sure all the different pieces work together smoothly, like a well-oiled machine.',
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Think of it like a pizza delivery business:',
                style: GoogleFonts.robotoSlab(
                  color: const Color(0xFFFF6B35),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildBulletPoint('The kitchen makes pizzas'),
              _buildBulletPoint('The delivery drivers bring them to customers'),
              _buildBulletPoint('The phone system takes orders'),
              _buildBulletPoint('The payment system handles money'),
              const SizedBox(height: 16),
              Text(
                'System design makes sure:',
                style: GoogleFonts.robotoSlab(
                  color: const Color(0xFFFF6B35),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildBulletPoint('Orders reach the kitchen correctly'),
              _buildBulletPoint('Drivers know where to go'),
              _buildBulletPoint('Payments go through'),
              _buildBulletPoint('Everything happens in the right order'),
              const SizedBox(height: 16),
              Text(
                'If these pieces don\'t work together properly, you get chaos - wrong orders, cold pizzas, angry customers!',
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'For Apps',
                style: GoogleFonts.robotoSlab(
                  color: const Color(0xFFFF6B35),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Same idea - an app like Netflix has:',
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              _buildBulletPoint('A place that stores all the movies'),
              _buildBulletPoint('A system that knows what you like'),
              _buildBulletPoint('Servers that send video to your screen'),
              _buildBulletPoint('A payment system for your subscription'),
              const SizedBox(height: 16),
              Text(
                'System design makes sure all these parts talk to each other and work as one system, not a bunch of confused pieces.',
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFF6B35),
                    width: 1,
                  ),
                ),
                child: Text(
                  '✨ System design = making everything work together as a team.',
                  style: GoogleFonts.saira(
                    color: const Color(0xFFFFE4B5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Got it!',
              style: GoogleFonts.saira(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.robotoSlab(
              color: const Color(0xFFFF6B35),
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    if (idxcounts >= allQuestions.length) {
      // Quiz finished or time ended
      int attempted = chosenAnswers.length;
      int correctCount = 0;
      int totalQuestions = 50;
      for (int i = 0; i < attempted; i++) {
        final question = allQuestions[i];
        final userAnswers = chosenAnswers[i];
        if (question.isMultiSelect) {
          if (Set.from(userAnswers).containsAll(question.answers)) {
            correctCount++;
          }
        } else {
          if (userAnswers.isNotEmpty && userAnswers[0] == question.answers[0]) {
            correctCount++;
          }
        }
      }
      double percent =
          totalQuestions == 0 ? 0 : (correctCount / totalQuestions) * 100;

      // Calculate time taken
      final timeTaken =
          _quizStartTime != null
              ? DateTime.now().difference(_quizStartTime!).inSeconds
              : 0;

      // Save quiz statistics only if not already saved
      if (!_quizResultsSaved) {
        QuizStatistics.saveQuizResult(
          score: correctCount,
          totalQuestions: totalQuestions,
          attempted: attempted,
          percentage: percent,
          timeTakenInSeconds: timeTaken,
        );
        _quizResultsSaved = true;
      }

      return Scaffold(
        body: Stack(
          children: [
            // Cozy pixel background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                // Cozy pixel-like gradient background
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2C1810), // Dark brown
                    Color(0xFF3D2817), // Medium brown
                    Color(0xFF4A3420), // Light brown
                    Color(0xFF5C4129), // Tan
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Cozy pixel-style stars/dots background
                  ...List.generate(30, (index) {
                    final random = Random(index);
                    return Positioned(
                      left:
                          random.nextDouble() *
                          MediaQuery.of(context).size.width,
                      top:
                          random.nextDouble() *
                          MediaQuery.of(context).size.height,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE4B5).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3420),
                  borderRadius: BorderRadius.circular(
                    0,
                  ), // Sharp corners for pixel style
                  border: Border.all(color: const Color(0xFFFFE4B5), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 0,
                      offset: const Offset(4, 4), // Sharp shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Quiz Finished!',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFE4B5),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Score: $correctCount / $totalQuestions',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFE4B5),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Text(
                      'Percentage: ${percent.toStringAsFixed(1)}%',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF90EE90),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Text(
                      'Attempted: $attempted',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFE4B5),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D2817),
                        borderRadius: BorderRadius.circular(0), // Sharp corners
                        border: Border.all(
                          color: const Color(0xFFFFE4B5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 0,
                            offset: const Offset(3, 3), // Sharp shadow
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              idxcounts = 0;
                              chosenAnswers.clear();
                              selectedAnswer = null;
                              selectedAnswers.clear();
                              answered = false;
                              _quizResultsSaved = false; // Reset the saved flag
                              _quizStartTime =
                                  DateTime.now(); // Reset start time
                              // Reset timer
                              seconds = 2700; // Reset to full time (45 minutes)
                              _timer?.cancel();
                              _timer = Timer.periodic(
                                const Duration(seconds: 1),
                                (Timer t) {
                                  if (seconds > 0) {
                                    setState(() {
                                      seconds--;
                                    });
                                  } else {
                                    t.cancel();
                                    setState(() {
                                      idxcounts = allQuestions.length;
                                    });
                                  }
                                },
                              );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            child: Text(
                              'Restart',
                              style: GoogleFonts.saira(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFE4B5),
                                  fontFamily: 'monospace',
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
            ),
          ],
        ),
      );
    }
    final currentquestion = allQuestions[idxcounts];
    final correctAnswer = currentquestion.answers[0];
    final isMultiSelect = currentquestion.isMultiSelect;
    final maxSelections = currentquestion.maxSelections;
    // Cache shuffled answers for this question index
    if (!_shuffledAnswers.containsKey(idxcounts)) {
      _shuffledAnswers[idxcounts] = currentquestion.getSufflens();
    }
    final List<String> shownAnswers = _shuffledAnswers[idxcounts]!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        bool shouldQuit = await _showQuitDialog();
        if (shouldQuit && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Cozy pixel background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                // Cozy pixel-like gradient background
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2C1810), // Dark brown
                    Color(0xFF3D2817), // Medium brown
                    Color(0xFF4A3420), // Light brown
                    Color(0xFF5C4129), // Tan
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Cozy pixel-style stars/dots background
                  ...List.generate(50, (index) {
                    final random = Random(index);
                    return Positioned(
                      left:
                          random.nextDouble() *
                          MediaQuery.of(context).size.width,
                      top:
                          random.nextDouble() *
                          MediaQuery.of(context).size.height,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE4B5).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Question count at top center
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3420),
                    borderRadius: BorderRadius.circular(0), // Sharp corners
                    border: Border.all(
                      color: const Color(0xFFFFE4B5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 0,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Question ${idxcounts + 1}/${allQuestions.length}',
                    style: GoogleFonts.saira(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFFE4B5),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 100,
                    bottom: 12,
                  ),
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 82, 0, 105),
                                Color.fromARGB(255, 6, 4, 4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            currentquestion.text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoSlab(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...shownAnswers.map((answers) {
                          bool isSelected =
                              isMultiSelect
                                  ? selectedAnswers.contains(answers)
                                  : selectedAnswer == answers;
                          bool? isCorrect;
                          if (!answered && isSelected) {
                            // Show green border for any selected answer before submit for question_data.dart (questions1)
                            if (questions1.contains(currentquestion)) {
                              isCorrect = true;
                            } else if (isMultiSelect) {
                              isCorrect = true;
                            }
                          } else if (answered) {
                            if (questions1.contains(currentquestion)) {
                              // After submit, always show green border for the correct answer
                              isCorrect = answers == correctAnswer;
                            } else if (isMultiSelect &&
                                (questions2.contains(currentquestion) ||
                                    questions3.contains(currentquestion) ||
                                    questions4.contains(currentquestion))) {
                              // Multi-select: green for all correct answers (selected or not), red for selected wrong answers, nothing for unselected wrong answers
                              final correctSet =
                                  questions2.contains(currentquestion)
                                      ? {
                                        currentquestion.answers[0],
                                        currentquestion.answers[1],
                                      }
                                      : questions3.contains(currentquestion)
                                      ? {
                                        currentquestion.answers[0],
                                        currentquestion.answers[1],
                                        currentquestion.answers[2],
                                      }
                                      : {
                                        currentquestion.answers[0],
                                        currentquestion.answers[1],
                                        currentquestion.answers[2],
                                        currentquestion.answers[3],
                                      };
                              if (correctSet.contains(answers)) {
                                isCorrect = true;
                              } else if (isSelected &&
                                  !correctSet.contains(answers)) {
                                isCorrect = false;
                              } else {
                                isCorrect = null;
                              }
                            } else if (isSelected) {
                              isCorrect = answers == correctAnswer;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: AnswerButton(
                              answers,
                              answered
                                  ? () {}
                                  : () {
                                    if (isMultiSelect) {
                                      changingidx(
                                        answers,
                                        isMultiSelect: true,
                                        maxSelections: maxSelections,
                                      );
                                    } else {
                                      changingidx(answers);
                                    }
                                  },
                              isSelected: isSelected,
                              isCorrect: isCorrect,
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              answered ||
                                      (isMultiSelect
                                          ? selectedAnswers.isEmpty
                                          : selectedAnswer == null)
                                  ? null
                                  : () {
                                    setState(() {
                                      answered = true;
                                      if (isMultiSelect) {
                                        chosenAnswers.add(
                                          List.from(selectedAnswers),
                                        );
                                      } else {
                                        chosenAnswers.add([selectedAnswer!]);
                                      }
                                      // Show result dialog
                                      final currentquestion =
                                          allQuestions[idxcounts];
                                      if (isMultiSelect &&
                                          (questions2.contains(
                                                currentquestion,
                                              ) ||
                                              questions3.contains(
                                                currentquestion,
                                              ) ||
                                              questions4.contains(
                                                currentquestion,
                                              ))) {
                                        final correctSet =
                                            questions2.contains(currentquestion)
                                                ? {
                                                  currentquestion.answers[0],
                                                  currentquestion.answers[1],
                                                }
                                                : questions3.contains(
                                                  currentquestion,
                                                )
                                                ? {
                                                  currentquestion.answers[0],
                                                  currentquestion.answers[1],
                                                  currentquestion.answers[2],
                                                }
                                                : {
                                                  currentquestion.answers[0],
                                                  currentquestion.answers[1],
                                                  currentquestion.answers[2],
                                                  currentquestion.answers[3],
                                                };
                                        // Only correct if selected set matches correct set exactly (no extra answers)
                                        final selectedSet = Set.from(
                                          selectedAnswers,
                                        );
                                        final isCorrect =
                                            selectedSet.length ==
                                                correctSet.length &&
                                            selectedSet.containsAll(correctSet);

                                        // Check if user missed answers vs selected wrong answers
                                        bool missedAnswers = false;
                                        if (!isCorrect) {
                                          // Check if user only selected correct answers but missed some
                                          final userSelectedWrongAnswers =
                                              selectedSet
                                                  .where(
                                                    (answer) =>
                                                        !correctSet.contains(
                                                          answer,
                                                        ),
                                                  )
                                                  .isNotEmpty;

                                          // If user didn't select any wrong answers but missed some correct ones
                                          if (!userSelectedWrongAnswers &&
                                              selectedSet.isNotEmpty) {
                                            missedAnswers = true;
                                          }
                                        }

                                        showResultDialog(
                                          isCorrect,
                                          missedAnswers: missedAnswers,
                                        );
                                      } else {
                                        showResultDialog(
                                          selectedAnswer ==
                                              currentquestion.answers[0],
                                        );
                                      }
                                    });
                                  },
                          child: const Text('Submit'),
                        ),
                        if (answered) ...[
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: nextQuestion,
                                child: const Text('Next'),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: showExplanation,
                                child: const Text('Explanation'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Top-left button (moved to top of stack)
            Positioned(
              top: 20,
              left: 5,
              child: SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    elevation: 6,
                  ),
                  onPressed: () async {
                    bool shouldQuit = await _showQuitDialog();
                    if (shouldQuit) {
                      if (mounted) {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PreStartScreen(
                                  onProceed: () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const StartScreen(),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Icon(Icons.home, size: 25),
                ),
              ),
            ),
            Positioned(
              top: 110,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timerString,
                      style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Help button at bottom right
            Positioned(
              bottom: 20,
              right: 20,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: _showSystemDesignHelp,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFFFFE4B5),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ), // End of Scaffold
    ); // End of PopScope
  }
}
