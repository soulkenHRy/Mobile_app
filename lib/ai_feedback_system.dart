// AI Feedback System - Parallel Database Comparison
// Compares user notes from specific databases with corresponding reference databases
// Provides AI-powered feedback based on parallel matching (1st with 1st, 2nd with 2nd, etc.)

import 'system_database_manager.dart';
import 'system_design_reference_database.dart';

class AIFeedbackSystem {
  // =================================================================
  // PARALLEL DATABASE MAPPING (Using Index-Based Matching)
  // =================================================================

  // System order matches the database creation order (1st, 2nd, 3rd, etc.)
  static const List<String> _systemOrder = [
    'URL Shortener (e.g., TinyURL)', // Index 0 - urlShortenerNotes
    'Pastebin Service (e.g., Pastebin.com)', // Index 1 - pastebinServiceNotes
    'Web Crawler', // Index 2 - webCrawlerNotes
    'Social Media News Feed (e.g., Facebook, X/Twitter)', // Index 3 - socialMediaNewsFeedNotes
    'Video Streaming Service (e.g., Netflix, YouTube)', // Index 4 - videoStreamingServiceNotes
    'Ride-Sharing Service (e.g., Uber, Lyft)', // Index 5 - rideSharingServiceNotes
    'Collaborative Editor (e.g., Google Docs, Figma)', // Index 6 - collaborativeEditorNotes
    'Live Streaming Platform (e.g., Twitch, YouTube Live)', // Index 7 - liveStreamingPlatformNotes
    'Global Gaming Leaderboard', // Index 8 - globalGamingLeaderboardNotes
  ];

  // Reference notes in the exact same order as system order
  static const List<String> _referenceNotesOrder = [
    'urlShortenerNotes', // Index 0
    'pastebinServiceNotes', // Index 1
    'webCrawlerNotes', // Index 2
    'socialMediaNewsFeedNotes', // Index 3
    'videoStreamingServiceNotes', // Index 4
    'rideSharingServiceNotes', // Index 5
    'collaborativeEditorNotes', // Index 6
    'liveStreamingPlatformNotes', // Index 7
    'globalGamingLeaderboardNotes', // Index 8
  ];

  // =================================================================
  // AI COMPARISON AND FEEDBACK GENERATION
  // =================================================================

  // Compare user notes with corresponding reference database and generate AI feedback
  static Future<AIFeedbackResult> generateFeedbackForSystem(
    String systemName, {
    List<String>? canvasComponents, // Optional: components from canvas
  }) async {
    try {
      // Get user notes from specific database
      final userNotes =
          await SystemDatabaseManager.loadNotesFromSpecificDatabase(systemName);

      if (userNotes == null || userNotes.isEmpty) {
        return AIFeedbackResult(
          systemName: systemName,
          score: 0,
          feedback:
              'No user notes found for $systemName. Please write your system design notes first.',
          hasUserNotes: false,
          comparisonDetails: {},
        );
      }

      // Get corresponding reference notes
      final referenceNotes = _getReferenceNotesForSystem(systemName);

      if (referenceNotes == null) {
        return AIFeedbackResult(
          systemName: systemName,
          score: 0,
          feedback:
              'Reference database not found for $systemName. Please contact support.',
          hasUserNotes: true,
          comparisonDetails: {},
        );
      }

      // Perform detailed comparison
      final comparisonResult = _compareNotesWithReference(
        userNotes,
        referenceNotes,
        systemName,
        canvasComponents: canvasComponents,
      );

      return comparisonResult;
    } catch (e) {
      return AIFeedbackResult(
        systemName: systemName,
        score: 0,
        feedback: 'Error occurred during analysis: $e\nPlease try again.',
        hasUserNotes: false,
        comparisonDetails: {},
      );
    }
  }

  // Get reference notes using direct indexing (no name matching needed)
  static String? _getReferenceNotesForSystem(String systemName) {
    // Find the index of the system in our ordered list
    final systemIndex = _systemOrder.indexOf(systemName);

    if (systemIndex == -1) {
      return null;
    }

    // Use the same index to get reference notes (parallel indexing)
    String? referenceNotes;
    switch (systemIndex) {
      case 0:
        referenceNotes = SystemDesignReferenceDatabase.urlShortenerNotes;
        break;
      case 1:
        referenceNotes = SystemDesignReferenceDatabase.pastebinServiceNotes;
        break;
      case 2:
        referenceNotes = SystemDesignReferenceDatabase.webCrawlerNotes;
        break;
      case 3:
        referenceNotes = SystemDesignReferenceDatabase.socialMediaNewsFeedNotes;
        break;
      case 4:
        referenceNotes =
            SystemDesignReferenceDatabase.videoStreamingServiceNotes;
        break;
      case 5:
        referenceNotes = SystemDesignReferenceDatabase.rideSharingServiceNotes;
        break;
      case 6:
        referenceNotes = SystemDesignReferenceDatabase.collaborativeEditorNotes;
        break;
      case 7:
        referenceNotes =
            SystemDesignReferenceDatabase.liveStreamingPlatformNotes;
        break;
      case 8:
        referenceNotes =
            SystemDesignReferenceDatabase.globalGamingLeaderboardNotes;
        break;
      default:
        return null;
    }

    return referenceNotes;
  }

  // Detailed comparison between user notes and reference notes
  static AIFeedbackResult _compareNotesWithReference(
    String userNotes,
    String referenceNotes,
    String systemName, {
    List<String>? canvasComponents,
  }) {
    final userNotesLower = userNotes.toLowerCase();
    final referenceNotesLower = referenceNotes.toLowerCase();

    // Extract key components from reference notes
    final referenceComponents = _extractKeyComponents(referenceNotesLower);

    // Calculate component coverage
    final componentsCovered = <String, bool>{};
    final componentsDetails = <String, String>{};
    int componentsFound = 0;

    for (final component in referenceComponents) {
      final componentLower = component.toLowerCase().trim();
      final isFound = userNotesLower.contains(componentLower);
      componentsCovered[component] = isFound;

      if (isFound) {
        componentsFound++;
        componentsDetails[component] = '✅ Found: $component';
      } else {
        componentsDetails[component] = '❌ Missing: $component';
      }
    }

    // Calculate score based on component coverage
    final componentScore =
        referenceComponents.isEmpty
            ? 0
            : ((componentsFound / referenceComponents.length) * 100).round();

    // Analyze architectural patterns
    final architectureScore = _analyzeArchitecturalPatterns(
      userNotesLower,
      referenceNotesLower,
    );

    // Analyze system-specific features
    final featuresScore = _analyzeSystemFeatures(
      userNotesLower,
      referenceNotesLower,
      systemName,
    );

    // NEW: Analyze canvas-to-notes consistency
    Map<String, dynamic> canvasConsistency = {};
    int consistencyScore = 100; // Default to 100 if no canvas data

    if (canvasComponents != null && canvasComponents.isNotEmpty) {
      canvasConsistency = _analyzeCanvasConsistency(
        userNotes,
        canvasComponents,
        systemName,
      );
      consistencyScore = canvasConsistency['score'] ?? 100;
    } else if (canvasComponents != null && canvasComponents.isEmpty) {
      // Canvas exists but empty - severe penalty
      consistencyScore = 0;
      canvasConsistency = {
        'score': 0,
        'matched': <String>[],
        'unmatched': <String>[],
        'mentionedButNotDrawn': <String>[],
        'canvasComponentCount': 0,
        'minRequired': 5,
        'suggestions':
            '⚠️ No components on canvas! Draw your system design before submitting.',
      };
    }

    // Calculate final score (weighted average)
    // Canvas consistency is critical - 30% weight when canvas provided
    final finalScore =
        canvasComponents != null
            ? ((componentScore * 0.35) +
                    (architectureScore * 0.20) +
                    (featuresScore * 0.15) +
                    (consistencyScore * 0.30))
                .round()
            : ((componentScore * 0.5) +
                    (architectureScore * 0.3) +
                    (featuresScore * 0.2))
                .round();

    // Generate detailed feedback
    final feedback = _generateDetailedFeedback(
      systemName,
      componentScore,
      architectureScore,
      featuresScore,
      finalScore,
      componentsDetails,
      userNotes.split(RegExp(r'\s+')).length,
      canvasConsistency,
    );

    return AIFeedbackResult(
      systemName: systemName,
      score: finalScore,
      feedback: feedback,
      hasUserNotes: true,
      comparisonDetails: {
        'componentScore': componentScore,
        'architectureScore': architectureScore,
        'featuresScore': featuresScore,
        'consistencyScore': consistencyScore,
        'componentsFound': componentsFound,
        'totalComponents': referenceComponents.length,
        'componentsCovered': componentsCovered,
        'wordCount': userNotes.split(RegExp(r'\s+')).length,
        'canvasConsistency': canvasConsistency,
      },
    );
  }

