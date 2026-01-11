import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'system_database_manager.dart';
import 'ai_feedback_system.dart';
import 'evaluation_result.dart';

class SystemDescriptionNotebook extends StatefulWidget {
  final String? systemId;
  final String? systemName;
  final List<String>? usedComponents;
  final Function(String, String)?
  onSubmitDesign; // Add callback for AI evaluation

  const SystemDescriptionNotebook({
    super.key,
    this.systemId,
    this.systemName,
    this.usedComponents,
    this.onSubmitDesign, // Add the callback parameter
  });

  @override
  State<SystemDescriptionNotebook> createState() =>
      _SystemDescriptionNotebookState();
}

class _SystemDescriptionNotebookState extends State<SystemDescriptionNotebook> {
  late TextEditingController _controller;
  late String currentSystemId;
  late String displaySystemName;
  bool _isEvaluating = false;
  EvaluationResult? _lastEvaluation;

  @override
  void initState() {
    super.initState();
    // Create unique system ID or use provided one
    currentSystemId =
        widget.systemId ?? 'system_${DateTime.now().millisecondsSinceEpoch}';
    displaySystemName = widget.systemName ?? 'Current System';
    _controller = TextEditingController();
    _loadNote();
    _loadEvaluation();

    // Migrate existing notes to new database (run once)
    _migrateNotesIfNeeded();
  }

