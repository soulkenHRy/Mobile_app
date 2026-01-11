import 'package:flutter/material.dart';

class SystemDesignIcons {
  // Client & User Interface Components
  static const Map<String, IconData> clientInterface = {
    'Mobile Client': Icons.phone_android,
    'Desktop Client': Icons.computer,
    'Tablet Client': Icons.tablet,
    'Web Browser': Icons.web,
    'User': Icons.person,
    'Admin User': Icons.admin_panel_settings,
    'Group Users': Icons.group,
  };

  // Network & Communication Components
  static const Map<String, IconData> networkCommunication = {
    'Load Balancer': Icons.share,
    'Router': Icons.router,
    'Network Hub': Icons.device_hub,
    'Internet Connection': Icons.wifi,
    'Global Network': Icons.language,
    'DNS Server': Icons.language,
    'Proxy Server': Icons.vpn_key,
    'API Gateway': Icons.api,
    'CDN': Icons.public,
    'WebSocket Server': Icons.electrical_services,
    'Rate Limiter': Icons.speed_outlined,
    'Global Load Balancer': Icons.alt_route,
  };

  // Servers & Computing Components
  static const Map<String, IconData> serversComputing = {
    'Web Server': Icons.developer_board,
    'Application Server': Icons.apps,
    'API Server': Icons.api,
    'Single Server': Icons.computer_sharp,
    'Server Cluster': Icons.view_module,
    'Microservice': Icons.widgets,
    'Container': Icons.inbox,
    'Virtual Machine': Icons.desktop_windows,
  };

  // Database & Storage Components
  static const Map<String, IconData> databaseStorage = {
    'SQL Database': Icons.storage,
    'NoSQL Database': Icons.table_chart,
    'Graph Database': Icons.account_tree,
    'Time Series Database': Icons.timeline,
    'Key-Value Store': Icons.key,
    'Blob Storage': Icons.folder,
    'Data Warehouse': Icons.archive,
    'File System': Icons.folder_open,
    'Object Storage': Icons.cloud_queue,
  };

  // Caching & Performance Components
  static const Map<String, IconData> cachingPerformance = {
    'Cache': Icons.cached,
    'Redis Cache': Icons.flash_on,
    'In-Memory Cache': Icons.memory,
    'CDN Cache': Icons.speed,
    'Browser Cache': Icons.web_asset,
    'Application Cache': Icons.layers,
  };

  // Message Systems & Queues
  static const Map<String, IconData> messageSystems = {
    'Message Queue': Icons.queue,
    'Event Stream': Icons.stream,
    'Publisher': Icons.send,
    'Subscriber': Icons.inbox,
    'Notification Service': Icons.notifications,
    'Email Service': Icons.email,
    'SMS Service': Icons.sms,
    'Push Notification': Icons.push_pin,
    'Crawl Queue': Icons.format_list_numbered,
  };

  // Security & Monitoring Components
  static const Map<String, IconData> securityMonitoring = {
    'Security Gateway': Icons.security,
    'Authentication': Icons.lock,
    'Authorization': Icons.verified_user,
    'Firewall': Icons.shield,
    'Monitoring System': Icons.monitor,
    'Analytics Service': Icons.analytics,
    'Logging Service': Icons.description,
    'Metrics Collector': Icons.assessment,
    'Alert System': Icons.warning,
    'Content Moderation': Icons.gavel,
    'DRM System': Icons.copyright,
    'Anti-cheat System': Icons.verified,
    'Fraud Detection': Icons.privacy_tip,
    'Security Scanner': Icons.scanner,
  };

  // Cloud & Infrastructure Components
  static const Map<String, IconData> cloudInfrastructure = {
    'Cloud Service': Icons.cloud,
    'Cloud Storage': Icons.cloud_upload,
    'Cloud Database': Icons.cloud_queue,
    'Backup Service': Icons.backup,
    'Sync Service': Icons.sync,
    'Geographic Region': Icons.place,
    'Data Center': Icons.business,
    'Edge Server': Icons.near_me,
  };

  // System Utilities & Tools
  static const Map<String, IconData> systemUtilities = {
    'Configuration Service': Icons.tune,
    'Scheduler': Icons.schedule,
    'Auto-scaling Group': Icons.autorenew,
    'Circuit Breaker': Icons.power_settings_new,
    'Service Mesh': Icons.grid_view,
    'API Manager': Icons.manage_accounts,
    'Version Control': Icons.source,
    'Build System': Icons.build,
    'Deployment Pipeline': Icons.double_arrow,
  };

  // Data Processing Components
  static const Map<String, IconData> dataProcessing = {
    'Stream Processor': Icons.water,
    'Batch Processor': Icons.inventory,
    'ETL Pipeline': Icons.transform,
    'Data Pipeline': Icons.linear_scale,
    'Search Engine': Icons.search,
    'Recommendation Engine': Icons.recommend,
    'ML Model': Icons.psychology,
    'Analytics Engine': Icons.insights,
    'Video Transcoding': Icons.video_settings,
    'Video Processing': Icons.movie_creation,
    'Image Processing': Icons.photo_filter,
    'Thumbnail Generator': Icons.photo_library,
  };

  // External Services & Integrations
  static const Map<String, IconData> externalServices = {
    'Third Party API': Icons.extension,
    'Payment Gateway': Icons.payment,
    'Social Media API': Icons.share,
    'Map Service': Icons.map,
    'Weather Service': Icons.wb_sunny,
    'File Upload Service': Icons.cloud_upload,
    'Video Streaming': Icons.play_circle,
  };