  // Extract key components from notes - enhanced with demo patterns
  static List<String> _extractKeyComponents(String notes) {
    final components = <String>[];

    // Comprehensive system design components from all 90 demos
    final patterns = [
      // Infrastructure
      'load balancer',
      'global load balancer',
      'application server',
      'web server',
      'api gateway', 'cdn', 'dns', 'dns server', 'firewall', 'waf',
      // Databases
      'database', 'sql database', 'nosql database', 'postgresql', 'mysql',
      'mongodb', 'cassandra', 'dynamodb', 'key-value store', 'document store',
      'graph database', 'time series database', 'data warehouse',
      // Caching
      'cache', 'redis', 'redis cache', 'redis cluster', 'memcached',
      'in-memory cache', 'cdn cache', 'browser cache', 'edge cache',
      // Messaging
      'message queue', 'kafka', 'rabbitmq', 'sqs', 'pub/sub', 'event bus',
      // Search
      'elasticsearch', 'search index', 'full-text search', 'autocomplete',
      // Processing
      'stream processor', 'batch processor', 'transcoding cluster',
      'analytics engine', 'ml pipeline', 'recommendation engine',
      // Services
      'microservice', 'service mesh', 'api', 'rest api', 'graphql',
      // Storage
      'object storage', 's3', 'blob storage', 'file storage',
      // Real-time
      'websocket', 'websocket gateway', 'rtmp', 'webrtc', 'sfu',
      // Monitoring
      'monitoring', 'logging', 'metrics', 'alerting', 'tracing',
      'prometheus', 'grafana', 'datadog',
      // Security
      'authentication', 'authorization', 'oauth', 'jwt', 'rate limiter',
      // Cloud
      'aws', 'gcp', 'azure', 'kubernetes', 'docker', 'container',
      // Specialized
      'bloom filter', 'sorted set', 'geo index', 'h3', 'geospatial',
      'ot engine', 'crdt', 'sync service', 'presence service',
    ];

    for (final pattern in patterns) {
      final patternLower = pattern.toLowerCase().trim();
      final notesLower = notes.toLowerCase();

      if (notesLower.contains(patternLower)) {
        components.add(pattern);
      }
    }

    return components;
  }

  // Enhanced architectural patterns from all demo explanations
  static const List<String> _enhancedArchitecturalPatterns = [
    // Core patterns
    'microservices', 'monolith', 'event-driven', 'rest', 'graphql',
    'pub/sub', 'request-response', 'caching', 'sharding', 'replication',
    // Scaling patterns
    'horizontal scaling', 'vertical scaling', 'load balancing',
    'auto-scaling', 'elastic scaling', 'scale out', 'scale up',
    // Data patterns
    'database sharding', 'consistent hashing', 'partitioning',
    'read replica', 'write-through', 'write-behind', 'cache-aside',
    // Messaging patterns
    'message queue', 'event sourcing', 'cqrs', 'saga pattern',
    'publish-subscribe', 'fan-out', 'fan-in',
    // Reliability patterns
    'circuit breaker', 'retry', 'timeout', 'bulkhead',
    'fallback', 'health check', 'heartbeat',
    // Availability patterns
    'active-active', 'active-passive', 'failover', 'failback',
    'disaster recovery', 'backup', 'multi-region', 'geo-redundant',
    // Performance patterns
    'cdn', 'edge computing', 'lazy loading', 'prefetching',
    'connection pooling', 'batch processing', 'stream processing',
    // Security patterns
    'authentication', 'authorization', 'oauth', 'jwt', 'api key',
    'rate limiting', 'throttling', 'encryption', 'tls', 'mtls',
    // Real-time patterns
    'websocket', 'server-sent events', 'long polling', 'push notification',
    // Data processing patterns
    'etl', 'data pipeline', 'lambda architecture', 'kappa architecture',
  ];

  // Analyze architectural patterns with enhanced detection
  static int _analyzeArchitecturalPatterns(
    String userNotes,
    String referenceNotes,
  ) {
    int patternsFound = 0;
    int totalRelevantPatterns = 0;
    final userNotesLower = userNotes.toLowerCase();
    final referenceNotesLower = referenceNotes.toLowerCase();

    for (final pattern in _enhancedArchitecturalPatterns) {
      final patternLower = pattern.toLowerCase().trim();

      // Check if this pattern is relevant for this system (appears in reference)
      if (referenceNotesLower.contains(patternLower)) {
        totalRelevantPatterns++;
        if (userNotesLower.contains(patternLower)) {
          patternsFound++;
        }
      }
    }

    // Also check for patterns user mentions even if not in reference
    // This rewards users who go beyond the reference
    int bonusPatterns = 0;
    for (final pattern in _enhancedArchitecturalPatterns) {
      final patternLower = pattern.toLowerCase().trim();
      if (userNotesLower.contains(patternLower) &&
          !referenceNotesLower.contains(patternLower)) {
        bonusPatterns++;
      }
    }

    // Calculate base score from matching reference patterns
    int baseScore =
        totalRelevantPatterns == 0
            ? 0
            : ((patternsFound / totalRelevantPatterns) * 100).round();

    // Add bonus for extra patterns (up to 20 bonus points)
    int bonusScore = (bonusPatterns * 5).clamp(0, 20);

    return (baseScore + bonusScore).clamp(0, 100);
  }

  // =================================================================
  // ENHANCED PATTERN RECOGNITION FROM DEMO EXPLANATIONS
  // Extracted from 90 demos (10 per system) for comprehensive matching
  // =================================================================

