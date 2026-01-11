import 'package:flutter_test/flutter_test.dart';
import '../lib/inline_training_data_ai_service.dart';

void main() {
  test('Test inline training data AI service', () async {
    print('\n🎯 TESTING: Inline Training Data AI Service (Pure Dart)\n');

    // Test with a complex design
    final complexResult = await InlineTrainingDataAIService.evaluateDesign(
      question: 'Design a scalable e-commerce platform',
      answer: '''
A comprehensive e-commerce platform with the following architecture:

1. Frontend: React.js SPA with CDN distribution
2. Load Balancer: NGINX for distributing traffic across multiple servers
3. API Gateway: Kong for rate limiting and authentication  
4. Microservices Architecture:
   - User Service (authentication, profiles, JWT tokens)
   - Product Service (catalog, inventory management, Redis caching)
   - Order Service (cart, checkout, payment processing with Stripe)
   - Notification Service (emails, SMS, push notifications)
   - Search Service (Elasticsearch for product search)
5. Databases:
   - PostgreSQL for transactional data with read replicas
   - Redis for session storage and caching with 15-minute TTL
   - MongoDB for product reviews and recommendations
6. Message Queue: RabbitMQ for async order processing
7. Performance: 99.9% uptime target, <200ms API response time
8. Security: HTTPS, OAuth 2.0, input validation, SQL injection prevention
9. Monitoring: Prometheus + Grafana for metrics, ELK stack for logging
10. Scalability: Horizontal scaling with Docker containers on Kubernetes
11. Fault Tolerance: Circuit breakers, graceful degradation, health checks
12. Disaster Recovery: Database backups every 6 hours, multi-region deployment

Trade-offs: Microservices complexity vs monolith simplicity, eventual consistency vs strong consistency.
      ''',
    );

    print('=== COMPLEX E-COMMERCE DESIGN ===');
    print('Score: ${complexResult.score}/100');
    print('Category: ${complexResult.category}');
    print('Concepts: ${complexResult.concepts}');
    print('Feedback:');
    print('╔════════════════════════════════════════════════════════════╗');
    complexResult.feedback.split('\n').forEach((line) {
      print('║ ${line.padRight(58)} ║');
    });
    print('╚════════════════════════════════════════════════════════════╝');

    // Test with a simple design
    final simpleResult = await InlineTrainingDataAIService.evaluateDesign(
      question: 'Design a blog website',
      answer: 'A basic blog with posts and comments using WordPress.',
    );

    print('\n=== SIMPLE BLOG DESIGN ===');
    print('Score: ${simpleResult.score}/100');
    print('Category: ${simpleResult.category}');
    print(
      'Feedback preview: ${simpleResult.feedback.substring(0, simpleResult.feedback.length > 100 ? 100 : simpleResult.feedback.length)}...',
    );

    // Verify results
    expect(complexResult.score, greaterThan(simpleResult.score));
    expect(complexResult.score, greaterThan(50)); // Should be a good score
    expect(simpleResult.score, lessThan(30)); // Should be lower score

    expect(
      complexResult.feedback.contains('✅') ||
          complexResult.feedback.contains('⚠️'),
      true,
    );
    expect(
      simpleResult.feedback.contains('❌') ||
          simpleResult.feedback.contains('⚠️'),
      true,
    );

    expect(complexResult.category, equals('training_data_inline'));
    expect(simpleResult.category, equals('training_data_inline'));

    print('\n✅ All tests passed! Inline AI working perfectly!');
    print('Complex design score: ${complexResult.score}');
    print('Simple design score: ${simpleResult.score}');
    print(
      'Unicode characters working: ${complexResult.feedback.contains('✅') || complexResult.feedback.contains('⚠️') || complexResult.feedback.contains('❌')}',
    );
  });
}
