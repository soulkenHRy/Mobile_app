// Design Comparison Service
// Compares user's canvas design with all demo designs to find missing connections

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import all canvas design files
import 'url_shortener_canvas_designs.dart';
import 'gaming_leaderboard_canvas_designs.dart';
import 'live_streaming_canvas_designs.dart';
import 'video_streaming_canvas_designs.dart';
import 'ride_sharing_canvas_designs.dart';
import 'collaborative_editor_canvas_designs.dart';
import 'pastebin_canvas_designs.dart';
import 'web_crawler_canvas_designs.dart';
import 'news_feed_canvas_designs.dart';

/// Enum for system design types
enum SystemType {
  urlShortener,
  gamingLeaderboard,
  liveStreaming,
  videoStreaming,
  rideSharing,
  collaborativeEditor,
  pastebin,
  webCrawler,
  newsFeed,
}

/// Represents a connection between two icons (by name)
class IconConnection {
  final String fromIcon;
  final String toIcon;
  final String? label;

  IconConnection({required this.fromIcon, required this.toIcon, this.label});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IconConnection &&
        other.fromIcon.toLowerCase() == fromIcon.toLowerCase() &&
        other.toIcon.toLowerCase() == toIcon.toLowerCase();
  }

  @override
  int get hashCode =>
      fromIcon.toLowerCase().hashCode ^ toIcon.toLowerCase().hashCode;

  @override
  String toString() => '$fromIcon → $toIcon${label != null ? ' ($label)' : ''}';
}

/// Result of comparing user design with a single demo design
class DesignComparisonResult {
  final String demoName;
  final String demoDescription;
  final List<IconConnection> demoConnections;
  final List<IconConnection> userConnections;
  final List<IconConnection> matchingConnections;
  final List<IconConnection> missingConnections;
  final List<IconConnection> extraConnections; // User has but demo doesn't
  final List<String> missingIcons;
  final double matchPercentage;

  DesignComparisonResult({
    required this.demoName,
    required this.demoDescription,
    required this.demoConnections,
    required this.userConnections,
    required this.matchingConnections,
    required this.missingConnections,
    required this.extraConnections,
    required this.missingIcons,
    required this.matchPercentage,
  });
}

/// Main comparison service
class DesignComparisonService {
  /// Get all demo designs for a specific system type
  static List<Map<String, dynamic>> getDemoDesigns(SystemType systemType) {
    switch (systemType) {
      case SystemType.urlShortener:
        return URLShortenerCanvasDesigns.getAllDesigns();
      case SystemType.gamingLeaderboard:
        return GamingLeaderboardCanvasDesigns.getAllDesigns();
      case SystemType.liveStreaming:
        return LiveStreamingCanvasDesigns.getAllDesigns();
      case SystemType.videoStreaming:
        return VideoStreamingCanvasDesigns.getAllDesigns();
      case SystemType.rideSharing:
        return RideSharingCanvasDesigns.getAllDesigns();
      case SystemType.collaborativeEditor:
        return CollaborativeEditorCanvasDesigns.getAllDesigns();
      case SystemType.pastebin:
        return PastebinCanvasDesigns.getAllDesigns();
      case SystemType.webCrawler:
        return WebCrawlerCanvasDesigns.getAllDesigns();
      case SystemType.newsFeed:
        return NewsFeedCanvasDesigns.getAllDesigns();
    }
  }