  // URL Shortener patterns from 10 demo explanations
  static const List<String> _urlShortenerPatterns = [
    // Basic Architecture patterns
    'short code', 'short url', 'base62', 'unique id', 'url mapping',
    'redirect', '301', '302', 'http redirect', 'original url',
    // Scalable Architecture patterns
    'horizontal scaling', 'server cluster', 'consistent hashing',
    'database sharding', 'short code prefix', 'geographic routing',
    // Caching patterns
    'cache-aside', 'write-through', 'read-through', 'cache hierarchy',
    'browser cache', 'edge cache', 'cdn cache', 'cache invalidation',
    'cache miss', 'cache hit', 'ttl', 'lru eviction',
    // Analytics patterns
    'click tracking', 'click event', 'stream processor', 'analytics engine',
    'time series database', 'data warehouse', 'geo-ip', 'device detection',
    'click velocity', 'unique visitors', 'returning visitors',
    // Microservices patterns
    'url generator', 'url resolver', 'service mesh', 'istio', 'linkerd',
    'mtls', 'database-per-service', 'configuration service',
    // High Availability patterns
    'multi-region', 'failover', 'replication', 'cross-region',
    'active-active', 'active-passive', 'health check', 'geo dns',
    'backup service', 'point-in-time recovery',
    // Security patterns
    'rate limiter', 'token bucket', 'sliding window', 'firewall', 'waf',
    'fraud detection', 'security scanner', 'malware detection',
    'phishing detection', 'safe browsing', 'authentication', 'authorization',
    // ID Generation patterns
    'snowflake', 'uuid', 'counter', 'hashid', 'base62 encoding',
    'collision', 'url enumeration',
  ];

  // Pastebin patterns from 10 demo explanations
  static const List<String> _pastebinPatterns = [
    // Basic patterns
    'paste', 'text snippet', 'unique url', 'expiration', 'created_at',
    'expires_at', 'cleanup job', 'reclaim storage',
    // Scalability patterns
    'cache warmer', 'cold start', 'viral paste', 'cache hit rate',
    // Content Moderation patterns
    'content moderation', 'malware scanner', 'pii detector', 'url scanner',
    'review queue', 'ban service', 'risk score', 'auto-approve',
    'auto-reject', 'human review', 'false positive',
    // Syntax Highlighting patterns
    'syntax highlighting', 'language detector', 'tokenizer', 'highlighter',
    'theme engine', 'line numberer', 'token type', 'keyword', 'string',
    'comment', 'identifier',
    // Privacy patterns
    'password protection', 'end-to-end encryption', 'encrypted paste',
    'bcrypt', 'url fragment', 'burn after reading', 'one-time view',
    'client-side encryption', 'decryption key',
    // Storage patterns
    'compression', 'storage calculation', 'blob storage',
    // Access patterns
    'unlisted', 'public', 'private', 'shareable url',
  ];

  // Web Crawler patterns from 10 demo explanations
  static const List<String> _webCrawlerPatterns = [
    // Basic patterns
    'seed url', 'url frontier', 'http fetcher', 'html parser',
    'link extraction', 'crawl loop', 'page content',
    // Distributed patterns
    'coordinator', 'crawler worker', 'url partitioner', 'bloom filter',
    'consistent hashing', 'hash partition', 'fault tolerance', 'checkpoint',
    'heartbeat', 'work reassignment',
    // Politeness patterns
    'robots.txt', 'robots parser', 'crawl delay', 'rate limiter',
    'request throttler', 'backoff', 'politeness', 'concurrent request',
    'user-agent', 'disallow', 'allow',
    // Frontier Management patterns
    'priority queue', 'front queue', 'back queue', 'host queue',
    'prioritizer', 'deduplicator', 'pagerank', 'domain authority',
    'freshness', 'update frequency',
    // Content Parsing patterns
    'boilerplate removal', 'main content extraction', 'structured data',
    'metadata extraction', 'dom parsing', 'xpath', 'css selector',
    // Storage patterns
    'content store', 'index', 'inverted index', 'document store',
    'deduplication', 'near-duplicate detection', 'simhash', 'minhash',
  ];

  // News Feed patterns from 10 demo explanations
  static const List<String> _newsFeedPatterns = [
    // Basic patterns
    'timeline', 'post', 'following', 'follower', 'chronological',
    'merge and sort', 'pagination', 'cursor-based',
    // Fan-out patterns
    'fan-out on write', 'fan-out on read', 'pre-compute', 'hybrid approach',
    'celebrity problem', 'push model', 'pull model',
    // Feed generation patterns
    'feed cache', 'feed service', 'follow graph', 'post store',
    'follower index', 'fan-out service',
    // Ranking patterns
    'ml ranking', 'relevance score', 'engagement prediction',
    'feature extraction', 'user profile', 'content-based',
    'collaborative filtering', 'personalized ranking', 'diversity',
    // Real-time patterns
    'real-time update', 'websocket', 'push notification',
    'activity stream', 'event feed',
    // Social patterns
    'like', 'comment', 'share', 'retweet', 'reaction',
    'social graph', 'friend', 'connection',
  ];

  // Video Streaming patterns from 10 demo explanations
  static const List<String> _videoStreamingPatterns = [
    // Basic patterns
    'vod', 'video on demand', 'manifest file', 'playlist', 'video chunk',
    'segment', 'pause', 'rewind', 'fast-forward',
    // Adaptive streaming patterns
    'adaptive bitrate', 'abr', 'hls', 'dash', 'bandwidth detection',
    'quality switching', '1080p', '720p', '480p', '4k', 'resolution',
    // Content ingestion patterns
    'upload service', 'transcoding', 'transcoder', 'encoding',
    'multiple quality', 'content ingestion', 'validation service',
    'qa service', 'master file', 'prores',
    // Personalization patterns
    'recommendation engine', 'personalization', 'watch history',
    'user signal', 'user profile', 'collaborative filtering',
    'content-based', 'a/b testing', 'thumbnail selection',
    // Search patterns
    'autocomplete', 'search index', 'elasticsearch', 'full-text search',
    'typo correction', 'personalized ranking',
    // Billing patterns
    'subscription', 'billing', 'payment gateway', 'recurring billing',
    'dunning', 'plan', 'premium', 'trial',
    // Delivery patterns
    'cdn', 'edge server', 'origin server', 'content delivery',
    'global distribution', 'caching', 'latency reduction',
  ];

  // Ride Sharing patterns from 10 demo explanations
  static const List<String> _rideSharingPatterns = [
    // Basic matching patterns
    'ride request', 'driver matching', 'nearby driver', 'pickup',
    'dropoff', 'gps', 'latitude', 'longitude', 'geospatial',
    'radius query', 'geoadd', 'georadius',
    // Location tracking patterns
    'real-time location', 'location gateway', 'location update',
    'stream processor', 'time series database', 'websocket',
    'live map', 'heading', 'speed',
    // Surge pricing patterns
    'surge pricing', 'dynamic pricing', 'supply and demand',
    'demand aggregator', 'supply tracker', 'hexagon', 'h3',
    'heat map', 'price multiplier', 'surge zone',
    // Payment patterns
    'fare calculation', 'base fare', 'per-mile', 'per-minute',
    'booking fee', 'promo code', 'tip', 'driver payout',
    'payment gateway', 'wallet', 'commission',
    // ETA patterns
    'eta', 'routing', 'navigation', 'traffic', 'route optimization',
    'shortest path', 'dijkstra', 'a-star', 'real-time traffic',
    // Driver patterns
    'driver app', 'rider app', 'accept ride', 'decline',
    'driver rating', 'rider rating', 'acceptance rate',
    // Safety patterns
    'sos', 'emergency', 'trip sharing', 'safety check',
  ];

