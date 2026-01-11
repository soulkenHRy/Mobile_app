import 'dart:math';
import 'evaluation_result.dart';

class CustomAIEvaluator {
  // System design knowledge base built from your app's data
  static const Map<String, SystemDesignKnowledge> _systemKnowledge = {
    'URL Shortener (e.g., TinyURL)': SystemDesignKnowledge(
      requiredComponents: [
        'API Gateway',
        'Load Balancer',
        'Application Server',
        'Database',
        'Caching Layer',
        'CDN',
      ],
      optionalComponents: [
        'Message Queue',
        'Analytics Service',
        'Monitoring',
        'Rate Limiter',
        'Redis Cache',
      ],
      architecturePatterns: [
        'Microservices',
        'Horizontal Scaling',
        'Database Sharding',
      ],
      maxScore: 100,
      weightings: {
        'core_components': 0.4,
        'scalability': 0.3,
        'performance': 0.2,
        'security': 0.1,
      },
    ),
    // Add more systems...
  };

  // Local scoring algorithm based on your app's components
  static EvaluationResult evaluateDesign({
    required String systemName,
    required List<String> usedComponents,
    required String userNotes,
  }) {
    final knowledge = _systemKnowledge[systemName];
    if (knowledge == null) {
      return EvaluationResult(
        score: 0,
        feedback: 'System not found in knowledge base',
        isSystemDesignRelated: false,
      );
    }

    // Component Analysis
    final componentScore = _evaluateComponents(
      usedComponents,
      knowledge,
      userNotes,
    );

    // Architecture Pattern Analysis
    final architectureScore = _evaluateArchitecture(userNotes, knowledge);

    // Scalability Analysis
    final scalabilityScore = _evaluateScalability(
      usedComponents,
      userNotes,
      knowledge,
    );

    // Security Analysis
    final securityScore = _evaluateSecurity(
      usedComponents,
      userNotes,
      knowledge,
    );

    // Weighted final score
    final finalScore =
        (componentScore * knowledge.weightings['core_components']! +
                architectureScore * knowledge.weightings['scalability']! +
                scalabilityScore * knowledge.weightings['performance']! +
                securityScore * knowledge.weightings['security']!)
            .round();

    return EvaluationResult(
      score: finalScore,
      feedback: _generateDetailedFeedback(
        componentScore,
        architectureScore,
        scalabilityScore,
        securityScore,
        knowledge,
      ),
      isSystemDesignRelated: true,
    );
  }

