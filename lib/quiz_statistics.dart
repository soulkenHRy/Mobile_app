import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuizStatistics {
  final int score;
  final int totalQuestions;
  final int attempted;
  final double percentage;
  final DateTime dateTime;
  final int timeTakenInSeconds;

  QuizStatistics({
    required this.score,
    required this.totalQuestions,
    required this.attempted,
    required this.percentage,
    required this.dateTime,
    required this.timeTakenInSeconds,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'totalQuestions': totalQuestions,
      'attempted': attempted,
      'percentage': percentage,
      'dateTime': dateTime.toIso8601String(),
      'timeTakenInSeconds': timeTakenInSeconds,
    };
  }

  // Convert from JSON
  factory QuizStatistics.fromJson(Map<String, dynamic> json) {
    return QuizStatistics(
      score: json['score'],
      totalQuestions: json['totalQuestions'],
      attempted: json['attempted'],
      percentage: json['percentage'],
      dateTime: DateTime.parse(json['dateTime']),
      timeTakenInSeconds: json['timeTakenInSeconds'],
    );
  }

  static Future<void> saveQuizResult({
    required int score,
    required int totalQuestions,
    required int attempted,
    required double percentage,
    required int timeTakenInSeconds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    // Create new quiz result
    final newResult = QuizStatistics(
      score: score,
      totalQuestions: totalQuestions,
      attempted: attempted,
      percentage: percentage,
      dateTime: now,
      timeTakenInSeconds: timeTakenInSeconds,
    );

    // Get existing quiz history
    final historyJson = prefs.getStringList('quiz_history') ?? [];
    List<QuizStatistics> history =
        historyJson
            .map((json) => QuizStatistics.fromJson(jsonDecode(json)))
            .toList();

    // Add new result to history
    history.add(newResult);

    // Keep only last 10 results
    if (history.length > 10) {
      history = history.sublist(history.length - 10);
    }

    // Save updated history
    final updatedHistoryJson =
        history.map((stat) => jsonEncode(stat.toJson())).toList();
    await prefs.setStringList('quiz_history', updatedHistoryJson);

    // Save latest quiz result (for backward compatibility)
    await prefs.setInt('latest_score', score);
    await prefs.setInt('latest_total', totalQuestions);
    await prefs.setInt('latest_attempted', attempted);
    await prefs.setDouble('latest_percentage', percentage);
    await prefs.setInt('latest_time_taken', timeTakenInSeconds);
    await prefs.setString('latest_date', now.toIso8601String());

    // Update best score if current score is higher
    final bestScore = prefs.getInt('best_score') ?? 0;
    if (score > bestScore) {
      await prefs.setInt('best_score', score);
      await prefs.setInt('best_total', totalQuestions);
      await prefs.setDouble('best_percentage', percentage);
      await prefs.setInt('best_time_taken', timeTakenInSeconds);
      await prefs.setString('best_date', now.toIso8601String());
    }

    // Update total quizzes taken only if all questions were attempted
    if (attempted == totalQuestions) {
      final totalQuizzes = prefs.getInt('total_quizzes') ?? 0;
      await prefs.setInt('total_quizzes', totalQuizzes + 1);
    }
  }

  static Future<Map<String, dynamic>> getStatistics() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'latest': QuizStatistics(
        score: prefs.getInt('latest_score') ?? 0,
        totalQuestions: prefs.getInt('latest_total') ?? 0,
        attempted: prefs.getInt('latest_attempted') ?? 0,
        percentage: prefs.getDouble('latest_percentage') ?? 0.0,
        timeTakenInSeconds: prefs.getInt('latest_time_taken') ?? 0,
        dateTime: DateTime.parse(
          prefs.getString('latest_date') ?? DateTime.now().toIso8601String(),
        ),
      ),
      'best': QuizStatistics(
        score: prefs.getInt('best_score') ?? 0,
        totalQuestions: prefs.getInt('best_total') ?? 0,
        attempted: prefs.getInt('latest_attempted') ?? 0,
        percentage: prefs.getDouble('best_percentage') ?? 0.0,
        timeTakenInSeconds: prefs.getInt('best_time_taken') ?? 0,
        dateTime: DateTime.parse(
          prefs.getString('best_date') ?? DateTime.now().toIso8601String(),
        ),
      ),
      'totalQuizzes': prefs.getInt('total_quizzes') ?? 0,
    };
  }

  // Get quiz history for line chart (last 10 results)
  static Future<List<QuizStatistics>> getQuizHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('quiz_history') ?? [];

    return historyJson
        .map((json) => QuizStatistics.fromJson(jsonDecode(json)))
        .toList();
  }
}