  // Collaborative Editor patterns from 10 demo explanations
  static const List<String> _collaborativeEditorPatterns = [
    // Basic patterns
    'real-time editing', 'simultaneous editing', 'collaborative',
    'sync service', 'document store', 'change event',
    // OT patterns
    'operational transformation', 'ot', 'transform operation',
    'operation log', 'state machine', 'convergence',
    'concurrent edit', 'position adjustment',
    // CRDT patterns
    'crdt', 'conflict-free', 'replicated data type', 'unique id',
    'tombstone', 'peer-to-peer', 'vector clock', 'causal ordering',
    'merge', 'eventual consistency',
    // Presence patterns
    'presence', 'cursor', 'cursor position', 'cursor tracker',
    'who is online', 'heartbeat', 'away status', 'user color',
    'broadcast', 'presence service',
    // Version History patterns
    'version history', 'revision', 'snapshot', 'time travel',
    'undo', 'redo', 'restore', 'diff engine', 'attribution',
    // Permission patterns
    'sharing', 'permission', 'view', 'edit', 'comment', 'owner',
    'collaborator', 'access control',
    // WebSocket patterns
    'websocket', 'websocket gateway', 'persistent connection',
    'push update', 'real-time sync',
  ];

  // Live Streaming patterns from 10 demo explanations
  static const List<String> _liveStreamingPatterns = [
    // Basic patterns
    'broadcaster', 'streamer', 'viewer', 'live video', 'live stream',
    'rtmp', 'rtmp ingest', 'media server', 'obs',
    // Low latency patterns
    'webrtc', 'sfu', 'selective forwarding unit', 'edge server',
    'll-hls', 'low latency', 'sub-second latency',
    // Scalability patterns
    'ingest cluster', 'transcoding cluster', 'origin server',
    'multi-cdn', 'ingest router', 'global ingest',
    // Chat patterns
    'chat gateway', 'chat service', 'moderation service',
    'pub/sub', 'message broadcast', 'chat room', 'automod',
    'donation', 'tip', 'subscription alert',
    // Video processing patterns
    'transcoding', 'segmenter', 'thumbnail generator',
    'adaptive bitrate', 'quality ladder', 'bitrate',
    'h.264', 'hevc', 'av1', 'codec',
    // Discovery patterns
    'stream discovery', 'recommendation', 'category',
    'trending', 'live now', 'viewer count',
    // Monetization patterns
    'subscription', 'bits', 'donation', 'ad',
  ];

  // Gaming Leaderboard patterns from 10 demo explanations
  static const List<String> _gamingLeaderboardPatterns = [
    // Basic patterns
    'score', 'rank', 'ranking', 'top players', 'leaderboard',
    'sorted set', 'zadd', 'zrevrange', 'redis sorted set',
    // Scalability patterns
    'message queue', 'score aggregator', 'redis cluster',
    'leaderboard cache', 'sharding', 'horizontal scaling',
    // Real-time patterns
    'real-time update', 'websocket', 'connection manager',
    'change detection', 'pub/sub', 'push notification',
    // Segmented patterns
    'daily leaderboard', 'weekly leaderboard', 'monthly leaderboard',
    'all-time', 'regional leaderboard', 'segment manager',
    'segment rotation', 'data warehouse',
    // Competitive patterns
    'elo', 'mmr', 'rating', 'match result', 'win', 'lose',
    'tier system', 'promotion', 'demotion', 'bronze', 'silver',
    'gold', 'platinum', 'diamond', 'k-factor',
    // Anti-cheat patterns
    'anti-cheat', 'cheat detection', 'win-trading', 'suspicious activity',
    'validation', 'abnormal win rate',
    // Tournament patterns
    'tournament', 'bracket', 'elimination', 'championship',
    'prize pool', 'competitive match',
    // Friend patterns
    'friend leaderboard', 'social', 'nearby players',
    'relative rank', 'percentile',
  ];

  // Analyze system-specific features using enhanced patterns
  static int _analyzeSystemFeatures(
    String userNotes,
    String referenceNotes,
    String systemName,
  ) {
    // Get the appropriate pattern list based on system name
    List<String> patterns = _getSystemPatterns(systemName);

    if (patterns.isEmpty) {
      // Fallback to basic features if no patterns found
      return _analyzeBasicFeatures(userNotes, systemName);
    }

    int patternsFound = 0;
    final userNotesLower = userNotes.toLowerCase();

    for (final pattern in patterns) {
      final patternLower = pattern.toLowerCase().trim();
      if (userNotesLower.contains(patternLower)) {
        patternsFound++;
      }
    }

    // Calculate score based on patterns found
    // Expect at least 15% of patterns to be mentioned for a good score
    final expectedPatterns = (patterns.length * 0.15).ceil();
    final featuresScore = ((patternsFound / expectedPatterns) * 100)
        .round()
        .clamp(0, 100);

    return featuresScore;
  }

  // Get system-specific patterns
  static List<String> _getSystemPatterns(String systemName) {
    if (systemName.contains('URL Shortener')) {
      return _urlShortenerPatterns;
    } else if (systemName.contains('Pastebin')) {
      return _pastebinPatterns;
    } else if (systemName.contains('Web Crawler')) {
      return _webCrawlerPatterns;
    } else if (systemName.contains('Social Media') ||
        systemName.contains('News Feed')) {
      return _newsFeedPatterns;
    } else if (systemName.contains('Video Streaming')) {
      return _videoStreamingPatterns;
    } else if (systemName.contains('Ride-Sharing') ||
        systemName.contains('Ride Sharing')) {
      return _rideSharingPatterns;
    } else if (systemName.contains('Collaborative Editor')) {
      return _collaborativeEditorPatterns;
    } else if (systemName.contains('Live Streaming')) {
      return _liveStreamingPatterns;
    } else if (systemName.contains('Gaming Leaderboard') ||
        systemName.contains('Leaderboard')) {
      return _gamingLeaderboardPatterns;
    }
    return [];
  }

  // Fallback basic feature analysis
  static int _analyzeBasicFeatures(String userNotes, String systemName) {
    Map<String, List<String>> systemFeatures = {
      'URL Shortener (e.g., TinyURL)': [
        'redirect',
        'analytics',
        'click tracking',
        'expiration',
      ],
      'Pastebin Service (e.g., Pastebin.com)': [
        'paste',
        'expiration',
        'syntax highlighting',
        'privacy',
      ],
      'Web Crawler': ['crawling', 'indexing', 'robots.txt', 'politeness'],
      'Social Media News Feed (e.g., Facebook, X/Twitter)': [
        'timeline',
        'posts',
        'recommendations',
        'likes',
      ],
      'Video Streaming Service (e.g., Netflix, YouTube)': [
        'streaming',
        'transcoding',
        'adaptive bitrate',
        'cdn',
      ],
      'Ride-Sharing Service (e.g., Uber, Lyft)': [
        'geolocation',
        'matching',
        'routing',
        'pricing',
      ],
      'Collaborative Editor (e.g., Google Docs, Figma)': [
        'real-time',
        'operational transform',
        'conflict resolution',
      ],
      'Live Streaming Platform (e.g., Twitch, YouTube Live)': [
        'rtmp',
        'live',
        'chat',
        'broadcasting',
      ],
      'Global Gaming Leaderboard': [
        'ranking',
        'scores',
        'real-time updates',
        'competition',
      ],
    };

    final features = systemFeatures[systemName] ?? [];
    int featuresFound = 0;
    final userNotesLower = userNotes.toLowerCase();

    for (final feature in features) {
      if (userNotesLower.contains(feature.toLowerCase())) {
        featuresFound++;
      }
    }

    return features.isEmpty
        ? 0
        : ((featuresFound / features.length) * 100).round();
  }