  static int _evaluateComponents(
    List<String> usedComponents,
    SystemDesignKnowledge knowledge,
    String userNotes,
  ) {
    int score = 0;
    int requiredFound = 0;
    int optionalFound = 0;
    final notesLower = userNotes.toLowerCase();

    // Check required components - look in both used components and user notes
    for (final required in knowledge.requiredComponents) {
      bool found = usedComponents.contains(required);

      // Also check if mentioned in notes (with flexible matching)
      if (!found) {
        final componentLower = required.toLowerCase();
        // Handle common variations
        final variations = <String>[
          componentLower,
          componentLower.replaceAll(' ', ''),
          componentLower.replaceAll(' ', '-'),
          componentLower.replaceAll(' ', '_'),
        ];

        for (final variation in variations) {
          if (notesLower.contains(variation)) {
            found = true;
            break;
          }
        }

        // Special case matching for common terms
        if (!found) {
          if (required == 'API Gateway' &&
              (notesLower.contains('api') && notesLower.contains('gateway')))
            found = true;
          if (required == 'Load Balancer' &&
              (notesLower.contains('load') && notesLower.contains('balanc')))
            found = true;
          if (required == 'CDN' &&
              (notesLower.contains('cdn') ||
                  notesLower.contains('content delivery')))
            found = true;
          if (required == 'Database' &&
              (notesLower.contains('database') || notesLower.contains('db ')))
            found = true;
          if (required == 'Caching Layer' &&
              (notesLower.contains('cach') || notesLower.contains('redis')))
            found = true;
        }
      }

      if (found) requiredFound++;
    }

    // Check optional components - look in both used components and user notes
    for (final optional in knowledge.optionalComponents) {
      bool found = usedComponents.contains(optional);

      // Also check if mentioned in notes
      if (!found) {
        final componentLower = optional.toLowerCase();
        final variations = <String>[
          componentLower,
          componentLower.replaceAll(' ', ''),
          componentLower.replaceAll(' ', '-'),
          componentLower.replaceAll(' ', '_'),
        ];

        for (final variation in variations) {
          if (notesLower.contains(variation)) {
            found = true;
            break;
          }
        }

        // Special case matching
        if (!found) {
          if (optional == 'Message Queue' &&
              (notesLower.contains('message') && notesLower.contains('queue')))
            found = true;
          if (optional == 'Analytics Service' &&
              (notesLower.contains('analytic') ||
                  notesLower.contains('metrics')))
            found = true;
          if (optional == 'Monitoring' && notesLower.contains('monitor'))
            found = true;
          if (optional == 'Rate Limiter' &&
              (notesLower.contains('rate') && notesLower.contains('limit')))
            found = true;
          if (optional == 'Redis Cache' && notesLower.contains('redis'))
            found = true;
        }
      }

      if (found) optionalFound++;
    }

    // Score calculation
    final requiredPercentage =
        requiredFound / knowledge.requiredComponents.length;
    final optionalBonus = min(optionalFound * 5, 20); // Max 20 bonus points

    score = (requiredPercentage * 80).round() + optionalBonus;
    return min(score, 100);
  }

  static int _evaluateArchitecture(
    String userNotes,
    SystemDesignKnowledge knowledge,
  ) {
    final notesLower = userNotes.toLowerCase();

    // Only give base score if there's meaningful content (more than just a greeting)
    int score = 0;
    final meaningfulWords = [
      'architecture',
      'design',
      'system',
      'component',
      'service',
      'server',
      'database',
      'api',
      'gateway',
      'load',
      'balance',
      'cache',
      'microservice',
      'monolith',
      'scale',
    ];

    bool hasMeaningfulContent = false;
    for (final word in meaningfulWords) {
      if (notesLower.contains(word)) {
        hasMeaningfulContent = true;
        break;
      }
    }

    // Only award base score if content seems system design related
    if (hasMeaningfulContent && notesLower.length > 10) {
      score = 60; // Base score for meaningful system design content
    }

    // Check for architecture patterns mentioned
    for (final pattern in knowledge.architecturePatterns) {
      if (notesLower.contains(pattern.toLowerCase())) {
        score += 15;
      }
    }

    // Check for key system design concepts
    final concepts = [
      'load balancing',
      'caching',
      'database',
      'scaling',
      'availability',
      'consistency',
      'partition',
      'replication',
    ];

    int conceptsFound = 0;
    for (final concept in concepts) {
      if (notesLower.contains(concept)) {
        conceptsFound++;
      }
    }

    score += conceptsFound * 5;
    return min(score, 100);
  }

  static int _evaluateScalability(
    List<String> components,
    String notes,
    SystemDesignKnowledge knowledge,
  ) {
    final notesLower = notes.toLowerCase();

    // Only give base score if there's meaningful scalability content
    int score = 0;
    final scalabilityWords = [
      'scale',
      'scaling',
      'load',
      'balance',
      'performance',
      'throughput',
      'latency',
      'horizontal',
      'vertical',
      'distribute',
      'partition',
      'shard',
      'replica',
      'cache',
    ];

    bool hasScalabilityContent = false;
    for (final word in scalabilityWords) {
      if (notesLower.contains(word)) {
        hasScalabilityContent = true;
        break;
      }
    }

    // Only award base score if content mentions scalability concepts
    if (hasScalabilityContent && notesLower.length > 10) {
      score = 50; // Base score for scalability-related content
    }

    // Check for scalability components
    final scalabilityComponents = [
      'Load Balancer',
      'CDN',
      'Caching Layer',
      'Message Queue',
      'Database Sharding',
      'Horizontal Scaling',
    ];

    for (final comp in scalabilityComponents) {
      if (components.contains(comp)) {
        score += 10;
      }
    }

    // Check for scalability mentions in notes
    final scalabilityKeywords = [
      'horizontal scaling',
      'vertical scaling',
      'load balancing',
      'caching',
      'cdn',
      'sharding',
      'replication',
      'clustering',
    ];

    for (final keyword in scalabilityKeywords) {
      if (notesLower.contains(keyword)) {
        score += 8;
      }
    }

    return min(score, 100);
  }

