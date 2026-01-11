import 'package:flutter_test/flutter_test.dart';
import '../lib/ai_feedback_system.dart';

void main() {
  test('Test original AIFeedbackSystem with index-based matching', () async {
    //print(
    //  '\n🎯 TESTING: Original AIFeedbackSystem (Rule-based with indexing)\n',
    //);

    // Test URL Shortener system (index 0)
    final urlResult = await AIFeedbackSystem.generateFeedbackForSystem(
      'URL Shortener (e.g., TinyURL)',
    );

    //print('=== ORIGINAL AI FEEDBACK SYSTEM ===');
    //print('System: ${urlResult.systemName}');
    //print('Score: ${urlResult.score}/100');
    //print('Has User Notes: ${urlResult.hasUserNotes}');
    //print('Feedback:');
    //print('╔════════════════════════════════════════════════════════════╗');
    urlResult.feedback.split('\n').take(10).forEach((line) {
      //  print('║ ${line.padRight(58)} ║');
    });
    //print('╚════════════════════════════════════════════════════════════╝');
    //print('\nComparison Details: ${urlResult.comparisonDetails}');

    // Test Pastebin system (index 1)
    final pastebinResult = await AIFeedbackSystem.generateFeedbackForSystem(
      'Pastebin Service (e.g., Pastebin.com)',
    );

    //print('\n=== PASTEBIN SYSTEM TEST ===');
    //print('System: ${pastebinResult.systemName}');
    //print('Score: ${pastebinResult.score}/100');
    //print('Has User Notes: ${pastebinResult.hasUserNotes}');

    // Verify it's working
    expect(urlResult.systemName, isNotEmpty);
    expect(urlResult.feedback, isNotEmpty);
    expect(pastebinResult.systemName, isNotEmpty);
    expect(pastebinResult.feedback, isNotEmpty);

    //print('\n✅ Original AIFeedbackSystem with indexing restored and working!');
    //print(
    //  'This uses the parallel database comparison with index-based matching',
    //);
    //print('exactly as it was originally designed.');
  });
}