  // Analyze consistency between canvas components and notes
  static Map<String, dynamic> _analyzeCanvasConsistency(
    String userNotes,
    List<String> canvasComponents,
    String systemName,
  ) {
    final userNotesLower = userNotes.toLowerCase();
    final matchedComponents = <String>[];
    final unmatchedComponents = <String>[];

    // Check each canvas component is mentioned in notes (case-insensitive)
    for (final component in canvasComponents) {
      final componentLower = component.toLowerCase();
      if (userNotesLower.contains(componentLower)) {
        matchedComponents.add(component);
      } else {
        unmatchedComponents.add(component);
      }
    }

    // Define minimum required components for a proper system design
    const int minRequiredComponents = 5;
    const int idealComponents = 8;
    final totalCanvasComponents = canvasComponents.length;

    // Check if notes mention important components NOT on canvas
    final expectedComponents = [
      'load balancer',
      'database',
      'cache',
      'api gateway',
      'server',
      'client',
      'cdn',
      'message queue',
      'microservice',
      'redis',
      'storage',
      'service',
    ];

    final mentionedButNotDrawn = <String>[];
    for (final expected in expectedComponents) {
      if (userNotesLower.contains(expected)) {
        // Check if this component type exists in canvas
        final isOnCanvas = canvasComponents.any(
          (c) =>
              c.toLowerCase().contains(expected) ||
              expected.contains(c.toLowerCase()),
        );
        if (!isOnCanvas) {
          mentionedButNotDrawn.add(expected);
        }
      }
    }

    // Calculate canvas completeness penalty
    int canvasCompletenessPenalty = 0;
    String completenessMessage = '';

    if (totalCanvasComponents < minRequiredComponents) {
      // Severe penalty for too few components
      canvasCompletenessPenalty =
          ((minRequiredComponents - totalCanvasComponents) * 15).clamp(0, 60);
      completenessMessage =
          '⚠️ Only $totalCanvasComponents components on canvas! Need at least $minRequiredComponents for a proper design.';
    } else if (totalCanvasComponents < idealComponents) {
      canvasCompletenessPenalty =
          ((idealComponents - totalCanvasComponents) * 5).clamp(0, 20);
      completenessMessage =
          'Consider adding more components to your canvas design.';
    }

    // Calculate notes-to-canvas mismatch penalty
    int mismatchPenalty = (mentionedButNotDrawn.length * 8).clamp(0, 30);

    // Final consistency score
    final matchedCount = matchedComponents.length;
    int baseScore =
        totalCanvasComponents == 0
            ? 0 // No canvas = 0 score
            : ((matchedCount / totalCanvasComponents) * 100).round();

    // Apply penalties
    final consistencyScore =
        (baseScore - canvasCompletenessPenalty - mismatchPenalty).clamp(0, 100);

    // Build suggestions
    final suggestions = StringBuffer();
    if (completenessMessage.isNotEmpty) {
      suggestions.writeln(completenessMessage);
    }
    if (unmatchedComponents.isNotEmpty) {
      suggestions.writeln(
        'Explain these drawn components: ${unmatchedComponents.join(", ")}',
      );
    }
    if (mentionedButNotDrawn.isNotEmpty) {
      suggestions.writeln(
        'Draw these mentioned components: ${mentionedButNotDrawn.join(", ")}',
      );
    }
    if (suggestions.isEmpty) {
      suggestions.write('Great! Your canvas and notes align well.');
    }

    return {
      'score': consistencyScore,
      'matched': matchedComponents,
      'unmatched': unmatchedComponents,
      'mentionedButNotDrawn': mentionedButNotDrawn,
      'canvasComponentCount': totalCanvasComponents,
      'minRequired': minRequiredComponents,
      'suggestions': suggestions.toString().trim(),
    };
  }

  // Generate intelligent, dynamic feedback based on user's actual performance
  static String _generateDetailedFeedback(
    String systemName,
    int componentScore,
    int architectureScore,
    int featuresScore,
    int finalScore,
    Map<String, String> componentsDetails,
    int wordCount,
    Map<String, dynamic>? canvasConsistency,
  ) {
    final feedback = StringBuffer();

    feedback.writeln('🤖 AI Analysis for $systemName');
    feedback.writeln('═' * 50);
    feedback.writeln('📊 Overall Score: $finalScore/100');
    feedback.writeln('📝 Word Count: $wordCount words');
    feedback.writeln('');

    // Canvas consistency feedback (if canvas data provided)
    if (canvasConsistency != null) {
      final consistencyScore = canvasConsistency['score'] as int;
      final matchedComponents = canvasConsistency['matched'] as List<String>;
      final unmatchedComponents =
          canvasConsistency['unmatched'] as List<String>;
      final canvasCount =
          canvasConsistency['canvasComponentCount'] as int? ?? 0;
      final minRequired = canvasConsistency['minRequired'] as int? ?? 5;
      final mentionedButNotDrawn =
          canvasConsistency['mentionedButNotDrawn'] as List<String>? ?? [];

      feedback.writeln('🎨 Canvas-Notes Consistency: $consistencyScore/100');
      feedback.writeln(
        '📍 Components on Canvas: $canvasCount (min recommended: $minRequired)',
      );

      if (canvasCount < minRequired) {
        feedback.writeln('🔴 CRITICAL: Too few components on canvas!');
        feedback.writeln(
          '   Your canvas needs at least $minRequired components for a proper design.',
        );
        feedback.writeln(
          '   Currently you only have $canvasCount component${canvasCount == 1 ? '' : 's'}.',
        );
      }

      if (consistencyScore >= 90 && canvasCount >= minRequired) {
        feedback.writeln('✅ Excellent! Your notes match your canvas design.');
        if (matchedComponents.isNotEmpty) {
          feedback.writeln('📝 All drawn components are explained.');
        }
      } else if (consistencyScore >= 70) {
        feedback.writeln('👍 Good alignment between canvas and notes.');
        if (unmatchedComponents.isNotEmpty) {
          feedback.writeln(
            '💡 Consider explaining: ${unmatchedComponents.take(2).join(", ")}',
          );
        }
      } else if (canvasCount >= minRequired) {
        feedback.writeln('⚠️  Canvas and notes don\'t match well.');
        if (unmatchedComponents.isNotEmpty) {
          feedback.writeln(
            '🔴 Drawn but not explained: ${unmatchedComponents.join(", ")}',
          );
        }
      }

      if (mentionedButNotDrawn.isNotEmpty) {
        feedback.writeln('⚠️  You wrote about these but didn\'t draw them:');
        feedback.writeln('   ${mentionedButNotDrawn.join(", ")}');
      }

      feedback.writeln('');
    }

    // Intelligent component feedback based on what's actually missing
    feedback.writeln('🔧 Component Analysis: $componentScore/100');
    final missingComponents = _getMissingComponents(componentsDetails);
    final foundComponents = _getFoundComponents(componentsDetails);

    if (componentScore >= 90) {
      feedback.writeln('✅ Outstanding component coverage!');
      if (foundComponents.isNotEmpty) {
        feedback.writeln(
          '🎯 Strong components: ${foundComponents.take(3).join(", ")}',
        );
      }
    } else if (componentScore >= 70) {
      feedback.writeln('👍 Good component foundation.');
      if (missingComponents.isNotEmpty) {
        feedback.writeln(
          '💡 Consider adding: ${missingComponents.take(2).join(", ")}',
        );
      }
    } else {
      feedback.writeln('⚠️  Component coverage needs improvement.');
      if (missingComponents.isNotEmpty) {
        feedback.writeln(
          '🔴 Critical missing: ${missingComponents.take(3).join(", ")}',
        );
      }
    }
    feedback.writeln('');

    // System-specific architectural guidance
    feedback.writeln('🏗️ Architecture Patterns: $architectureScore/100');
    final systemSpecificAdvice = _getSystemSpecificArchitectureAdvice(
      systemName,
      architectureScore,
    );
    feedback.writeln(systemSpecificAdvice);
    feedback.writeln('');

    // Dynamic feature recommendations based on system type
    feedback.writeln('⚡ System Features: $featuresScore/100');
    final featureAdvice = _getSystemSpecificFeatureAdvice(
      systemName,
      featuresScore,
    );
    feedback.writeln(featureAdvice);
    feedback.writeln('');

    // Smart recommendations based on performance profile
    feedback.writeln('💡 Personalized Recommendations:');
    final smartRecommendations = _generateSmartRecommendations(
      systemName,
      componentScore,
      architectureScore,
      featuresScore,
      finalScore,
      wordCount,
    );
    for (final rec in smartRecommendations) {
      feedback.writeln('• $rec');
    }
    feedback.writeln('');

    // Next steps based on current level
    feedback.writeln('🎯 Next Steps:');
    final nextSteps = _getNextSteps(
      systemName,
      finalScore,
      componentScore,
      architectureScore,
      featuresScore,
    );
    for (final step in nextSteps) {
      feedback.writeln('� $step');
    }

    return feedback.toString();
  }