  static int _evaluateSecurity(
    List<String> components,
    String notes,
    SystemDesignKnowledge knowledge,
  ) {
    final notesLower = notes.toLowerCase();

    // Only give base score if there's meaningful security content
    int score = 0;
    final securityWords = [
      'security',
      'auth',
      'authentication',
      'authorization',
      'encrypt',
      'https',
      'ssl',
      'tls',
      'firewall',
      'rate',
      'limit',
      'validate',
      'sanitize',
      'token',
      'oauth',
      'jwt',
    ];

    bool hasSecurityContent = false;
    for (final word in securityWords) {
      if (notesLower.contains(word)) {
        hasSecurityContent = true;
        break;
      }
    }

    // Only award base score if content mentions security concepts
    if (hasSecurityContent && notesLower.length > 10) {
      score = 60; // Base score for security-related content
    }

    // Check for security components
    final securityComponents = [
      'API Gateway',
      'Rate Limiter',
      'Authentication Service',
      'Firewall',
      'SSL/TLS',
      'Security Scanner',
    ];

    for (final comp in securityComponents) {
      if (components.contains(comp)) {
        score += 10;
      }
    }

    // Check for security mentions in notes
    final securityKeywords = [
      'authentication',
      'authorization',
      'encryption',
      'ssl',
      'tls',
      'security',
      'firewall',
      'rate limiting',
      'validation',
    ];

    for (final keyword in securityKeywords) {
      if (notesLower.contains(keyword)) {
        score += 5;
      }
    }

    return min(score, 100);
  }

  static String _generateDetailedFeedback(
    int componentScore,
    int architectureScore,
    int scalabilityScore,
    int securityScore,
    SystemDesignKnowledge knowledge,
  ) {
    List<String> feedback = [];

    // Component feedback
    if (componentScore < 60) {
      feedback.add(
        "⚠️ Missing key components. Consider adding: ${knowledge.requiredComponents.take(3).join(', ')}",
      );
    } else if (componentScore >= 80) {
      feedback.add("✅ Excellent component selection!");
    }

    // Architecture feedback
    if (architectureScore < 60) {
      feedback.add(
        "💡 Consider discussing architecture patterns like microservices or event-driven design",
      );
    } else if (architectureScore >= 80) {
      feedback.add("🏗️ Strong architectural thinking demonstrated!");
    }

    // Scalability feedback
    if (scalabilityScore < 60) {
      feedback.add(
        "📈 Add scalability components: Load Balancer, CDN, or Caching Layer",
      );
    } else if (scalabilityScore >= 80) {
      feedback.add("🚀 Great scalability considerations!");
    }

    // Security feedback
    if (securityScore < 60) {
      feedback.add(
        "🔒 Enhance security with API Gateway, Rate Limiting, or Authentication",
      );
    } else if (securityScore >= 80) {
      feedback.add("🛡️ Strong security awareness!");
    }

    return feedback.join('\n');
  }
}

class SystemDesignKnowledge {
  final List<String> requiredComponents;
  final List<String> optionalComponents;
  final List<String> architecturePatterns;
  final int maxScore;
  final Map<String, double> weightings;

  const SystemDesignKnowledge({
    required this.requiredComponents,
    required this.optionalComponents,
    required this.architecturePatterns,
    required this.maxScore,
    required this.weightings,
  });
}