  /// Get system type from system name string
  static SystemType? getSystemTypeFromName(String systemName) {
    final lowerName = systemName.toLowerCase();

    if (lowerName.contains('url') ||
        lowerName.contains('shortener') ||
        lowerName.contains('tiny')) {
      return SystemType.urlShortener;
    } else if (lowerName.contains('gaming') ||
        lowerName.contains('leaderboard') ||
        lowerName.contains('ranking')) {
      return SystemType.gamingLeaderboard;
    } else if (lowerName.contains('live') && lowerName.contains('stream')) {
      return SystemType.liveStreaming;
    } else if (lowerName.contains('video') ||
        lowerName.contains('netflix') ||
        lowerName.contains('youtube')) {
      return SystemType.videoStreaming;
    } else if (lowerName.contains('ride') ||
        lowerName.contains('uber') ||
        lowerName.contains('taxi')) {
      return SystemType.rideSharing;
    } else if (lowerName.contains('collab') ||
        lowerName.contains('editor') ||
        lowerName.contains('doc')) {
      return SystemType.collaborativeEditor;
    } else if (lowerName.contains('paste') ||
        lowerName.contains('bin') ||
        lowerName.contains('snippet')) {
      return SystemType.pastebin;
    } else if (lowerName.contains('crawl') ||
        lowerName.contains('spider') ||
        lowerName.contains('search engine')) {
      return SystemType.webCrawler;
    } else if (lowerName.contains('feed') ||
        lowerName.contains('facebook') ||
        lowerName.contains('twitter') ||
        lowerName.contains('social')) {
      return SystemType.newsFeed;
    }

    return null;
  }

  /// Extract connections from demo design data
  static List<IconConnection> extractDemoConnections(
    Map<String, dynamic> design,
  ) {
    final connections = <IconConnection>[];
    final icons = design['icons'] as List<dynamic>? ?? [];
    final conns = design['connections'] as List<dynamic>? ?? [];

    for (final conn in conns) {
      final fromIndex = conn['fromIconIndex'] as int;
      final toIndex = conn['toIconIndex'] as int;
      final label = conn['label'] as String?;

      if (fromIndex >= 0 &&
          fromIndex < icons.length &&
          toIndex >= 0 &&
          toIndex < icons.length) {
        final fromIcon = icons[fromIndex] as Map<String, dynamic>;
        final toIcon = icons[toIndex] as Map<String, dynamic>;

        connections.add(
          IconConnection(
            fromIcon: fromIcon['name'] as String,
            toIcon: toIcon['name'] as String,
            label: label,
          ),
        );
      }
    }

    return connections;
  }

  /// Extract icons from demo design
  static List<String> extractDemoIcons(Map<String, dynamic> design) {
    final icons = design['icons'] as List<dynamic>? ?? [];
    return icons
        .map((icon) => (icon as Map<String, dynamic>)['name'] as String)
        .toList();
  }

  /// Extract connections from user's canvas data
  /// User data format: { 'icons': [...], 'lines': [...] }
  /// Lines have start/end positions, we need to match to icons
  static List<IconConnection> extractUserConnections(
    List<dynamic> userIcons,
    List<dynamic> userLines,
  ) {
    final connections = <IconConnection>[];

    // Build icon position lookup
    final iconPositions = <int, Map<String, dynamic>>{};
    for (int i = 0; i < userIcons.length; i++) {
      iconPositions[i] = userIcons[i] as Map<String, dynamic>;
    }

    // For each line, find which icons it connects
    for (final line in userLines) {
      final lineData = line as Map<String, dynamic>;

      // Get line start and end positions
      final startX =
          (lineData['startX'] as num?)?.toDouble() ??
          (lineData['start'] as Map?)?['dx']?.toDouble() ??
          0;
      final startY =
          (lineData['startY'] as num?)?.toDouble() ??
          (lineData['start'] as Map?)?['dy']?.toDouble() ??
          0;
      final endX =
          (lineData['endX'] as num?)?.toDouble() ??
          (lineData['end'] as Map?)?['dx']?.toDouble() ??
          0;
      final endY =
          (lineData['endY'] as num?)?.toDouble() ??
          (lineData['end'] as Map?)?['dy']?.toDouble() ??
          0;

      // Find icons near start and end points
      String? fromIconName;
      String? toIconName;

      for (final entry in iconPositions.entries) {
        final icon = entry.value;
        final iconX = (icon['positionX'] as num?)?.toDouble() ?? 0;
        final iconY = (icon['positionY'] as num?)?.toDouble() ?? 0;
        const iconSize = 70.0;
        final iconCenterX = iconX + iconSize / 2;
        final iconCenterY = iconY + iconSize / 2;

        // Check if start point is near this icon (within 100 pixels of center)
        final distFromStart = _distance(
          startX,
          startY,
          iconCenterX,
          iconCenterY,
        );
        if (distFromStart < 100) {
          fromIconName = icon['name'] as String?;
        }

        // Check if end point is near this icon
        final distFromEnd = _distance(endX, endY, iconCenterX, iconCenterY);
        if (distFromEnd < 100) {
          toIconName = icon['name'] as String?;
        }
      }

      if (fromIconName != null &&
          toIconName != null &&
          fromIconName != toIconName) {
        connections.add(
          IconConnection(fromIcon: fromIconName, toIcon: toIconName),
        );
      }
    }

    return connections;
  }

