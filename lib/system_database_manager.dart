// System Database Manager - Routes to specific system databases
// Manages all 9 unique databases based on system name

import 'databases/url_shortener_database.dart';
import 'databases/pastebin_service_database.dart';
import 'databases/web_crawler_database.dart';
import 'databases/social_media_news_feed_database.dart';
import 'databases/video_streaming_service_database.dart';
import 'databases/ride_sharing_service_database.dart';
import 'databases/collaborative_editor_database.dart';
import 'databases/live_streaming_platform_database.dart';
import 'databases/global_gaming_leaderboard_database.dart';

class SystemDatabaseManager {
  // =================================================================
  // SYSTEM-SPECIFIC DATABASE ROUTING
  // =================================================================

  // Save user notes to the specific system database
  static Future<bool> saveNotesToSpecificDatabase(
    String systemName,
    String content,
  ) async {
    switch (systemName) {
      case 'URL Shortener':
      case 'URL Shortener (e.g., TinyURL)':
        return await URLShortenerDatabase.saveNotes(content);

      case 'Pastebin Service':
      case 'Pastebin Service (e.g., Pastebin.com)':
        return await PastebinServiceDatabase.saveNotes(content);

      case 'Web Crawler':
        return await WebCrawlerDatabase.saveNotes(content);

      case 'Social Media News Feed':
      case 'Social Media News Feed (e.g., Facebook, X/Twitter)':
        return await SocialMediaNewsFeedDatabase.saveNotes(content);

      case 'Video Streaming Service':
      case 'Video Streaming Service (e.g., Netflix, YouTube)':
        return await VideoStreamingServiceDatabase.saveNotes(content);

      case 'Ride-Sharing Service':
      case 'Ride-Sharing Service (e.g., Uber, Lyft)':
        return await RideSharingServiceDatabase.saveNotes(content);

      case 'Collaborative Editor':
      case 'Collaborative Editor (e.g., Google Docs, Figma)':
        return await CollaborativeEditorDatabase.saveNotes(content);

      case 'Live Streaming Platform':
      case 'Live Streaming Platform (e.g., Twitch, YouTube Live)':
        return await LiveStreamingPlatformDatabase.saveNotes(content);

      case 'Global Gaming Leaderboard':
        return await GlobalGamingLeaderboardDatabase.saveNotes(content);

      default:
        return false;
    }
  }

  // Load user notes from the specific system database
  static Future<String?> loadNotesFromSpecificDatabase(
    String systemName,
  ) async {
    switch (systemName) {
      case 'URL Shortener':
      case 'URL Shortener (e.g., TinyURL)':
        return await URLShortenerDatabase.loadNotes();

      case 'Pastebin Service':
      case 'Pastebin Service (e.g., Pastebin.com)':
        return await PastebinServiceDatabase.loadNotes();

      case 'Web Crawler':
        return await WebCrawlerDatabase.loadNotes();

      case 'Social Media News Feed':
      case 'Social Media News Feed (e.g., Facebook, X/Twitter)':
        return await SocialMediaNewsFeedDatabase.loadNotes();

      case 'Video Streaming Service':
      case 'Video Streaming Service (e.g., Netflix, YouTube)':
        return await VideoStreamingServiceDatabase.loadNotes();

      case 'Ride-Sharing Service':
      case 'Ride-Sharing Service (e.g., Uber, Lyft)':
        return await RideSharingServiceDatabase.loadNotes();

      case 'Collaborative Editor':
      case 'Collaborative Editor (e.g., Google Docs, Figma)':
        return await CollaborativeEditorDatabase.loadNotes();

      case 'Live Streaming Platform':
      case 'Live Streaming Platform (e.g., Twitch, YouTube Live)':
        return await LiveStreamingPlatformDatabase.loadNotes();

      case 'Global Gaming Leaderboard':
        return await GlobalGamingLeaderboardDatabase.loadNotes();

      default:
        return null;
    }
  }