  // Application Services (NEW - Specialized business logic services)
  static const Map<String, IconData> applicationServices = {
    'Feed Generation': Icons.dynamic_feed,
    'Social Graph Service': Icons.hub,
    'Content Publishing': Icons.publish,
    'User Presence': Icons.personal_video,
    'Comment System': Icons.comment,
    'Chat Service': Icons.chat,
    'URL Shortening Service': Icons.link,
    'URL Redirect Service': Icons.shortcut,
    'Content Storage': Icons.save,
    'Content Retrieval': Icons.get_app,
    'Expiration Service': Icons.timer_off,
    'Crawl Coordinator': Icons.explore,
    'URL Discovery': Icons.travel_explore,
    'Content Extractor': Icons.content_cut,
    'Duplicate Detection': Icons.filter_alt,
    'Matching Engine': Icons.compare_arrows,
    'Routing Service': Icons.directions,
    'Pricing Engine': Icons.attach_money,
    'Trip Management': Icons.trip_origin,
    'Ranking Engine': Icons.leaderboard,
    'Score Processing': Icons.scoreboard,
    'Tournament Manager': Icons.emoji_events,
    'Achievement System': Icons.military_tech,
    'Document Service': Icons.article,
    'Collaboration Engine': Icons.workspaces,
    'Stream Management': Icons.live_tv,
    'Video Upload': Icons.video_call,
    'Video Ingest': Icons.videocam,
  };

  // Geospatial & Location Services (NEW)
  static const Map<String, IconData> geospatialServices = {
    'Location Service': Icons.my_location,
    'Geospatial Database': Icons.location_on,
    'Geohashing': Icons.grid_on,
    'Quadtree': Icons.account_tree_outlined,
    'GPS Tracking': Icons.gps_fixed,
    'Map Routing': Icons.directions_car,
  };

  // Get all icons in a flat map for easy access
  static Map<String, IconData> getAllIcons() {
    final Map<String, IconData> allIcons = {};

    allIcons.addAll(clientInterface);
    allIcons.addAll(networkCommunication);
    allIcons.addAll(serversComputing);
    allIcons.addAll(databaseStorage);
    allIcons.addAll(cachingPerformance);
    allIcons.addAll(messageSystems);
    allIcons.addAll(securityMonitoring);
    allIcons.addAll(cloudInfrastructure);
    allIcons.addAll(systemUtilities);
    allIcons.addAll(dataProcessing);
    allIcons.addAll(externalServices);
    allIcons.addAll(applicationServices);
    allIcons.addAll(geospatialServices);

    return allIcons;
  }

  // Get icons by category
  static Map<String, Map<String, IconData>> getIconsByCategory() {
    return {
      'Client & Interface': clientInterface,
      'Networking': networkCommunication,
      'Servers & Computing': serversComputing,
      'Database & Storage': databaseStorage,
      'Caching,Performance': cachingPerformance,
      'Message Systems': messageSystems,
      'Security,Monitoring': securityMonitoring,
      'Cloud,Infrastructure': cloudInfrastructure,
      'System Utilities': systemUtilities,
      'Data Processing': dataProcessing,
      'External Services': externalServices,
      'Application Services': applicationServices,
      'Geospatial & Location': geospatialServices,
    };
  }

  // Get a specific icon by name
  static IconData? getIcon(String name) {
    return getAllIcons()[name];
  }

  // Get category for a specific icon name
  static String? getCategory(String iconName) {
    final categories = getIconsByCategory();
    for (final entry in categories.entries) {
      if (entry.value.containsKey(iconName)) {
        return entry.key;
      }
    }
    return null;
  }

  // Get all icon names in a category
  static List<String> getIconNamesInCategory(String category) {
    final categories = getIconsByCategory();
    return categories[category]?.keys.toList() ?? [];
  }

  // Search icons by name (useful for filtering)
  static Map<String, IconData> searchIcons(String query) {
    final allIcons = getAllIcons();
    final filteredIcons = <String, IconData>{};

    for (final entry in allIcons.entries) {
      if (entry.key.toLowerCase().contains(query.toLowerCase())) {
        filteredIcons[entry.key] = entry.value;
      }
    }

    return filteredIcons;
  }

  // Get recommended icons for common system design patterns
  static Map<String, List<String>> getSystemPatternIcons() {
    return {
      'Microservices Architecture': [
        'API Gateway',
        'Microservice',
        'Load Balancer',
        'Message Queue',
        'Service Mesh',
      ],
      'Web Application': [
        'Web Browser',
        'Load Balancer',
        'Web Server',
        'Application Server',
        'SQL Database',
        'Cache',
      ],
      'Real-time Chat System': [
        'Mobile Client',
        'WebSocket Server',
        'Message Queue',
        'NoSQL Database',
        'Push Notification',
      ],
      'E-commerce Platform': [
        'Web Browser',
        'API Gateway',
        'User Service',
        'Product Service',
        'Payment Gateway',
        'SQL Database',
        'Cache',
      ],
      'Social Media Platform': [
        'Mobile Client',
        'CDN',
        'Load Balancer',
        'Feed Service',
        'Graph Database',
        'Message Queue',
        'Analytics Service',
      ],
    };
  }
}