  static double _distance(double x1, double y1, double x2, double y2) {
    final dx = x2 - x1;
    final dy = y2 - y1;
    return (dx * dx + dy * dy).abs();
  }

  /// Compare user's design with a single demo design
  static DesignComparisonResult compareWithDemo(
    List<dynamic> userIcons,
    List<dynamic> userLines,
    Map<String, dynamic> demoDesign,
  ) {
    final demoConnections = extractDemoConnections(demoDesign);
    final userConnections = extractUserConnections(userIcons, userLines);
    final demoIconNames = extractDemoIcons(demoDesign);
    final userIconNames =
        userIcons
            .map((icon) => (icon as Map<String, dynamic>)['name'] as String)
            .toList();

    // Find matching connections
    final matchingConnections = <IconConnection>[];
    for (final userConn in userConnections) {
      if (demoConnections.contains(userConn)) {
        matchingConnections.add(userConn);
      }
    }

    // Find missing connections (in demo but not in user's design)
    final missingConnections = <IconConnection>[];
    for (final demoConn in demoConnections) {
      if (!userConnections.contains(demoConn)) {
        missingConnections.add(demoConn);
      }
    }

    // Find extra connections (user has but demo doesn't)
    final extraConnections = <IconConnection>[];
    for (final userConn in userConnections) {
      if (!demoConnections.contains(userConn)) {
        extraConnections.add(userConn);
      }
    }

    // Find missing icons
    final missingIcons = <String>[];
    for (final demoIcon in demoIconNames) {
      final hasIcon = userIconNames.any(
        (name) => name.toLowerCase() == demoIcon.toLowerCase(),
      );
      if (!hasIcon) {
        missingIcons.add(demoIcon);
      }
    }

    // Calculate match percentage
    final totalDemoConnections = demoConnections.length;
    final matchPercentage =
        totalDemoConnections > 0
            ? (matchingConnections.length / totalDemoConnections) * 100
            : 0.0;

    return DesignComparisonResult(
      demoName: demoDesign['name'] as String? ?? 'Unknown',
      demoDescription: demoDesign['description'] as String? ?? '',
      demoConnections: demoConnections,
      userConnections: userConnections,
      matchingConnections: matchingConnections,
      missingConnections: missingConnections,
      extraConnections: extraConnections,
      missingIcons: missingIcons,
      matchPercentage: matchPercentage,
    );
  }

  /// Compare user's design with ALL demo designs of a system type
  static List<DesignComparisonResult> compareWithAllDemos(
    SystemType systemType,
    List<dynamic> userIcons,
    List<dynamic> userLines,
  ) {
    final demoDesigns = getDemoDesigns(systemType);
    final results = <DesignComparisonResult>[];

    for (final demo in demoDesigns) {
      results.add(compareWithDemo(userIcons, userLines, demo));
    }

    // Sort by match percentage (highest first)
    results.sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));

    return results;
  }
}

// ==========================================
// UI WIDGET: Design Comparison Dialog
// ==========================================

class DesignComparisonDialog extends StatelessWidget {
  final SystemType systemType;
  final List<dynamic> userIcons;
  final List<dynamic> userLines;

  const DesignComparisonDialog({
    super.key,
    required this.systemType,
    required this.userIcons,
    required this.userLines,
  });

