import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'system_design_icons.dart';

class IconLibraryDialog extends StatefulWidget {
  const IconLibraryDialog({super.key});

  @override
  State<IconLibraryDialog> createState() => _IconLibraryDialogState();
}

class _IconLibraryDialogState extends State<IconLibraryDialog> {
  String searchQuery = '';
  String? selectedCategory;

  // Comprehensive icon documentation
  static const Map<String, Map<String, String>> iconDocumentation = {
    // Client & Interface
    'Mobile Client': {
      'description':
          'Native mobile applications (iOS/Android) that provide user interface for mobile devices',
      'usedIn':
          'All mobile-first systems, social media apps, ride-sharing apps',
      'when':
          'When you need a mobile app interface for users to interact with your system',
    },
    'Desktop Client': {
      'description':
          'Native desktop applications for Windows, Mac, or Linux operating systems',
      'usedIn': 'Desktop applications, IDEs, productivity tools',
      'when':
          'When users need rich desktop functionality or offline capabilities',
    },
    'Tablet Client': {
      'description':
          'Tablet-optimized applications with touch-friendly interfaces',
      'usedIn': 'Point-of-sale systems, restaurant ordering, educational apps',
      'when':
          'When you need a larger screen than mobile but portable interface',
    },
    'Web Browser': {
      'description':
          'Web-based client accessed through browsers like Chrome, Firefox, Safari',
      'usedIn': 'Web applications, SaaS platforms, e-commerce sites',
      'when': 'When you need cross-platform access without installing software',
    },
    'User': {
      'description': 'Represents end users interacting with your system',
      'usedIn': 'User flows, authentication systems, access patterns',
      'when': 'To show user actors in your system design',
    },
    'Admin User': {
      'description':
          'Administrators with elevated privileges for system management',
      'usedIn': 'Admin panels, system configuration, user management',
      'when': 'When you need to show privileged access or admin functionality',
    },
    'Group Users': {
      'description':
          'Multiple users or user groups accessing the system simultaneously',
      'usedIn': 'Collaborative systems, multiplayer games, group chat',
      'when': 'To represent concurrent users or user communities',
    },

    // Network & Communication
    'Load Balancer': {
      'description':
          'Distributes incoming requests across multiple servers to ensure no single server is overwhelmed',
      'usedIn': 'All web-scale systems, high-traffic applications',
      'when':
          'When you need to distribute traffic across multiple servers for scalability and reliability',
    },
    'Router': {
      'description':
          'Network device that forwards data packets between computer networks',
      'usedIn': 'Network infrastructure, multi-region deployments',
      'when': 'When showing network routing between different segments',
    },
    'Network Hub': {
      'description': 'Central connection point for network devices',
      'usedIn': 'Network topology diagrams, LAN setups',
      'when': 'To show network connectivity between multiple devices',
    },
    'Internet Connection': {
      'description': 'Connection to the public internet',
      'usedIn': 'Cloud-based systems, web applications',
      'when': 'To show external internet connectivity',
    },
    'Global Network': {
      'description':
          'Worldwide network infrastructure spanning multiple regions',
      'usedIn': 'CDN systems, global applications, multi-region deployments',
      'when': 'When your system spans multiple geographic regions',
    },
    'DNS Server': {
      'description':
          'Domain Name System server that translates domain names to IP addresses',
      'usedIn': 'Web applications, URL shorteners, domain routing',
      'when': 'When you need domain name resolution or geographic routing',
    },
    'Proxy Server': {
      'description':
          'Intermediary server that forwards requests between clients and servers',
      'usedIn': 'Web crawlers, privacy systems, caching layers',
      'when': 'When you need request forwarding, IP rotation, or anonymity',
    },
    'API Gateway': {
      'description':
          'Single entry point for API requests, handles authentication, rate limiting, and routing',
      'usedIn': 'Microservices architecture, API management',
      'when':
          'When you need centralized API management, authentication, or rate limiting',
    },
    'CDN': {
      'description':
          'Content Delivery Network that caches static content globally for fast delivery',
      'usedIn': 'Video streaming, image hosting, static website delivery',
      'when': 'When you need fast global content delivery for static assets',
    },
    'WebSocket Server': {
      'description':
          'Server that maintains persistent bidirectional connections for real-time communication',
      'usedIn':
          'Chat applications, live streaming, real-time collaboration, gaming',
      'when':
          'When you need real-time, two-way communication between client and server',
    },
    'Rate Limiter': {
      'description':
          'Controls the rate of requests to prevent abuse and ensure fair usage',
      'usedIn': 'API services, public-facing endpoints, anti-spam systems',
      'when': 'To prevent abuse, DDoS protection, or enforce usage quotas',
    },
    'Global Load Balancer': {
      'description':
          'Distributes traffic across multiple data centers globally',
      'usedIn': 'Multi-region deployments, disaster recovery setups',
      'when': 'When you need global traffic distribution and failover',
    },

    // Servers & Computing
    'Web Server': {
      'description': 'Server that handles HTTP requests and serves web content',
      'usedIn': 'Web applications, REST APIs, static content hosting',
      'when': 'When you need to serve web pages or handle HTTP requests',
    },
    'Application Server': {
      'description': 'Server that runs business logic and application code',
      'usedIn': 'Backend services, business logic processing',
      'when': 'To execute application code and business logic',
    },
    'API Server': {
      'description': 'Dedicated server for handling API requests and responses',
      'usedIn': 'RESTful APIs, GraphQL services, backend APIs',
      'when': 'When you need dedicated API request processing',
    },
    'Single Server': {
      'description': 'Standalone server handling all application functions',
      'usedIn': 'Small applications, prototypes, development environments',
      'when': 'For simple deployments or when starting small',
    },
    'Server Cluster': {
      'description': 'Group of servers working together as a single system',
      'usedIn': 'High-availability systems, distributed computing',
      'when': 'When you need redundancy and horizontal scaling',
    },
    'Microservice': {
      'description':
          'Small, independent service focused on a specific business function',
      'usedIn': 'Microservices architecture, scalable applications',
      'when': 'When breaking down monoliths into smaller, manageable services',
    },
    'Container': {
      'description':
          'Lightweight, isolated environment for running applications (Docker, Kubernetes)',
      'usedIn': 'Modern cloud deployments, microservices',
      'when': 'For consistent deployment across different environments',
    },
    'Virtual Machine': {
      'description': 'Virtualized computer system with its own OS',
      'usedIn': 'Cloud computing, resource isolation, legacy applications',
      'when':
          'When you need OS-level isolation or running different operating systems',
    },

    // Database & Storage
    'SQL Database': {
      'description':
          'Relational database with structured tables and SQL queries (MySQL, PostgreSQL)',
      'usedIn': 'Transactional systems, structured data, user accounts',
      'when':
          'When you need ACID properties, complex queries, or structured data',
    },
    'NoSQL Database': {
      'description':
          'Non-relational database for flexible, unstructured data (MongoDB, Cassandra)',
      'usedIn': 'User-generated content, logs, flexible schemas',
      'when': 'When you need horizontal scaling or flexible data structures',
    },
    'Graph Database': {
      'description':
          'Database optimized for storing and querying connected data (Neo4j)',
      'usedIn': 'Social networks, recommendation engines, fraud detection',
      'when':
          'When relationships between data are as important as the data itself',
    },
    'Time Series Database': {
      'description':
          'Database optimized for time-stamped data (InfluxDB, TimescaleDB)',
      'usedIn': 'Monitoring systems, IoT data, analytics',
      'when':
          'When storing and querying time-series data like metrics or sensor readings',
    },
    'Key-Value Store': {
      'description':
          'Simple database storing data as key-value pairs (Redis, DynamoDB)',
      'usedIn': 'Caching, session storage, real-time data',
      'when': 'For fast lookups by key, caching, or simple data structures',
    },
    'Blob Storage': {
      'description': 'Storage for large binary objects like files and media',
      'usedIn': 'File uploads, media storage, backups',
      'when': 'When storing large files, images, videos, or documents',
    },
    'Data Warehouse': {
      'description': 'Centralized repository for analytical data and reporting',
      'usedIn': 'Business intelligence, data analytics, reporting',
      'when': 'For historical data analysis and business reporting',
    },
    'File System': {
      'description': 'Local or network file storage system',
      'usedIn': 'Document storage, temporary files, local caching',
      'when': 'For storing files locally or on network-attached storage',
    },
    'Object Storage': {
      'description':
          'Scalable storage for unstructured data (Amazon S3, Azure Blob)',
      'usedIn': 'Cloud storage, backups, media files',
      'when': 'For storing large amounts of unstructured data in the cloud',
    },

    // Caching & Performance
    'Cache': {
      'description': 'Generic caching layer to store frequently accessed data',
      'usedIn': 'All performance-critical systems',
      'when': 'To reduce database load and improve response times',
    },
    'Redis Cache': {
      'description': 'In-memory data store used for high-performance caching',
      'usedIn': 'Session storage, leaderboards, real-time analytics',
      'when': 'When you need extremely fast data access with persistence',
    },
    'In-Memory Cache': {
      'description': 'Application-level cache stored in RAM',
      'usedIn': 'Frequently accessed data, computed results',
      'when': 'For extremely fast access to hot data within application',
    },
    'CDN Cache': {
      'description': 'Edge caching for static content distributed globally',
      'usedIn': 'Images, videos, static assets',
      'when': 'To cache content at edge locations near users',
    },
    'Browser Cache': {
      'description': 'Client-side caching in web browsers',
      'usedIn': 'Web applications, static resources',
      'when': 'To reduce server load by caching on client side',
    },
    'Application Cache': {
      'description': 'Application-level caching layer',
      'usedIn': 'Computed results, database query results',
      'when': 'To cache application-specific data and computations',
    },

    // Message Systems
    'Message Queue': {
      'description': 'Asynchronous message passing system (RabbitMQ, SQS)',
      'usedIn': 'Background jobs, task processing, decoupling services',
      'when': 'For asynchronous processing and service decoupling',
    },
    'Event Stream': {
      'description': 'Real-time event processing stream (Kafka, Kinesis)',
      'usedIn': 'Event-driven architecture, real-time analytics',
      'when': 'For processing continuous streams of events in real-time',
    },
    'Publisher': {
      'description': 'Component that sends messages to a pub/sub system',
      'usedIn': 'Event-driven systems, notifications',
      'when':
          'When one service needs to broadcast events to multiple subscribers',
    },
    'Subscriber': {
      'description': 'Component that receives messages from a pub/sub system',
      'usedIn': 'Event listeners, notification receivers',
      'when': 'When services need to react to published events',
    },
    'Notification Service': {
      'description': 'Sends notifications via various channels',
      'usedIn': 'User alerts, system notifications, real-time updates',
      'when': 'To notify users about events, updates, or system changes',
    },
    'Email Service': {
      'description': 'Sends transactional or marketing emails',
      'usedIn': 'User registration, password resets, newsletters',
      'when': 'When you need to send emails to users',
    },
    'SMS Service': {
      'description': 'Sends text messages to mobile phones',
      'usedIn': 'Two-factor authentication, alerts, notifications',
      'when': 'For urgent notifications or verification codes',
    },
    'Push Notification': {
      'description': 'Sends real-time notifications to mobile devices',
      'usedIn': 'Mobile apps, real-time alerts',
      'when': 'To send instant notifications to mobile app users',
    },
    'Crawl Queue': {
      'description': 'Queue managing URLs to be crawled in web crawler systems',
      'usedIn': 'Web crawlers, search engines',
      'when': 'To manage and prioritize URLs for crawling',
    },

    // Security & Monitoring
    'Security Gateway': {
      'description': 'Entry point that enforces security policies',
      'usedIn': 'API security, threat detection, access control',
      'when': 'To protect your system from security threats',
    },
    'Authentication': {
      'description': 'Verifies user identity (login, passwords, tokens)',
      'usedIn': 'User login systems, API authentication',
      'when': 'When you need to verify who users are',
    },
    'Authorization': {
      'description': 'Controls what authenticated users can access',
      'usedIn': 'Role-based access control, permissions',
      'when': 'To control user permissions and access levels',
    },
    'Firewall': {
      'description':
          'Network security system that monitors and controls traffic',
      'usedIn': 'Network security, DDoS protection',
      'when': 'To protect your infrastructure from unauthorized access',
    },
    'Monitoring System': {
      'description': 'Tracks system health, performance, and metrics',
      'usedIn': 'All production systems, DevOps',
      'when': 'To ensure system reliability and detect issues',
    },
    'Analytics Service': {
      'description': 'Collects and analyzes usage data and metrics',
      'usedIn': 'User behavior tracking, business intelligence',
      'when': 'To understand user behavior and system performance',
    },
    'Logging Service': {
      'description': 'Centralized logging for debugging and auditing',
      'usedIn': 'All systems, debugging, compliance',
      'when': 'To track system events and debug issues',
    },
    'Metrics Collector': {
      'description': 'Collects performance metrics and statistics',
      'usedIn': 'Performance monitoring, capacity planning',
      'when': 'To track system performance and resource usage',
    },
    'Alert System': {
      'description': 'Sends alerts when problems are detected',
      'usedIn': 'Production monitoring, incident response',
      'when': 'To notify team when system issues occur',
    },
    'Content Moderation': {
      'description':
          'Filters and reviews user-generated content for inappropriate material',
      'usedIn': 'Social media, user forums, live streaming',
      'when': 'To ensure content complies with policies and laws',
    },
    'DRM System': {
      'description': 'Digital Rights Management to protect copyrighted content',
      'usedIn': 'Video streaming, music streaming, e-books',
      'when': 'To protect premium content from piracy',
    },
    'Anti-cheat System': {
      'description': 'Detects and prevents cheating in gaming systems',
      'usedIn': 'Online gaming, competitive leaderboards',
      'when': 'To ensure fair play in gaming environments',
    },
    'Fraud Detection': {
      'description': 'Identifies suspicious or fraudulent activities',
      'usedIn': 'Payment systems, ride-sharing, e-commerce',
      'when': 'To detect and prevent fraud and abuse',
    },
    'Security Scanner': {
      'description': 'Scans for security vulnerabilities and malicious content',
      'usedIn': 'URL shorteners, file uploads, content systems',
      'when': 'To protect users from malicious content',
    },

    // Cloud & Infrastructure
    'Cloud Service': {
      'description': 'Generic cloud computing service (AWS, Azure, GCP)',
      'usedIn': 'Cloud deployments, managed services',
      'when': 'To represent cloud infrastructure',
    },
    'Cloud Storage': {
      'description': 'Cloud-based object storage service',
      'usedIn': 'File storage, backups, media hosting',
      'when': 'For scalable cloud storage',
    },
    'Cloud Database': {
      'description': 'Managed database service in the cloud',
      'usedIn': 'Cloud-native applications',
      'when': 'For managed database without infrastructure management',
    },
    'Backup Service': {
      'description': 'Automated backup and recovery system',
      'usedIn': 'Data protection, disaster recovery',
      'when': 'To ensure data can be recovered after failures',
    },
    'Sync Service': {
      'description': 'Synchronizes data across multiple locations',
      'usedIn': 'Multi-region deployments, offline-first apps',
      'when': 'To keep data consistent across locations',
    },
    'Geographic Region': {
      'description': 'Physical location or data center region',
      'usedIn': 'Global deployments, latency optimization',
      'when': 'To show geographic distribution of infrastructure',
    },
    'Data Center': {
      'description': 'Physical facility housing servers and infrastructure',
      'usedIn': 'On-premise deployments, colocation',
      'when': 'To represent physical infrastructure locations',
    },
    'Edge Server': {
      'description': 'Server located close to end users for low latency',
      'usedIn': 'CDN, edge computing, IoT',
      'when': 'For low-latency processing near users',
    },

    // System Utilities
    'Configuration Service': {
      'description': 'Manages application configuration and settings',
      'usedIn': 'Microservices, feature flags, environment config',
      'when': 'To centralize configuration management',
    },
    'Scheduler': {
      'description': 'Runs tasks at scheduled times or intervals',
      'usedIn': 'Cron jobs, batch processing, maintenance tasks',
      'when': 'For time-based task execution',
    },
    'Auto-scaling Group': {
      'description': 'Automatically adjusts server capacity based on demand',
      'usedIn': 'Cloud deployments, variable traffic',
      'when': 'To automatically scale resources with demand',
    },
    'Circuit Breaker': {
      'description':
          'Prevents cascading failures by stopping calls to failing services',
      'usedIn': 'Microservices, fault tolerance',
      'when': 'To prevent failures from spreading across services',
    },
    'Service Mesh': {
      'description':
          'Infrastructure layer for service-to-service communication',
      'usedIn': 'Microservices, complex service interactions',
      'when': 'For managing microservice communication',
    },
    'API Manager': {
      'description': 'Manages API lifecycle, documentation, and access',
      'usedIn': 'API platforms, developer portals',
      'when': 'To manage and document APIs',
    },
    'Version Control': {
      'description': 'Tracks code changes and versions (Git)',
      'usedIn': 'Software development, collaboration',
      'when': 'To manage code versions and collaboration',
    },
    'Build System': {
      'description': 'Compiles and packages code for deployment',
      'usedIn': 'CI/CD pipelines, software development',
      'when': 'To automate build processes',
    },
    'Deployment Pipeline': {
      'description': 'Automates testing and deployment of code',
      'usedIn': 'CI/CD, DevOps',
      'when': 'To automate software delivery',
    },

    // Data Processing
    'Stream Processor': {
      'description': 'Processes data in real-time as it arrives',
      'usedIn': 'Real-time analytics, event processing',
      'when': 'For processing continuous data streams',
    },
    'Batch Processor': {
      'description': 'Processes large volumes of data in batches',
      'usedIn': 'Data warehousing, ETL jobs',
      'when': 'For scheduled processing of large datasets',
    },
    'ETL Pipeline': {
      'description': 'Extract, Transform, Load data between systems',
      'usedIn': 'Data warehousing, data migration',
      'when': 'To move and transform data between systems',
    },
    'Data Pipeline': {
      'description': 'Automated workflow for moving and processing data',
      'usedIn': 'Data engineering, analytics',
      'when': 'To automate data flow and processing',
    },
    'Search Engine': {
      'description': 'Full-text search system (Elasticsearch, Solr)',
      'usedIn': 'Content search, product search, log analysis',
      'when': 'When you need powerful search capabilities',
    },
    'Recommendation Engine': {
      'description': 'Suggests content based on user behavior and preferences',
      'usedIn': 'E-commerce, content platforms, social media',
      'when': 'To personalize user experience with recommendations',
    },
    'ML Model': {
      'description':
          'Machine learning model for predictions and classifications',
      'usedIn': 'AI applications, personalization, fraud detection',
      'when': 'For intelligent predictions and pattern recognition',
    },
    'Analytics Engine': {
      'description': 'Analyzes data to extract insights',
      'usedIn': 'Business intelligence, user analytics',
      'when': 'To gain insights from data',
    },
    'Video Transcoding': {
      'description': 'Converts videos between formats and quality levels',
      'usedIn': 'Video streaming, video uploads',
      'when': 'To support multiple video formats and qualities',
    },
    'Video Processing': {
      'description': 'Processes and manipulates video content',
      'usedIn': 'Video editing, filters, effects',
      'when': 'For video transformations and enhancements',
    },
    'Image Processing': {
      'description': 'Processes and transforms images',
      'usedIn': 'Photo apps, thumbnails, filters',
      'when': 'For image transformations and optimizations',
    },
    'Thumbnail Generator': {
      'description': 'Creates thumbnail previews from media',
      'usedIn': 'Video platforms, image galleries',
      'when': 'To generate preview images',
    },

    // External Services
    'Third Party API': {
      'description': 'External API integration',
      'usedIn': 'Various integrations, external data sources',
      'when': 'When integrating with external services',
    },
    'Payment Gateway': {
      'description': 'Processes online payments (Stripe, PayPal)',
      'usedIn': 'E-commerce, subscriptions, monetization',
      'when': 'To accept payments from users',
    },
    'Social Media API': {
      'description': 'Integration with social media platforms',
      'usedIn': 'Social login, sharing, social features',
      'when': 'To integrate social media functionality',
    },
    'Map Service': {
      'description': 'Mapping and location services (Google Maps)',
      'usedIn': 'Ride-sharing, delivery, location-based apps',
      'when': 'For maps, geocoding, and directions',
    },
    'Weather Service': {
      'description': 'Weather data API',
      'usedIn': 'Travel apps, agriculture, outdoor activities',
      'when': 'When you need weather information',
    },
    'File Upload Service': {
      'description': 'Handles file uploads from users',
      'usedIn': 'Document management, media uploads',
      'when': 'To allow users to upload files',
    },
    'Video Streaming': {
      'description': 'Video streaming service integration',
      'usedIn': 'Video platforms, live streaming',
      'when': 'For video delivery and streaming',
    },

    // Application Services
    'Feed Generation': {
      'description': 'Creates personalized content feeds for users',
      'usedIn': 'Social media, news apps, content platforms',
      'when': 'To show personalized content to users',
    },
    'Social Graph Service': {
      'description': 'Manages social connections and relationships',
      'usedIn': 'Social networks, friend systems',
      'when': 'To manage user relationships and connections',
    },
    'Content Publishing': {
      'description': 'Handles creation and publishing of user content',
      'usedIn': 'Social media, blogging platforms, forums',
      'when': 'When users create and publish content',
    },
    'User Presence': {
      'description': 'Tracks and displays user online/offline status',
      'usedIn': 'Chat apps, collaborative tools, gaming',
      'when': 'To show who is currently active',
    },
    'Comment System': {
      'description': 'Manages comments and discussions',
      'usedIn': 'Social media, blogs, forums',
      'when': 'To enable user discussions and feedback',
    },
    'Chat Service': {
      'description': 'Real-time messaging between users',
      'usedIn': 'Messaging apps, customer support, gaming',
      'when': 'For real-time text communication',
    },
    'URL Shortening Service': {
      'description': 'Creates short URLs from long ones',
      'usedIn': 'Link shorteners, social sharing',
      'when': 'To create memorable short links',
    },
    'URL Redirect Service': {
      'description': 'Handles redirects from short URLs to original URLs',
      'usedIn': 'URL shorteners, tracking links',
      'when': 'To redirect users to original destinations',
    },
    'Content Storage': {
      'description': 'Stores user-generated content',
      'usedIn': 'Pastebin, document storage, content platforms',
      'when': 'To persist user content',
    },
    'Content Retrieval': {
      'description': 'Fetches stored content for users',
      'usedIn': 'Content delivery, document access',
      'when': 'To retrieve and serve stored content',
    },
    'Expiration Service': {
      'description': 'Automatically deletes content after expiration time',
      'usedIn': 'Pastebin, temporary storage, ephemeral content',
      'when': 'For time-limited content',
    },
    'Crawl Coordinator': {
      'description': 'Manages distributed web crawling tasks',
      'usedIn': 'Web crawlers, search engines',
      'when': 'To coordinate crawling across multiple workers',
    },
    'URL Discovery': {
      'description': 'Finds new URLs to crawl',
      'usedIn': 'Web crawlers, link analysis',
      'when': 'To discover new pages to index',
    },
    'Content Extractor': {
      'description': 'Extracts useful content from web pages',
      'usedIn': 'Web crawlers, data scraping',
      'when': 'To extract structured data from HTML',
    },
    'Duplicate Detection': {
      'description': 'Identifies duplicate content or URLs',
      'usedIn': 'Web crawlers, content management',
      'when': 'To avoid processing duplicate content',
    },
    'Matching Engine': {
      'description':
          'Matches entities based on criteria (drivers to riders, buyers to sellers)',
      'usedIn': 'Ride-sharing, marketplaces, dating apps',
      'when': 'To pair users or entities',
    },
    'Routing Service': {
      'description': 'Calculates optimal routes between locations',
      'usedIn': 'Ride-sharing, delivery, navigation',
      'when': 'For route planning and directions',
    },
    'Pricing Engine': {
      'description': 'Calculates dynamic pricing based on various factors',
      'usedIn': 'Ride-sharing, e-commerce, hotels',
      'when': 'For dynamic or surge pricing',
    },
    'Trip Management': {
      'description': 'Manages trip lifecycle from request to completion',
      'usedIn': 'Ride-sharing, delivery services',
      'when': 'To track and manage trips',
    },
    'Ranking Engine': {
      'description': 'Calculates and maintains player rankings',
      'usedIn': 'Gaming leaderboards, competitive systems',
      'when': 'To rank players or entities',
    },
    'Score Processing': {
      'description': 'Validates and processes game scores',
      'usedIn': 'Gaming, competitive platforms',
      'when': 'To handle score submissions',
    },
    'Tournament Manager': {
      'description': 'Organizes and manages tournaments',
      'usedIn': 'Gaming, esports, competitions',
      'when': 'For competitive events and tournaments',
    },
    'Achievement System': {
      'description': 'Tracks and awards achievements to users',
      'usedIn': 'Gaming, gamification, learning platforms',
      'when': 'To recognize user accomplishments',
    },
    'Document Service': {
      'description': 'Manages document storage and versioning',
      'usedIn': 'Collaborative editors, document management',
      'when': 'For document lifecycle management',
    },
    'Collaboration Engine': {
      'description': 'Enables real-time collaborative editing',
      'usedIn': 'Google Docs, Figma, collaborative tools',
      'when': 'For simultaneous multi-user editing',
    },
    'Stream Management': {
      'description': 'Manages live stream lifecycle',
      'usedIn': 'Live streaming platforms, broadcasting',
      'when': 'To control live video streams',
    },
    'Video Upload': {
      'description': 'Handles large video file uploads',
      'usedIn': 'Video platforms, content creation',
      'when': 'For uploading video content',
    },
    'Video Ingest': {
      'description': 'Receives live video streams (RTMP, WebRTC)',
      'usedIn': 'Live streaming, broadcasting',
      'when': 'To receive live video feeds',
    },

    // Geospatial & Location
    'Location Service': {
      'description': 'Tracks and manages real-time location data',
      'usedIn': 'Ride-sharing, delivery, location tracking',
      'when': 'For real-time GPS tracking',
    },
    'Geospatial Database': {
      'description': 'Database optimized for location queries',
      'usedIn': 'Ride-sharing, location-based search',
      'when': 'For efficient location-based queries',
    },
    'Geohashing': {
      'description': 'Encodes geographic coordinates into short strings',
      'usedIn': 'Location indexing, proximity search',
      'when': 'For efficient location indexing',
    },
    'Quadtree': {
      'description': 'Spatial data structure for location queries',
      'usedIn': 'Location search, map rendering',
      'when': 'For fast spatial queries',
    },
    'GPS Tracking': {
      'description': 'Continuous GPS location tracking',
      'usedIn': 'Ride-sharing, fleet management, fitness apps',
      'when': 'To track moving objects in real-time',
    },
    'Map Routing': {
      'description': 'Calculates routes on road networks',
      'usedIn': 'Navigation, ride-sharing, delivery',
      'when': 'For turn-by-turn directions',
    },
  };

