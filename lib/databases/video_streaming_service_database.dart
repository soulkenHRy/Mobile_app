// Video Streaming Service System - Dedicated Database
// Stores all user notes specifically for Video Streaming Service system design

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VideoStreamingServiceDatabase {
  static const String _storageKey = 'video_streaming_service_notes';
  static const String _metadataKey = 'video_streaming_service_metadata';

  // Save user notes for Video Streaming Service system
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
        'systemName': 'Video Streaming Service',
      };

      await prefs.setString(_storageKey, jsonEncode(noteData));
      await _updateMetadata(noteData);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Load user notes for Video Streaming Service system
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

  // Get metadata for Video Streaming Service notes
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

  // Clear all Video Streaming Service notes
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
      'systemName': 'Video Streaming Service',
    };

    await prefs.setString(_metadataKey, jsonEncode(metadata));
  }
}
