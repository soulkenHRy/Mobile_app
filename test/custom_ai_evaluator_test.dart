import 'package:flutter_test/flutter_test.dart';
import '../lib/custom_ai_evaluator.dart';

void main() {
  test('Test CustomAIEvaluator (Rule-based AI) for Design a System', () async {
    print('\n🎯 TESTING: CustomAIEvaluator (Rule-based AI)\n');

    // Test URL Shortener system
    final urlResult = CustomAIEvaluator.evaluateDesign(
      systemName: 'URL Shortener (e.g., TinyURL)',
      usedComponents: [
        'API Gateway',
        'Load Balancer',
        'Application Server',
        'Database',
        'Caching Layer',
        'CDN',
        'Redis Cache',
        'Monitoring',
      ],
      userNotes: '''
        Comprehensive URL shortener system design:
        
        1. Frontend handles user input and displays shortened URLs
        2. API Gateway manages incoming requests and rate limiting
        3. Load Balancer distributes traffic across multiple app servers
        4. Application servers handle URL generation using base62 encoding
        5. Database stores original URLs and shortened codes with timestamps
        6. Redis Cache caches frequently accessed URLs for better performance
        7. CDN distributes static content globally
        8. Monitoring tracks system health and performance metrics
        
        The system uses horizontal scaling for high availability and can handle
        millions of URL shortening requests. Security includes input validation
        and rate limiting to prevent abuse.
      ''',
    );

    print('=== URL SHORTENER EVALUATION (Rule-based AI) ===');
    print('Score: ${urlResult.score}/100');
    print('System Design Related: ${urlResult.isSystemDesignRelated}');
    print('Feedback:');
    print('╔════════════════════════════════════════════════════════════╗');
    urlResult.feedback.split('\n').take(10).forEach((line) {
      print('║ ${line.padRight(58)} ║');
    });
    print('╚════════════════════════════════════════════════════════════╝');

    // Test with minimal components
    final minimalResult = CustomAIEvaluator.evaluateDesign(
      systemName: 'URL Shortener (e.g., TinyURL)',
      usedComponents: ['Database'],
      userNotes: 'Basic URL shortener with just a database.',
    );

    print('\n=== MINIMAL DESIGN EVALUATION ===');
    print('Score: ${minimalResult.score}/100');
    print(
      'Feedback preview: ${minimalResult.feedback.substring(0, minimalResult.feedback.length > 100 ? 100 : minimalResult.feedback.length)}...',
    );

    // Verify it's working as expected
    expect(urlResult.score, greaterThan(minimalResult.score));
    expect(urlResult.isSystemDesignRelated, true);
    expect(minimalResult.isSystemDesignRelated, true);
    expect(urlResult.feedback, isNotEmpty);

    print('\n✅ CustomAIEvaluator (Rule-based AI) working correctly!');
    print('Complete design score: ${urlResult.score}');
    print('Minimal design score: ${minimalResult.score}');
    print('Score difference: ${urlResult.score - minimalResult.score}');
  });

  test('Test with unknown system', () async {
    print('\n🔍 TESTING: Unknown System Handling\n');

    final unknownResult = CustomAIEvaluator.evaluateDesign(
      systemName: 'Unknown System',
      usedComponents: ['Database'],
      userNotes: 'Some design notes',
    );

    print('Unknown system score: ${unknownResult.score}');
    print('System design related: ${unknownResult.isSystemDesignRelated}');
    print('Feedback: ${unknownResult.feedback}');

    expect(unknownResult.score, equals(0));
    expect(unknownResult.isSystemDesignRelated, false);
    expect(unknownResult.feedback, contains('not found'));
  });
}