  @override
  Widget build(BuildContext context) {
    final categories = SystemDesignIcons.getIconsByCategory();

    // Filter categories based on search
    final filteredCategories = <String, Map<String, IconData>>{};
    if (selectedCategory != null) {
      filteredCategories[selectedCategory!] = categories[selectedCategory]!;
    } else {
      filteredCategories.addAll(categories);
    }

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 20, 20, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.library_books,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Icon Library',
                        style: GoogleFonts.saira(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Learn what each icon does and when to use it',
                        style: GoogleFonts.saira(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search icons...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category filter chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FilterChip(
                    label: Text(
                      'All Categories',
                      style: GoogleFonts.saira(fontSize: 12),
                    ),
                    selected: selectedCategory == null,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                    selectedColor: Colors.purple,
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                  const SizedBox(width: 8),
                  ...categories.keys.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: GoogleFonts.saira(fontSize: 12),
                        ),
                        selected: selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = selected ? category : null;
                          });
                        },
                        selectedColor: _getCategoryColor(category),
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Icon list
            Expanded(
              child: ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, categoryIndex) {
                  final categoryName = filteredCategories.keys.elementAt(
                    categoryIndex,
                  );
                  final icons = filteredCategories[categoryName]!;

                  // Filter icons by search query
                  final filteredIcons =
                      icons.entries.where((entry) {
                        if (searchQuery.isEmpty) return true;
                        return entry.key.toLowerCase().contains(searchQuery) ||
                            (iconDocumentation[entry.key]?['description'] ?? '')
                                .toLowerCase()
                                .contains(searchQuery);
                      }).toList();

                  if (filteredIcons.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(
                            categoryName,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(categoryName),
                              color: _getCategoryColor(categoryName),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              categoryName,
                              style: GoogleFonts.saira(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getCategoryColor(categoryName),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${filteredIcons.length} icons',
                              style: GoogleFonts.saira(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Icons in this category
                      ...filteredIcons.map((iconEntry) {
                        final iconName = iconEntry.key;
                        final icon = iconEntry.value;
                        final doc = iconDocumentation[iconName];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(
                                        categoryName,
                                      ).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: _getCategoryColor(categoryName),
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      icon,
                                      color: _getCategoryColor(categoryName),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          iconName,
                                          style: GoogleFonts.saira(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        if (doc != null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            doc['description'] ?? '',
                                            style: GoogleFonts.saira(
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white.withOpacity(
                                                  0.8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (doc != null) ...[
                                const SizedBox(height: 12),
                                const Divider(color: Colors.white24, height: 1),
                                const SizedBox(height: 12),
                                _buildInfoRow(
                                  Icons.check_circle_outline,
                                  'Used In',
                                  doc['usedIn'] ?? '',
                                  Colors.green,
                                ),
                                const SizedBox(height: 8),
                                _buildInfoRow(
                                  Icons.lightbulb_outline,
                                  'When to Use',
                                  doc['when'] ?? '',
                                  Colors.amber,
                                ),
                              ],
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: GoogleFonts.saira(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                TextSpan(
                  text: text,
                  style: GoogleFonts.saira(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Client & Interface':
        return Colors.blue;
      case 'Networking':
        return Colors.green;
      case 'Servers & Computing':
        return Colors.orange;
      case 'Database & Storage':
        return Colors.red;
      case 'Caching,Performance':
        return Colors.purple;
      case 'Message Systems':
        return Colors.amber;
      case 'Security,Monitoring':
        return Colors.indigo;
      case 'Cloud,Infrastructure':
        return Colors.cyan;
      case 'System Utilities':
        return Colors.brown;
      case 'Data Processing':
        return Colors.teal;
      case 'External Services':
        return Colors.pink;
      case 'Application Services':
        return Colors.deepOrange;
      case 'Geospatial & Location':
        return Colors.lime;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Client & Interface':
        return Icons.devices;
      case 'Networking':
        return Icons.network_check;
      case 'Servers & Computing':
        return Icons.dns;
      case 'Database & Storage':
        return Icons.storage;
      case 'Caching,Performance':
        return Icons.speed;
      case 'Message Systems':
        return Icons.message;
      case 'Security,Monitoring':
        return Icons.security;
      case 'Cloud,Infrastructure':
        return Icons.cloud_queue;
      case 'System Utilities':
        return Icons.build;
      case 'Data Processing':
        return Icons.data_usage;
      case 'External Services':
        return Icons.extension;
      case 'Application Services':
        return Icons.apps;
      case 'Geospatial & Location':
        return Icons.location_on;
      default:
        return Icons.category;
    }
  }
}