  // Helper: Get missing components from analysis
  static List<String> _getMissingComponents(
    Map<String, String> componentsDetails,
  ) {
    return componentsDetails.entries
        .where((entry) => entry.value.startsWith('❌'))
        .map((entry) => entry.key)
        .toList();
  }

  // Helper: Get found components from analysis
  static List<String> _getFoundComponents(
    Map<String, String> componentsDetails,
  ) {
    return componentsDetails.entries
        .where((entry) => entry.value.startsWith('✅'))
        .map((entry) => entry.key)
        .toList();
  }

  // System-specific architecture advice with enhanced patterns from demos
  static String _getSystemSpecificArchitectureAdvice(
    String systemName,
    int score,
  ) {
    if (systemName.contains('URL Shortener')) {
      if (score >= 80)
        return '✅ Great focus on caching and redirection patterns! Consider mentioning consistent hashing and database sharding.';
      if (score >= 60)
        return '👍 Consider adding more details about cache-aside pattern, CDN strategy, and Base62 encoding for short codes.';
      return '⚠️  URL shorteners rely heavily on caching and ID generation. Add details about Redis, CDN, cache-aside patterns, and unique ID generation strategies.';
    }

    if (systemName.contains('Pastebin')) {
      if (score >= 80)
        return '✅ Excellent coverage of content storage and moderation patterns!';
      if (score >= 60)
        return '👍 Consider adding syntax highlighting, content moderation, and expiration cleanup strategies.';
      return '⚠️  Pastebin needs content management patterns. Focus on storage, expiration cleanup, syntax highlighting, and content moderation.';
    }

    if (systemName.contains('Web Crawler')) {
      if (score >= 80)
        return '✅ Strong understanding of distributed crawling and politeness!';
      if (score >= 60)
        return '👍 Consider adding URL frontier management, priority queues, and bloom filters for deduplication.';
      return '⚠️  Web crawlers need distributed coordination. Focus on robots.txt compliance, crawl delays, URL frontier, and bloom filters.';
    }

    if (systemName.contains('Social Media') ||
        systemName.contains('News Feed')) {
      if (score >= 80)
        return '✅ Excellent understanding of feed generation architectures and fan-out strategies!';
      if (score >= 60)
        return '👍 Consider push vs pull patterns, celebrity problem handling, and ML-based ranking.';
      return '⚠️  Social media systems need fan-out strategies. Discuss push/pull models, hybrid approach for celebrities, and personalized ranking.';
    }

    if (systemName.contains('Video Streaming')) {
      if (score >= 80)
        return '✅ Strong grasp of CDN, transcoding, and adaptive bitrate architectures!';
      if (score >= 60)
        return '👍 Add more details about HLS/DASH manifests, transcoding pipeline, and personalization engine.';
      return '⚠️  Video streaming requires specialized architecture. Focus on CDN, transcoding pipelines, adaptive bitrate streaming, and content ingestion.';
    }

    if (systemName.contains('Ride-Sharing') ||
        systemName.contains('Ride Sharing')) {
      if (score >= 80)
        return '✅ Excellent understanding of geospatial matching and real-time tracking!';
      if (score >= 60)
        return '👍 Consider adding surge pricing algorithms, H3 geo-indexing, and driver matching optimization.';
      return '⚠️  Ride-sharing needs geospatial architecture. Focus on GPS tracking, geospatial queries (Redis GEO, H3), surge pricing, and ETA calculation.';
    }

    if (systemName.contains('Collaborative Editor')) {
      if (score >= 80)
        return '✅ Great understanding of real-time synchronization and conflict resolution!';
      if (score >= 60)
        return '👍 Consider adding OT vs CRDT comparison, presence/cursor tracking, and version history.';
      return '⚠️  Collaborative systems need real-time architecture. Discuss WebSockets, OT/CRDT algorithms, presence tracking, and version history.';
    }

    if (systemName.contains('Live Streaming')) {
      if (score >= 80)
        return '✅ Excellent grasp of ultra-low latency streaming and chat systems!';
      if (score >= 60)
        return '👍 Add more details about RTMP vs WebRTC, SFU servers, and chat moderation.';
      return '⚠️  Live streaming needs ultra-low latency. Focus on RTMP ingest, WebRTC/SFU, transcoding cluster, and real-time chat.';
    }

    if (systemName.contains('Gaming Leaderboard') ||
        systemName.contains('Leaderboard')) {
      if (score >= 80)
        return '✅ Strong understanding of ranking algorithms and real-time updates!';
      if (score >= 60)
        return '👍 Consider adding segmented leaderboards, ELO/MMR rating systems, and anti-cheat detection.';
      return '⚠️  Gaming leaderboards need specialized data structures. Focus on Redis sorted sets, real-time WebSocket updates, and ranking algorithms.';
    }

    // Default advice for other systems
    if (score >= 80) return '✅ Strong architectural understanding!';
    if (score >= 60)
      return '👍 Good patterns, consider adding more distributed system concepts.';
    return '⚠️  Add more architectural patterns like microservices, event-driven design, caching, and scaling strategies.';
  }