  // Add method to refresh evaluation - call this when notebook is opened after AI evaluation
  Future<void> refreshEvaluation() async {
    _loadEvaluation();
    if (mounted) {
      setState(() {}); // Refresh the UI
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh evaluation when the widget becomes visible again
    // This handles the case where user submits via notebook, evaluation completes,
    // and then user opens notebook again
    _loadEvaluation();
  }

  void _migrateNotesIfNeeded() async {
    // Migration is no longer needed since we use specific databases
  }

  void _loadNote() async {
    // Load from specific system database
    final savedNote = await SystemDatabaseManager.loadNotesFromSpecificDatabase(
      displaySystemName,
    );

    if (savedNote != null && savedNote.isNotEmpty) {
      setState(() {
        _controller.text = savedNote;
      });
      return;
    }

    // Fallback to old SharedPreferences method
    final prefs = await SharedPreferences.getInstance();
    final oldNote = prefs.getString('systemNote_$currentSystemId');
    setState(() {
      _controller.text =
          oldNote ??
          '# $displaySystemName\n\nDescribe your system architecture here...';
    });
  }

  void _saveNote() async {
    // Save to specific system database for parallel comparison
    await SystemDatabaseManager.saveNotesToSpecificDatabase(
      displaySystemName,
      _controller.text,
    );

    // Also save to SharedPreferences for backward compatibility
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('systemNote_$currentSystemId', _controller.text);
  }

  void _loadEvaluation() async {
    final prefs = await SharedPreferences.getInstance();
    final evaluationJson = prefs.getString('evaluation_$currentSystemId');
    if (evaluationJson != null) {
      setState(() {
        _lastEvaluation = EvaluationResult.fromJson(jsonDecode(evaluationJson));
      });
    }
  }

  void _saveEvaluation(EvaluationResult result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'evaluation_$currentSystemId',
      jsonEncode(result.toJson()),
    );

    // Store evaluation data for leaderboard (same logic as LeaderboardScreen.addEvaluationScore)
    final evaluationData = {
      'score': result.score,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'systemName': widget.systemName,
      'feedback': result.feedback,
    };
    await prefs.setString(
      'evaluation_$currentSystemId',
      jsonEncode(evaluationData),
    );

    // Track best score per system for leaderboard
    final bestScoreKey = 'best_score_$currentSystemId';
    final currentBestScore = prefs.getInt(bestScoreKey) ?? 0;
    if (result.score > currentBestScore) {
      await prefs.setInt(bestScoreKey, result.score);
      await prefs.setString(
        'best_score_system_$currentSystemId',
        widget.systemName ?? displaySystemName,
      );
      await prefs.setInt(
        'best_score_timestamp_$currentSystemId',
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    // Mark that this system has been completed (evaluated)
    await prefs.setBool('system_completed_$currentSystemId', true);

    // Also save the general completion flag for leaderboard access
    await prefs.setBool('has_completed_system_design', true);

    // Update the user's overall best score for leaderboard display (from all systems)
    await _updateOverallBestScore(prefs);
  }

  Future<void> _updateOverallBestScore(SharedPreferences prefs) async {
    // Calculate total of best scores from all systems
    final systemNames = [
      'URL Shortener (e.g., TinyURL)',
      'Pastebin Service (e.g., Pastebin.com)',
      'Web Crawler',
      'Social Media News Feed (e.g., Facebook, X/Twitter)',
      'Video Streaming Service (e.g., Netflix, YouTube)',
      'Ride-Sharing Service (e.g., Uber, Lyft)',
      'Collaborative Editor (e.g., Google Docs, Figma)',
      'Live Streaming Platform (e.g., Twitch, YouTube Live)',
      'Global Gaming Leaderboard',
    ];

    int totalBestScore = 0;
    String bestSystemOverall = '';
    int highestSingleScore = 0;

    for (final systemName in systemNames) {
      final systemId = systemName.toLowerCase().replaceAll(' ', '_');
      final bestScore = prefs.getInt('best_score_$systemId') ?? 0;

      if (bestScore > 0) {
        totalBestScore += bestScore;

        // Track which system gave the highest single score
        if (bestScore > highestSingleScore) {
          highestSingleScore = bestScore;
          bestSystemOverall = systemName;
        }
      }
    }

    // INCLUDE UNLIMITED DESIGN SCORES in total calculation
    final unlimitedDesignKeys =
        prefs
            .getKeys()
            .where((key) => key.startsWith('best_score_unlimited_design_'))
            .toList();

    for (final key in unlimitedDesignKeys) {
      final bestScore = prefs.getInt(key) ?? 0;
      if (bestScore > 0) {
        totalBestScore += bestScore;

        // Track which system gave the highest single score (including unlimited design)
        if (bestScore > highestSingleScore) {
          highestSingleScore = bestScore;
          final systemId = key.replaceFirst('best_score_unlimited_design_', '');
          final displayName = systemId
              .replaceAll('_', ' ')
              .split(' ')
              .map(
                (word) =>
                    word.isEmpty
                        ? word
                        : word[0].toUpperCase() + word.substring(1),
              )
              .join(' ');
          bestSystemOverall = 'Unlimited Design: $displayName';
        }
      }
    }

    // Save overall statistics
    await prefs.setInt('user_total_best_score', totalBestScore);
    await prefs.setInt('user_highest_single_score', highestSingleScore);
    await prefs.setString('user_best_system_overall', bestSystemOverall);

    // Track user score history for bot calculations
    await _updateUserScoreHistory(prefs, totalBestScore);
  }

  Future<void> _updateUserScoreHistory(
    SharedPreferences prefs,
    int currentScore,
  ) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final historyEntry = jsonEncode({
      'score': currentScore,
      'timestamp': currentTime,
    });

    // Get existing history
    final scoreHistory = prefs.getStringList('user_score_history') ?? [];

    // Add new entry
    scoreHistory.add(historyEntry);

    // Keep only last 30 days of history (remove older entries)
    final thirtyDaysAgo =
        DateTime.now()
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch;
    scoreHistory.removeWhere((entry) {
      try {
        final data = jsonDecode(entry);
        final timestamp = data['timestamp'] as int;
        return timestamp < thirtyDaysAgo;
      } catch (e) {
        return true; // Remove invalid entries
      }
    });

    // Save updated history
    await prefs.setStringList('user_score_history', scoreHistory);
  }

  // Build comprehensive notes for AI evaluation
  String _buildComprehensiveNotes() {
    String notes = '';

    // Add system overview
    notes += 'System: ${displaySystemName}\n\n';

    // Add user's description from notebook
    if (_controller.text.trim().isNotEmpty) {
      notes += 'System Description:\n${_controller.text.trim()}\n\n';
    }

    // Add components used (if available)
    if (widget.usedComponents != null && widget.usedComponents!.isNotEmpty) {
      notes += 'Components Used:\n';
      for (String component in widget.usedComponents!) {
        notes += '- $component\n';
      }
      notes += '\n';
    }

    // Add architectural insights based on components
    if (widget.usedComponents != null && widget.usedComponents!.isNotEmpty) {
      notes += 'Architectural Insights:\n';
      if (widget.usedComponents!.contains('Load Balancer')) {
        notes += '- Implements load balancing for scalability\n';
      }
      if (widget.usedComponents!.contains('Database')) {
        notes += '- Uses database for data persistence\n';
      }
      if (widget.usedComponents!.contains('Cache')) {
        notes += '- Implements caching for performance optimization\n';
      }
      if (widget.usedComponents!.contains('API Gateway')) {
        notes += '- Uses API gateway for service orchestration\n';
      }
      if (widget.usedComponents!.contains('Message Queue')) {
        notes += '- Uses message queues for asynchronous processing\n';
      }
      if (widget.usedComponents!.contains('CDN')) {
        notes += '- Implements CDN for content delivery optimization\n';
      }
      if (widget.usedComponents!.contains('Microservice')) {
        notes += '- Uses microservices architecture for modularity\n';
      }
      notes += '\n';
    }

    notes +=
        'The design focuses on creating a scalable and maintainable system architecture.';

    return notes;
  }

  void _submitForEvaluation() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write some notes before submitting'),
        ),
      );
      return;
    }

    // Auto-save notes before submitting for evaluation
    _saveNote();

    // Show brief confirmation that notes are saved
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notes saved and submitting for evaluation...'),
        duration: Duration(seconds: 1),
      ),
    );

    // If we have the main canvas submit callback (unlimited design), use that
    if (widget.onSubmitDesign != null) {
      print(
        '📝📝📝 NOTEBOOK: Using unlimited design callback - should call duplicate detection! 📝📝📝',
      );
      // Build comprehensive notes from the notebook content
      String comprehensiveNotes = _buildComprehensiveNotes();

      print(
        '📝📝📝 NOTEBOOK: Built comprehensive notes: ${comprehensiveNotes.length} characters 📝📝📝',
      );

      // Call the main canvas submit function (same as the main submit button)
      widget.onSubmitDesign!(
        "Design: ${displaySystemName}",
        comprehensiveNotes,
      );

      // Close the notebook since evaluation will happen in the main screen
      Navigator.of(context).pop();
      return;
    }

    print(
      '📝📝📝 NOTEBOOK: No callback found - using original AI system (no duplicate detection) 📝📝📝',
    );
    // Use original AIFeedbackSystem for standalone design evaluation
    _evaluateWithOriginalAI();
  }

  void _evaluateWithOriginalAI() async {
    final displaySystemName = widget.systemName ?? widget.systemId ?? 'System';

    setState(() {
      _isEvaluating = true;
    });

    try {
      // Use your original AIFeedbackSystem exactly as it was with index-based matching
      final aiResult = await AIFeedbackSystem.generateFeedbackForSystem(
        displaySystemName,
        canvasComponents: widget.usedComponents,
      );

      // Convert AIFeedbackResult to EvaluationResult for compatibility
      final result = EvaluationResult(
        score: aiResult.score,
        feedback: aiResult.feedback,
        isSystemDesignRelated: true,
      );

      setState(() {
        _lastEvaluation = result;
        _isEvaluating = false;
      });

      _saveEvaluation(result);
      _showEvaluationResult(result);
    } catch (error) {
      setState(() {
        _isEvaluating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Evaluation failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showEvaluationResult(EvaluationResult result) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 30, 30, 30),
            title: Text(
              'Evaluation Results',
              style: GoogleFonts.saira(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Score Display
                    Center(
                      child: Text(
                        '${result.score}/100',
                        style: GoogleFonts.saira(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Feedback
                    Text(
                      result.feedback,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: GoogleFonts.saira(color: Colors.blue),
                ),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _saveNote(); // Save before disposing
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Save before navigating back
        _saveNote();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 6, 4, 4),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 82, 0, 105),
                      Color.fromARGB(255, 42, 0, 52),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _saveNote();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$displaySystemName - Notes',
                        style: GoogleFonts.saira(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isEvaluating ? null : _submitForEvaluation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade600,
                      ),
                      child:
                          _isEvaluating
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Text(
                                widget.onSubmitDesign != null
                                    ? 'Submit for AI Evaluation'
                                    : 'Submit',
                                style: TextStyle(fontSize: 14),
                              ),
                    ),
                  ],
                ),
              ),

              // Simple text area for notes
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 20, 20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) {
                      // Auto-save as user types
                      _saveNote();
                    },
                    maxLines: null,
                    expands: true,
                    style: GoogleFonts.sourceCodePro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your system notes here...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    contextMenuBuilder: (context, editableTextState) {
                      final List<ContextMenuButtonItem> buttonItems =
                          editableTextState.contextMenuButtonItems;
                      // Remove paste button
                      buttonItems.removeWhere(
                        (item) => item.type == ContextMenuButtonType.paste,
                      );
                      return AdaptiveTextSelectionToolbar.buttonItems(
                        anchors: editableTextState.contextMenuAnchors,
                        buttonItems: buttonItems,
                      );
                    },
                  ),
                ),
              ),

              // Simple evaluation message
              if (_lastEvaluation != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.assignment_turned_in,
                        color: Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Score: ${_lastEvaluation!.score}/100',
                        style: GoogleFonts.saira(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _showEvaluationResult(_lastEvaluation!),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'View Feedback',
                            style: GoogleFonts.saira(
                              fontSize: 12,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ); // WillPopScope
  }
}
