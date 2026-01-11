// Live Streaming Platform System - Dedicated Database
// Stores all user notes specifically for Live Streaming Platform system design

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LiveStreamingPlatformDatabase {
  static const String _storageKey = 'live_streaming_platform_notes';
  static const String _metadataKey = 'live_streaming_platform_metadata';

  // Save user notes for Live Streaming Platform system
  static Future<bool> saveNotes(String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final noteData = {
        'content': content,
        'lastModified': DateTime.now().toIso8601String(),
        'wordCount':
            content
                .split(RegExp(r'\s+'))
                .where((word) => word.isNotEmpty)
                .length,
        'characterCount': content.length,
        'systemName': 'Live Streaming Platform',
      };

      await prefs.setString(_storageKey, jsonEncode(noteData));
      await _updateMetadata(noteData);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Load user notes for Live Streaming Platform system
  static Future<String?> loadNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final noteJson = prefs.getString(_storageKey);

      if (noteJson != null) {
        final noteData = jsonDecode(noteJson);
        return noteData['content'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Get metadata for Live Streaming Platform notes
  static Future<Map<String, dynamic>?> getMetadata() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metadataJson = prefs.getString(_metadataKey);

      if (metadataJson != null) {
        return jsonDecode(metadataJson);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Clear all Live Streaming Platform notes
  static Future<bool> clearNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      await prefs.remove(_metadataKey);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> _updateMetadata(Map<String, dynamic> noteData) async {
    final prefs = await SharedPreferences.getInstance();
    final metadata = {
      'lastUpdate': DateTime.now().toIso8601String(),
      'wordCount': noteData['wordCount'],
      'characterCount': noteData['characterCount'],
      'systemName': 'Live Streaming Platform',
    };

    await prefs.setString(_metadataKey, jsonEncode(metadata));
  }
}