  // System-specific feature advice with enhanced patterns from demos
  static String _getSystemSpecificFeatureAdvice(String systemName, int score) {
    if (systemName.contains('URL Shortener')) {
      if (score >= 80)
        return '✅ Comprehensive URL shortener features covered including analytics and caching!';
      if (score >= 60)
        return '👍 Consider adding expiration policies, click analytics, Base62 encoding, and multi-region failover.';
      return '⚠️  Missing key features: short code generation, redirects, click tracking, cache layers, and rate limiting.';
    }

    if (systemName.contains('Pastebin')) {
      if (score >= 80) return '✅ Excellent pastebin functionality coverage!';
      if (score >= 60)
        return '👍 Add syntax highlighting, content moderation, and end-to-end encryption options.';
      return '⚠️  Key features missing: paste operations, expiration, syntax highlighting, privacy settings, and burn-after-reading.';
    }

    if (systemName.contains('Web Crawler')) {
      if (score >= 80)
        return '✅ Comprehensive crawling features including politeness and deduplication!';
      if (score >= 60)
        return '👍 Consider robots.txt compliance, bloom filters for deduplication, and URL prioritization.';
      return '⚠️  Essential features: URL frontier, crawl scheduling, robots.txt parsing, politeness protocols, and distributed coordination.';
    }

    if (systemName.contains('Social Media') ||
        systemName.contains('News Feed')) {
      if (score >= 80)
        return '✅ Excellent news feed functionality with ranking and personalization!';
      if (score >= 60)
        return '👍 Consider adding ML-based ranking, celebrity handling, and real-time push updates.';
      return '⚠️  Key features missing: fan-out strategies, feed caching, personalized ranking, and hybrid push/pull approach.';
    }

    if (systemName.contains('Video Streaming')) {
      if (score >= 80)
        return '✅ Strong video streaming features including transcoding and personalization!';
      if (score >= 60)
        return '👍 Add content ingestion pipeline, recommendation engine, and subscription billing.';
      return '⚠️  Essential features: adaptive bitrate (HLS/DASH), transcoding pipeline, CDN delivery, and content catalog.';
    }

    if (systemName.contains('Ride-Sharing') ||
        systemName.contains('Ride Sharing')) {
      if (score >= 80)
        return '✅ Comprehensive ride-sharing features with real-time tracking!';
      if (score >= 60)
        return '👍 Consider surge pricing algorithms, ETA calculation with traffic, and payment processing.';
      return '⚠️  Key features missing: driver matching, GPS tracking, surge pricing, fare calculation, and real-time location updates.';
    }

    if (systemName.contains('Collaborative Editor')) {
      if (score >= 80)
        return '✅ Excellent collaborative editing features with conflict resolution!';
      if (score >= 60)
        return '👍 Add presence/cursor tracking, version history, and permission sharing.';
      return '⚠️  Essential features: real-time sync, OT or CRDT, cursor presence, version history, and undo/redo support.';
    }

    if (systemName.contains('Live Streaming')) {
      if (score >= 80)
        return '✅ Comprehensive live streaming features with chat and monetization!';
      if (score >= 60)
        return '👍 Consider low-latency modes (WebRTC/SFU), chat moderation, and donation/subscription alerts.';
      return '⚠️  Key features missing: RTMP ingest, transcoding ladder, chat system, viewer interaction, and stream discovery.';
    }

    if (systemName.contains('Gaming Leaderboard') ||
        systemName.contains('Leaderboard')) {
      if (score >= 80)
        return '✅ Excellent leaderboard features with real-time updates and segmentation!';
      if (score >= 60)
        return '👍 Consider ELO/MMR ratings, segmented leaderboards (daily/weekly), and anti-cheat detection.';
      return '⚠️  Essential features: score submission, ranking (Redis sorted sets), real-time updates, and friend leaderboards.';
    }

    // Default feature advice
    if (score >= 80) return '✅ Strong feature understanding!';
    if (score >= 60)
      return '👍 Good coverage, add more domain-specific features.';
    return '⚠️  Add more system-specific features and business logic details.';
  }