  @override
  Widget build(BuildContext context) {
    final results = DesignComparisonService.compareWithAllDemos(
      systemType,
      userIcons,
      userLines,
    );

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.compare_arrows,
                  color: Colors.cyanAccent,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Design Comparison',
                    style: GoogleFonts.saira(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Compare your design with ${results.length} demo architectures',
              style: GoogleFonts.saira(fontSize: 14, color: Colors.white60),
            ),
            const Divider(color: Colors.white24, height: 24),

            // Results list
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return _buildComparisonCard(context, result, index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard(
    BuildContext context,
    DesignComparisonResult result,
    int designNumber,
  ) {
    final Color cardColor;
    final IconData statusIcon;

    if (result.matchPercentage >= 80) {
      cardColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (result.matchPercentage >= 50) {
      cardColor = Colors.orange;
      statusIcon = Icons.warning_amber;
    } else {
      cardColor = Colors.red;
      statusIcon = Icons.error_outline;
    }

    return Card(
      color: const Color(0xFF2A2A40),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cardColor.withOpacity(0.5), width: 1),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: cardColor.withOpacity(0.2),
          child: Icon(statusIcon, color: cardColor, size: 24),
        ),
        title: Text(
          '$designNumber. ${result.demoName}',
          style: GoogleFonts.saira(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.demoDescription,
              style: GoogleFonts.saira(fontSize: 12, color: Colors.white60),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatChip(
                  '${result.matchPercentage.toStringAsFixed(0)}%',
                  cardColor,
                ),
                const SizedBox(width: 8),
                _buildStatChip(
                  '${result.matchingConnections.length}/${result.demoConnections.length} connections',
                  Colors.blueGrey,
                ),
              ],
            ),
          ],
        ),
        iconColor: Colors.white70,
        collapsedIconColor: Colors.white70,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Matching connections (green)
                if (result.matchingConnections.isNotEmpty) ...[
                  _buildConnectionSection(
                    '✅ Matching Connections (${result.matchingConnections.length})',
                    result.matchingConnections,
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                ],

                // Missing connections (red) - MOST IMPORTANT
                if (result.missingConnections.isNotEmpty) ...[
                  _buildConnectionSection(
                    '❌ Missing Connections (${result.missingConnections.length})',
                    result.missingConnections,
                    Colors.red,
                  ),
                  const SizedBox(height: 12),
                ],

                // Extra connections user has (yellow)
                if (result.extraConnections.isNotEmpty) ...[
                  _buildConnectionSection(
                    '➕ Extra Connections (${result.extraConnections.length})',
                    result.extraConnections,
                    Colors.amber,
                  ),
                  const SizedBox(height: 12),
                ],

                // Missing icons (orange)
                if (result.missingIcons.isNotEmpty) ...[
                  _buildIconsSection(
                    '⚠️ Missing Icons (${result.missingIcons.length})',
                    result.missingIcons,
                    Colors.orange,
                  ),
                ],

                // Perfect match message
                if (result.missingConnections.isEmpty &&
                    result.missingIcons.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.celebration, color: Colors.green),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Perfect match! Your design includes all components of this architecture.',
                            style: GoogleFonts.saira(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(text, style: GoogleFonts.saira(fontSize: 11, color: color)),
    );
  }

  Widget _buildConnectionSection(
    String title,
    List<IconConnection> connections,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.saira(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              connections.map((conn) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        conn.fromIcon,
                        style: GoogleFonts.saira(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: color,
                        ),
                      ),
                      Text(
                        conn.toIcon,
                        style: GoogleFonts.saira(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      if (conn.label != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          '(${conn.label})',
                          style: GoogleFonts.saira(
                            fontSize: 10,
                            color: Colors.white54,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildIconsSection(String title, List<String> icons, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.saira(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              icons.map((iconName) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.4)),
                  ),
                  child: Text(
                    iconName,
                    style: GoogleFonts.saira(fontSize: 11, color: Colors.white),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

// ==========================================
// Helper function to show comparison dialog
// ==========================================

void showDesignComparisonDialog({
  required BuildContext context,
  required String systemName,
  required List<dynamic> userIcons,
  required List<dynamic> userLines,
}) {
  final systemType = DesignComparisonService.getSystemTypeFromName(systemName);

  if (systemType == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cannot compare: Unknown system type "$systemName"',
          style: GoogleFonts.saira(),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  showDialog(
    context: context,
    builder:
        (context) => DesignComparisonDialog(
          systemType: systemType,
          userIcons: userIcons,
          userLines: userLines,
        ),
  );
}