  // Get metadata from the specific system database
  static Future<Map<String, dynamic>?> getMetadataFromSpecificDatabase(
    String systemName,
  ) async {
    switch (systemName) {
      case 'URL Shortener':
      case 'URL Shortener (e.g., TinyURL)':
        return await URLShortenerDatabase.getMetadata();

      case 'Pastebin Service':
      case 'Pastebin Service (e.g., Pastebin.com)':
        return await PastebinServiceDatabase.getMetadata();

      case 'Web Crawler':
        return await WebCrawlerDatabase.getMetadata();

      case 'Social Media News Feed':
      case 'Social Media News Feed (e.g., Facebook, X/Twitter)':
        return await SocialMediaNewsFeedDatabase.getMetadata();

      case 'Video Streaming Service':
      case 'Video Streaming Service (e.g., Netflix, YouTube)':
        return await VideoStreamingServiceDatabase.getMetadata();

      case 'Ride-Sharing Service':
      case 'Ride-Sharing Service (e.g., Uber, Lyft)':
        return await RideSharingServiceDatabase.getMetadata();

      case 'Collaborative Editor':
      case 'Collaborative Editor (e.g., Google Docs, Figma)':
        return await CollaborativeEditorDatabase.getMetadata();

      case 'Live Streaming Platform':
      case 'Live Streaming Platform (e.g., Twitch, YouTube Live)':
        return await LiveStreamingPlatformDatabase.getMetadata();

      case 'Global Gaming Leaderboard':
        return await GlobalGamingLeaderboardDatabase.getMetadata();

      default:
        return null;
    }
  }

  // Clear notes from the specific system database
  static Future<bool> clearNotesFromSpecificDatabase(String systemName) async {
    switch (systemName) {
      case 'URL Shortener':
      case 'URL Shortener (e.g., TinyURL)':
        return await URLShortenerDatabase.clearNotes();

      case 'Pastebin Service':
      case 'Pastebin Service (e.g., Pastebin.com)':
        return await PastebinServiceDatabase.clearNotes();

      case 'Web Crawler':
        return await WebCrawlerDatabase.clearNotes();

      case 'Social Media News Feed':
      case 'Social Media News Feed (e.g., Facebook, X/Twitter)':
        return await SocialMediaNewsFeedDatabase.clearNotes();

      case 'Video Streaming Service':
      case 'Video Streaming Service (e.g., Netflix, YouTube)':
        return await VideoStreamingServiceDatabase.clearNotes();

      case 'Ride-Sharing Service':
      case 'Ride-Sharing Service (e.g., Uber, Lyft)':
        return await RideSharingServiceDatabase.clearNotes();

      case 'Collaborative Editor':
      case 'Collaborative Editor (e.g., Google Docs, Figma)':
        return await CollaborativeEditorDatabase.clearNotes();

      case 'Live Streaming Platform':
      case 'Live Streaming Platform (e.g., Twitch, YouTube Live)':
        return await LiveStreamingPlatformDatabase.clearNotes();

      case 'Global Gaming Leaderboard':
        return await GlobalGamingLeaderboardDatabase.clearNotes();

      default:
        return false;
    }
  }

  // =================================================================
  // UTILITY METHODS
  // =================================================================

  // Get all system names
  static List<String> getAllSystemNames() {
    return [
      'URL Shortener',
      'Pastebin Service',
      'Web Crawler',
      'Social Media News Feed',
      'Video Streaming Service',
      'Ride-Sharing Service',
      'Collaborative Editor',
      'Live Streaming Platform',
      'Global Gaming Leaderboard',
    ];
  }

  // Get all system databases status
  static Future<Map<String, Map<String, dynamic>>> getAllSystemsStatus() async {
    final status = <String, Map<String, dynamic>>{};

    for (final systemName in getAllSystemNames()) {
      final notes = await loadNotesFromSpecificDatabase(systemName);
      final metadata = await getMetadataFromSpecificDatabase(systemName);

      status[systemName] = {
        'hasNotes': notes != null && notes.isNotEmpty,
        'wordCount': metadata?['wordCount'] ?? 0,
        'characterCount': metadata?['characterCount'] ?? 0,
        'lastUpdate': metadata?['lastUpdate'],
      };
    }

    return status;
  }

  // Database mapping for easy reference
  static Map<String, String> getDatabaseKeyMapping() {
    return {
      'URL Shortener': 'url_shortener_notes',
      'Pastebin Service': 'pastebin_service_notes',
      'Web Crawler': 'web_crawler_notes',
      'Social Media News Feed': 'social_media_news_feed_notes',
      'Video Streaming Service': 'video_streaming_service_notes',
      'Ride-Sharing Service': 'ride_sharing_service_notes',
      'Collaborative Editor': 'collaborative_editor_notes',
      'Live Streaming Platform': 'live_streaming_platform_notes',
      'Global Gaming Leaderboard': 'global_gaming_leaderboard_notes',
    };
  }
}
