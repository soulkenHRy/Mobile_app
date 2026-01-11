class EvaluationResult {
  final int score;
  final String feedback;
  final bool isSystemDesignRelated;
  final List<String>? concepts;
  final String? category;

  EvaluationResult({
    required this.score,
    required this.feedback,
    required this.isSystemDesignRelated,
    this.concepts,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'feedback': feedback,
      'isSystemDesignRelated': isSystemDesignRelated,
      'concepts': concepts,
      'category': category,
      'keywords_found': concepts, // For compatibility
    };
  }

  factory EvaluationResult.fromJson(Map<String, dynamic> json) {
    return EvaluationResult(
      score: json['score'] ?? 0,
      feedback: json['feedback'] ?? '',
      isSystemDesignRelated: json['isSystemDesignRelated'] ?? true,
      concepts:
          json['concepts'] != null ? List<String>.from(json['concepts']) : null,
      category: json['category'],
    );
  }
}