  // Generate smart recommendations based on performance profile - enhanced with demo insights
  static List<String> _generateSmartRecommendations(
    String systemName,
    int componentScore,
    int architectureScore,
    int featuresScore,
    int finalScore,
    int wordCount,
  ) {
    final recommendations = <String>[];

    // Word count based advice
    if (wordCount < 50) {
      recommendations.add(
        'Your notes are quite brief. Aim for 100-200 words to cover key concepts thoroughly.',
      );
    } else if (wordCount > 500) {
      recommendations.add(
        'Great detail! Consider organizing your notes into clear sections for better readability.',
      );
    }

    // Performance-specific advice
    if (componentScore < 50) {
      recommendations.add(
        'Focus on core infrastructure: Load Balancer → Application Server → Database → Cache',
      );
    }

    // System-specific recommendations based on demo patterns
    if (systemName.contains('URL Shortener')) {
      if (componentScore < 60) {
        recommendations.add(
          'Add caching layers: Browser Cache → CDN → Redis → Database',
        );
      }
      if (featuresScore < 50) {
        recommendations.add(
          'Discuss Base62 encoding for short codes and analytics for click tracking',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider horizontal scaling with database sharding by short code prefix',
        );
      }
    }

    if (systemName.contains('Pastebin')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add syntax highlighting, expiration handling, and privacy options',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider content moderation pipeline and CDN for viral pastes',
        );
      }
    }

    if (systemName.contains('Web Crawler')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add URL frontier management with priority queues and politeness controls',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider distributed crawlers with coordinator and bloom filters for deduplication',
        );
      }
    }

    if (systemName.contains('News Feed') ||
        systemName.contains('Social Media')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Discuss fan-out on write vs read strategies and the celebrity problem',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider hybrid approach: pre-compute for regular users, live fetch for celebrities',
        );
      }
    }

    if (systemName.contains('Video Streaming')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add adaptive bitrate streaming (HLS/DASH) and transcoding pipeline',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider content ingestion, personalization engine, and subscription billing',
        );
      }
    }

    if (systemName.contains('Ride-Sharing') ||
        systemName.contains('Ride Sharing')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add real-time GPS tracking, surge pricing with H3 hexagons, and driver matching',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider geospatial indexing (Redis GEO), WebSocket for live updates, and ETA calculation',
        );
      }
    }

    if (systemName.contains('Collaborative Editor')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Discuss OT vs CRDT for conflict resolution and cursor/presence tracking',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider WebSocket for real-time sync, version history, and permission sharing',
        );
      }
    }

    if (systemName.contains('Live Streaming')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add RTMP ingest, WebRTC/SFU for low latency, and real-time chat system',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider transcoding cluster, multi-CDN strategy, and chat moderation pipeline',
        );
      }
    }

    if (systemName.contains('Gaming Leaderboard') ||
        systemName.contains('Leaderboard')) {
      if (featuresScore < 50) {
        recommendations.add(
          'Add Redis sorted sets (ZADD/ZREVRANGE), real-time WebSocket updates, and ELO ratings',
        );
      }
      if (architectureScore < 50) {
        recommendations.add(
          'Consider segmented leaderboards (daily/weekly), anti-cheat detection, and friend rankings',
        );
      }
    }

    // Strength-based encouragement
    if (componentScore >= 80) {
      recommendations.add(
        'Your component knowledge is strong! Now focus on how they interact in real-world scenarios.',
      );
    }

    if (architectureScore >= 80) {
      recommendations.add(
        'Excellent architectural thinking! Consider adding failure scenarios and edge cases.',
      );
    }

    return recommendations.isNotEmpty
        ? recommendations
        : ['Keep expanding your notes with more technical details!'];
  }

  // Get next steps based on current performance - enhanced with demo insights
  static List<String> _getNextSteps(
    String systemName,
    int finalScore,
    int componentScore,
    int architectureScore,
    int featuresScore,
  ) {
    final steps = <String>[];

    if (finalScore < 40) {
      steps.add(
        'Start with basic system components: servers, databases, load balancers',
      );
      steps.add(
        'Research how data flows through the system from user request to response',
      );
    } else if (finalScore < 70) {
      steps.add(
        'Add more advanced components like caching layers and message queues',
      );
      steps.add('Describe how the system handles scale and multiple users');
    } else if (finalScore < 85) {
      steps.add('Include monitoring, logging, and observability components');
      steps.add('Consider failure scenarios and how the system recovers');
    } else {
      steps.add('Explore advanced optimizations and cost considerations');
      steps.add('Add deployment strategies and operational excellence details');
    }

    // Add system-specific next steps based on demo patterns
    if (systemName.contains('URL Shortener')) {
      if (featuresScore < 70) {
        steps.add(
          'Research Base62 encoding, cache hierarchies, and click analytics pipelines',
        );
      } else {
        steps.add(
          'Consider multi-region deployment with cross-region replication for high availability',
        );
      }
    } else if (systemName.contains('Pastebin')) {
      if (featuresScore < 70) {
        steps.add(
          'Study syntax highlighting engines, content moderation, and encryption options',
        );
      } else {
        steps.add(
          'Consider CDN caching strategies for viral content and storage optimization',
        );
      }
    } else if (systemName.contains('Web Crawler')) {
      if (featuresScore < 70) {
        steps.add(
          'Research URL frontier management, bloom filters, and robots.txt parsing',
        );
      } else {
        steps.add(
          'Consider distributed crawler coordination and content deduplication strategies',
        );
      }
    } else if (systemName.contains('News Feed') ||
        systemName.contains('Social Media')) {
      if (featuresScore < 70) {
        steps.add(
          'Study fan-out strategies (push/pull/hybrid) and feed ranking algorithms',
        );
      } else {
        steps.add(
          'Research ML-based personalization and real-time feed updates',
        );
      }
    } else if (systemName.contains('Video Streaming')) {
      if (featuresScore < 70) {
        steps.add(
          'Research adaptive bitrate streaming (HLS/DASH) and transcoding pipelines',
        );
      } else {
        steps.add(
          'Study recommendation engines, content ingestion, and subscription billing systems',
        );
      }
    } else if (systemName.contains('Ride-Sharing') ||
        systemName.contains('Ride Sharing')) {
      if (featuresScore < 70) {
        steps.add(
          'Study geospatial indexing (H3, Redis GEO) and real-time location tracking',
        );
      } else {
        steps.add(
          'Research surge pricing algorithms, ETA prediction, and payment processing',
        );
      }
    } else if (systemName.contains('Collaborative Editor')) {
      if (featuresScore < 70) {
        steps.add(
          'Research operational transformation (OT) and CRDT algorithms for conflict resolution',
        );
      } else {
        steps.add(
          'Study cursor/presence tracking, version history, and permission systems',
        );
      }
    } else if (systemName.contains('Live Streaming')) {
      if (featuresScore < 70) {
        steps.add(
          'Study WebRTC, SFU servers, and low-latency streaming protocols',
        );
      } else {
        steps.add(
          'Research real-time chat systems, moderation pipelines, and monetization features',
        );
      }
    } else if (systemName.contains('Gaming Leaderboard') ||
        systemName.contains('Leaderboard')) {
      if (featuresScore < 70) {
        steps.add(
          'Investigate Redis sorted sets (ZADD/ZREVRANGE) and real-time ranking updates',
        );
      } else {
        steps.add(
          'Research ELO/MMR rating systems, segmented leaderboards, and anti-cheat detection',
        );
      }
    }

    return steps;
  }

  // =================================================================
  // BATCH OPERATIONS
  // =================================================================

  // Generate feedback for all systems
  static Future<Map<String, AIFeedbackResult>>
  generateFeedbackForAllSystems() async {
    final results = <String, AIFeedbackResult>{};

    for (final systemName in _systemOrder) {
      results[systemName] = await generateFeedbackForSystem(systemName);
    }

    return results;
  }

  // Get parallel mapping information using indexing
  static Map<String, String> getParallelMapping() {
    final mapping = <String, String>{};

    // Use index-based mapping: same index = parallel databases
    for (
      int i = 0;
      i < _systemOrder.length && i < _referenceNotesOrder.length;
      i++
    ) {
      mapping[_systemOrder[i]] = _referenceNotesOrder[i];
    }

    return mapping;
  }

  // Get system index for debugging
  static int getSystemIndex(String systemName) {
    return _systemOrder.indexOf(systemName);
  }

  // Get reference notes by index (direct access)
  static String? getReferenceNotesByIndex(int index) {
    if (index < 0 || index >= 9) return null;

    switch (index) {
      case 0:
        return SystemDesignReferenceDatabase.urlShortenerNotes;
      case 1:
        return SystemDesignReferenceDatabase.pastebinServiceNotes;
      case 2:
        return SystemDesignReferenceDatabase.webCrawlerNotes;
      case 3:
        return SystemDesignReferenceDatabase.socialMediaNewsFeedNotes;
      case 4:
        return SystemDesignReferenceDatabase.videoStreamingServiceNotes;
      case 5:
        return SystemDesignReferenceDatabase.rideSharingServiceNotes;
      case 6:
        return SystemDesignReferenceDatabase.collaborativeEditorNotes;
      case 7:
        return SystemDesignReferenceDatabase.liveStreamingPlatformNotes;
      case 8:
        return SystemDesignReferenceDatabase.globalGamingLeaderboardNotes;
      default:
        return null;
    }
  }
}

// =================================================================
// RESULT CLASSES
// =================================================================

class AIFeedbackResult {
  final String systemName;
  final int score;
  final String feedback;
  final bool hasUserNotes;
  final Map<String, dynamic> comparisonDetails;

  AIFeedbackResult({
    required this.systemName,
    required this.score,
    required this.feedback,
    required this.hasUserNotes,
    required this.comparisonDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'systemName': systemName,
      'score': score,
      'feedback': feedback,
      'hasUserNotes': hasUserNotes,
      'comparisonDetails': comparisonDetails,
    };
  }

  factory AIFeedbackResult.fromJson(Map<String, dynamic> json) {
    return AIFeedbackResult(
      systemName: json['systemName'] ?? '',
      score: json['score'] ?? 0,
      feedback: json['feedback'] ?? '',
      hasUserNotes: json['hasUserNotes'] ?? false,
      comparisonDetails: Map<String, dynamic>.from(
        json['comparisonDetails'] ?? {},
      ),
    );
  }
}
