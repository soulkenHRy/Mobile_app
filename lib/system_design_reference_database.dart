// Comprehensive System Design Reference Database
// Built from quiz app's knowledge bank and system design icons
// Organized by categories for easy mapping and evaluation

class SystemDesignReferenceDatabase {
  // =================================================================
  // TIER 1: FOUNDATIONAL SYSTEMS (Learning Core Concepts)
  // =================================================================

  static const String urlShortenerNotes = '''
URL Shortener System Design (e.g., TinyURL, bit.ly)

SYSTEM OVERVIEW:
A URL shortener service converts long URLs into short, memorable links with extremely high read traffic for redirects and moderate write traffic for URL creation. The system prioritizes low latency redirects and global availability.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Web Browser: Primary interface for users to submit and manage URLs
- Mobile Client: Native apps for quick link sharing and management  
- Desktop Client: Browser extensions and desktop applications
- API Clients: Third-party integrations and developer access

Network & Communication Layer:
- Load Balancer: Distributes incoming requests across multiple servers
- API Gateway: Single entry point for rate limiting, authentication, and API versioning
- CDN: Caches popular shortened URLs globally for ultra-fast redirects
- DNS Server: Routes traffic to geographically closest servers

Application Layer:
- Web Server: Handles HTTP requests and 301/302 redirect responses
- Application Server: Core business logic for URL encoding, decoding, and validation
- URL Shortening Service: Generates short codes and stores mappings
- URL Redirect Service: Handles high-volume redirect requests
- Analytics Service: Tracks click patterns and user behavior

Storage & Database Layer:
- Key-Value Store: Primary storage for URL mappings (Redis/DynamoDB)
- SQL Database: User accounts, analytics, and metadata storage
- Time Series Database: Click analytics and performance metrics
- Object Storage: Backup and archival of URL mappings

CACHING STRATEGY:
- In-Memory Cache: Most frequently accessed URLs in application memory
- Redis Cache: Distributed caching layer for URL mappings
- CDN Cache: Geographic caching of popular redirects
- Browser Cache: Client-side caching for recently accessed URLs

ARCHITECTURAL PATTERNS:
- REST API: Stateless request-response model for URL creation and retrieval
- Caching: Multi-level caching strategy for high performance redirects
- Sharding: Database sharding based on URL hash for horizontal scaling
- Replication: Master-slave replication for read scalability

SECURITY & MONITORING:
- Rate Limiter: Prevents abuse and spam URL creation
- Security Scanner: Malicious URL detection and blocking
- Monitoring System: Track redirect performance and system health
- Analytics Engine: User behavior analysis, click tracking, and redirect analytics
- Alert System: Notifications for system issues and security threats

KEY CHARACTERISTICS:
- High read traffic (90%+ redirects vs URL creation)
- Low latency requirements for global redirects with automatic expiration
- Horizontal scaling for massive request volumes
- URL encoding algorithms (Base62, custom schemes)
- Click tracking and analytics capabilities
- Global availability and geographic distribution
''';

  static const String pastebinServiceNotes = '''
Pastebin Service System Design (e.g., Pastebin.com, GitHub Gist)

SYSTEM OVERVIEW:
A Pastebin service is a write-heavy system that allows users to store and share text content (code snippets, logs, notes) with automatic expiration and high write throughput. The system focuses on temporary storage, content lifecycle management, and fast content retrieval via custom URLs.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Web Browser: Primary interface for users to paste and view content
- Mobile Client: Apps for quick content sharing on mobile devices
- Desktop Client: Integrated tools for developers and system administrators
- API Clients: Programmatic access for automation and third-party integrations

Network & Communication Layer:
- Load Balancer: Distributes high write traffic across multiple application servers
- API Gateway: Handles rate limiting, authentication, and API versioning for paste operations
- CDN: Caches popular public pastes globally for faster content delivery
- DNS Server: Routes requests to appropriate geographic regions

Application Layer:
- Web Server: Handles HTTP requests for paste creation and retrieval
- Application Server: Core business logic for content processing and validation
- Content Storage Service: Handles paste creation and validation
- Content Retrieval Service: Serves paste content with security checks
- Expiration Service: Manages automatic content deletion
- User Management Service: Handles accounts and paste ownership

Storage & Database Layer:
- SQL Database: Stores paste metadata, user accounts, and expiration schedules
- NoSQL Database: High-performance storage for paste content (MongoDB/Cassandra)
- Key-Value Store: Redis for fast paste lookups and session storage
- Object Storage: Amazon S3 for backup and archival of expired content
- File System: Local storage for temporary paste processing

CACHING STRATEGY:
- In-Memory Cache: Frequently accessed pastes stored in application memory
- Redis Cache: Distributed caching layer for paste content and metadata
- CDN Cache: Geographic caching for public pastes with long expiration
- Browser Cache: Client-side caching for recently viewed content

ARCHITECTURAL PATTERNS:
- REST API: Request-response model for paste creation and retrieval
- Caching: Multi-layer caching for frequently accessed paste content
- Sharding: Database sharding by paste ID for horizontal scaling
- Replication: Master-slave replication for high availability

DATA PROCESSING & ANALYTICS:
- Stream Processor: Real-time analytics on paste creation patterns and usage
- Analytics Engine: Generate insights on popular content types and user behavior
- ETL Pipeline: Process paste data for reporting and content moderation
- Batch Processor: Handle bulk operations like expired content cleanup

SECURITY & MONITORING:
- Authentication: User login and API key management for private pastes
- Authorization: Role-based access control for paste visibility and editing
- Security Gateway: Content scanning for malicious code and spam detection
- Firewall: Protection against DDoS attacks and malicious requests
- Monitoring System: Track system health, write throughput, and storage utilization
- Logging Service: Centralized logging for security audits and debugging
- Alert System: Notifications for system issues and security threats

MESSAGE SYSTEMS & BACKGROUND PROCESSING:
- Message Queue: Handle asynchronous tasks like content expiration and cleanup
- Event Stream: Track paste lifecycle events for analytics and auditing
- Notification Service: Email alerts for paste expiration warnings
- Scheduler: Automated cleanup of expired content and maintenance tasks

CONTENT MANAGEMENT FEATURES:
- Custom URL Generation: Create human-readable or random paste URLs
- Automatic Content Expiration: Time-based deletion (1 hour, 1 day, 1 week, never)
- Syntax Highlighting: Code formatting and language detection
- Content Versioning: Track paste edits and revision history
- Privacy Controls: Public, unlisted, and private paste visibility options

KEY CHARACTERISTICS:
- Write-heavy system with high throughput paste creation
- Temporary storage with automatic expiration policies
- Content lifecycle management and auto cleanup
- Custom URL generation for easy sharing
- High write throughput and content storage optimization
- Metadata tracking and content organization
''';

  static const String webCrawlerNotes = '''
Web Crawler System Design (e.g., Googlebot, Web Scraping)

SYSTEM OVERVIEW:
A web crawler is a distributed system that systematically browses and indexes web content. It discovers URLs, extracts content, respects robots.txt policies, and builds comprehensive link graphs while handling massive scale distributed crawling operations.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Crawler Agents: Distributed crawling bots that fetch web pages
- Admin Dashboard: Monitor crawling progress and manage crawl policies
- API Interface: External access for crawl data and status
- Configuration Portal: Set crawling rules and scheduling parameters

Network & Communication Layer:
- Load Balancer: Distributes crawling requests across multiple crawler nodes
- Proxy Servers: Rotate IP addresses to avoid rate limiting and blocking
- DNS Resolver: Efficient domain name resolution for discovered URLs
- Content Delivery: Transfer crawled content to processing systems

Application Layer:
- Crawl Coordinator: Manages distributed crawling tasks and scheduling
- URL Discovery Service: Finds new URLs from crawled pages and sitemaps
- Content Extractor: Parses HTML, extracts text, and identifies links
- Duplicate Detection: Identifies and eliminates duplicate content and URLs
- Robots.txt Parser: Respects website crawling policies and restrictions
- Content Processor: Analyzes and categorizes extracted content

Storage & Database Layer:
- NoSQL Database: Stores crawled content and extracted data (MongoDB/Cassandra)
- Graph Database: Maintains link graph and website relationships (Neo4j)
- Object Storage: Raw page content and binary file storage
- Time Series Database: Crawl metrics, performance data, and analytics

QUEUE & PROCESSING SYSTEMS:
- Message Queue: Manages crawl tasks and coordinates distributed workers
- Crawl Queue: Prioritized queue of URLs to be crawled (Redis/RabbitMQ)
- Stream Processor: Real-time processing of crawled content
- ETL Pipeline: Extract, transform, and load crawled data for analysis

SEARCH & INDEXING:
- Search Engine: Full-text search capabilities for crawled content (Elasticsearch)
- Indexing Service: Creates searchable indexes from extracted content
- Content Classification: Categorizes and tags crawled content
- Link Analysis: Analyzes link structure and page authority

SCHEDULING & COORDINATION:
- Scheduler: Manages crawl frequency and timing based on website policies
- Rate Limiter: Respects website rate limits and crawl delays
- Priority Manager: Prioritizes important pages and fresh content
- Crawl Politeness: Implements delays and respectful crawling practices

ARCHITECTURAL PATTERNS:
- Event-Driven: Queue-based distributed crawling with asynchronous processing
- Pub/Sub: Message queuing for coordinating crawler nodes
- Caching: URL deduplication and content caching for efficiency
- Sharding: Distributed crawling across sharded URL spaces

SECURITY & MONITORING:
- Security Gateway: Protects against malicious websites and content
- Monitoring System: Tracks crawl health, success rates, and performance
- Analytics Engine: Provides insights on crawl patterns and website changes
- Alert System: Notifications for crawl failures and system issues

KEY CHARACTERISTICS:
- Distributed crawling across multiple nodes and geographic regions
- Respects robots.txt policies and website crawling guidelines with politeness delays
- URL discovery from multiple sources (links, sitemaps, feeds) and indexing
- Content extraction and text processing capabilities
- Duplicate detection and deduplication algorithms
- Link graph construction and website relationship mapping
- Scalable queue management for millions of URLs
- Crawl politeness and rate limiting compliance
''';

  // =================================================================
  // TIER 2: WEB-SCALE GIANTS (Million+ Users, Complex Features)
  // =================================================================

  static const String socialMediaNewsFeedNotes = '''
Social Media News Feed System Design (e.g., Facebook, X/Twitter)

SYSTEM OVERVIEW:
A social media news feed system handles millions of users generating and consuming user-generated content in real-time. It balances personalized content delivery with massive scale through sophisticated algorithmic ranking, caching strategies, and real-time updates.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Mobile Apps: Native iOS and Android applications for optimal performance
- Web Application: Responsive web interface for browser-based access
- Desktop Client: Native desktop applications for power users
- API Gateway: External developer access and third-party integrations

Network & Communication Layer:
- Global Load Balancer: Distributes traffic across multiple data centers
- CDN: Caches static content (images, videos) globally for fast delivery
- API Gateway: Rate limiting, authentication, and API versioning
- WebSocket Servers: Real-time notifications and live updates

Application Layer:
- Feed Generation Service: Creates personalized feeds using algorithmic ranking
- Content Publishing Service: Handles post creation, editing, and publishing
- Social Graph Service: Manages user relationships and connections
- Recommendation Engine: Suggests content, people, and trending topics
- Content Moderation Service: Automated and manual content review
- Notification Service: Real-time alerts and push notifications

Storage & Database Layer:
- Graph Database: Social connections and relationship mapping (Neo4j)
- NoSQL Database: User posts, comments, and activity data (Cassandra)
- Object Storage: Media files (images, videos) with CDN integration
- SQL Database: User profiles, authentication, and structured data
- Time Series Database: Analytics, metrics, and user behavior tracking

CACHING & PERFORMANCE:
- Redis Cache: Hot data like trending posts and active user sessions
- In-Memory Cache: Frequently accessed user feeds and social graphs
- CDN Cache: Media content cached globally for fast delivery
- Feed Cache: Pre-computed feeds for active users

REAL-TIME PROCESSING:
- Stream Processor: Real-time engagement tracking and trend detection
- Event Stream: User activity events for analytics and recommendations
- Live Updates: WebSocket connections for instant feed updates
- Push Notifications: Real-time alerts for interactions and messages

CONTENT & RECOMMENDATIONS:
- ML Model: Machine learning for personalized content ranking
- Analytics Engine: User engagement analysis and content performance
- Search Engine: Full-text search for posts, users, and hashtags
- Trending Algorithm: Identifies viral content and emerging topics

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for feed, posts, recommendations, and notifications
- Event-Driven: Real-time event processing for timeline updates and notifications
- Pub/Sub: Message queue for distributing posts to followers' feeds
- Caching: Multi-layer caching for personalized feeds and hot content
- Sharding: Database sharding by user ID for horizontal scaling
- Replication: Database replication for read-heavy workloads

SECURITY & MODERATION:
- Content Moderation: AI-powered detection of inappropriate content
- Security Gateway: Protection against spam, bots, and malicious content
- Privacy Controls: User privacy settings and content visibility management
- Monitoring System: System health, performance metrics, and abuse detection

KEY CHARACTERISTICS:
- Social graph management with complex relationship mapping
- News feed generation with timeline and algorithmic ranking and personalization
- User-generated content at massive scale with real-time delivery and posts
- Recommendation systems for content discovery, engagement, and likes tracking
- Fan-out strategies (push vs pull) for content distribution
- Real-time updates and notifications for user interactions
- Content moderation and spam detection capabilities
- Massive scale with millions of concurrent users
''';

  static const String videoStreamingServiceNotes = '''
Video Streaming Service System Design (e.g., Netflix, YouTube)

SYSTEM OVERVIEW:
A video streaming platform delivers high-quality video content to millions of users globally with adaptive bitrate streaming, massive content libraries, and personalized recommendations. The system handles video upload, transcoding, storage, and delivery through global CDN networks.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Smart TV Apps: Native applications for television platforms
- Mobile Apps: iOS and Android apps with offline download capabilities
- Web Player: Browser-based video player with adaptive streaming
- Gaming Console Apps: Xbox, PlayStation, and other gaming platform apps

Network & Content Delivery:
- Global CDN: Massive content delivery network for video streaming
- Edge Servers: Geographically distributed servers for low-latency delivery
- Adaptive Bitrate: Dynamic quality adjustment based on network conditions
- Content Delivery Optimization: Intelligent routing and caching strategies

Application Layer:
- Video Streaming Service: Core streaming logic and session management
- Recommendation Engine: AI-powered content suggestions and discovery
- User Management Service: Profiles, preferences, and viewing history
- Content Management: Video catalog, metadata, and content organization
- Search Service: Advanced search with filters and content discovery
- Payment Processing: Subscription management and billing

VIDEO PROCESSING PIPELINE:
- Video Upload Service: Handles large file uploads with resumable transfers
- Video Transcoding: Converts videos to multiple formats and bitrates
- Quality Processing: Generates multiple resolution versions (4K, 1080p, 720p, 480p)
- Thumbnail Generation: Creates preview images and video thumbnails
- Content Analysis: Automated content classification and tagging

Storage & Database Layer:
- Object Storage: Massive video file storage distributed globally
- CDN Storage: Video content cached at edge locations worldwide
- NoSQL Database: User profiles, viewing history, and preferences
- SQL Database: Content metadata, billing, and business data
- Time Series Database: Streaming analytics and performance metrics

STREAMING TECHNOLOGY:
- Adaptive Bitrate Streaming: HLS, DASH protocols for quality adaptation
- Video Encoding: H.264, H.265 compression for optimal file sizes
- Stream Processing: Real-time analytics on viewing patterns
- Content Delivery: Intelligent caching and pre-positioning of popular content

ANALYTICS & RECOMMENDATIONS:
- ML Model: Machine learning for personalized content recommendations
- Analytics Engine: Detailed viewing analytics and user behavior tracking
- A/B Testing Platform: Content recommendation and interface optimization
- Business Intelligence: Content performance and revenue analytics

SECURITY & CONTENT PROTECTION:
- DRM (Digital Rights Management): Content protection and licensing
- Geo-blocking: Regional content restrictions and licensing compliance
- Authentication: Secure user login and session management
- Monitoring System: Performance monitoring and system health tracking

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for streaming, transcoding, recommendations, and user management
- REST API: Request-response for content management and user interactions
- Event-Driven: Asynchronous video processing and notification delivery
- Caching: Multi-layer caching with CDN for content delivery optimization
- Sharding: Database sharding by content ID for horizontal scaling
- Replication: Content replication across global regions for availability

SCALABILITY FEATURES:
- Auto-scaling: Dynamic resource allocation based on demand
- Global Distribution: Multi-region deployment for worldwide coverage
- Load Balancing: Intelligent traffic distribution across servers
- Caching Strategy: Multi-layer caching for popular and trending content

KEY CHARACTERISTICS:
- Video streaming with adaptive bitrate for optimal quality
- Massive content libraries with efficient storage and delivery using CDN
- Global CDN distribution for low-latency worldwide access
- Video transcoding pipeline for multiple formats and qualities
- Personalized recommendation algorithms for content discovery
- Advanced analytics for viewing patterns and content performance
- DRM and content protection for licensed material
- Scalable architecture supporting millions of concurrent streams
''';

  static const String rideSharingServiceNotes = '''
Ride-Sharing Service System Design (e.g., Uber, Lyft)

SYSTEM OVERVIEW:
A ride-sharing service connects drivers and riders in real-time through sophisticated geospatial matching, dynamic pricing, and location tracking. The system handles millions of real-time location updates, efficient driver-rider matching, and complex pricing algorithms.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Rider Mobile App: Location-based ride requests and trip tracking
- Driver Mobile App: Trip acceptance, navigation, and earnings tracking
- Web Dashboard: Fleet management and administrative interfaces
- Partner APIs: Integration with third-party services and businesses

Network & Communication Layer:
- Load Balancer: Distributes geospatial queries across multiple servers
- API Gateway: Rate limiting and authentication for mobile applications
- WebSocket Servers: Real-time location updates and trip status
- Message Queue: Asynchronous processing of ride requests and updates

APPLICATION LAYER:
- Location Service: Real-time GPS tracking and location updates
- Matching Engine: Driver-rider pairing based on proximity and preferences
- Routing Service: Optimal route calculation and navigation
- Pricing Engine: Dynamic pricing based on demand, distance, and time
- Trip Management: Trip lifecycle from request to completion
- Payment Processing: Fare calculation, payment, and driver payouts

GEOSPATIAL SYSTEMS:
- Geohashing: Location indexing for efficient proximity searches
- Quadtrees: Spatial data structure for fast location queries
- Geospatial Database: Specialized storage for location data and queries
- Map Services: Integration with mapping providers for routes and ETA

Storage & Database Layer:
- NoSQL Database: Trip data, user profiles, and location history
- Time Series Database: Location tracking data and trip analytics
- Graph Database: City road networks and routing information
- SQL Database: User accounts, driver information, and billing data
- Key-Value Store: Real-time session data and active trip information

REAL-TIME PROCESSING:
- Stream Processor: Real-time location updates and trip status changes
- Event Processing: Driver availability changes and demand fluctuations
- Live Tracking: Continuous GPS updates for accurate trip monitoring
- Notification Service: Real-time alerts for drivers and riders

ANALYTICS & OPTIMIZATION:
- Demand Prediction: ML models for ride demand forecasting
- Supply Management: Driver positioning and availability optimization
- Surge Pricing Algorithm: Dynamic pricing based on supply and demand
- Route Optimization: Efficient routing for drivers and carpooling

BUSINESS LOGIC:
- Driver Onboarding: Background checks, vehicle verification, and approval
- Rider Management: Account creation, payment methods, and trip history
- Surge Pricing: Dynamic fare adjustments based on demand patterns
- Incentive System: Driver bonuses and rider promotions

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for geolocation, matching, routing, and pricing
- Event-Driven: Real-time location updates and trip status changes
- Pub/Sub: Message queue for coordinating ride requests and driver availability
- Caching: Location caching for fast proximity searches
- Sharding: Geospatial sharding by geographic regions

SECURITY & MONITORING:
- Fraud Detection: Unusual trip patterns and payment fraud prevention
- Safety Features: Emergency buttons, trip sharing, and driver verification
- Monitoring System: System performance and geospatial query optimization
- Analytics Engine: Business metrics, driver efficiency, and user satisfaction

KEY CHARACTERISTICS:
- Real-time geospatial processing with geolocation and location tracking
- Efficient driver-rider matching based on proximity and preferences
- Dynamic pricing algorithms responding to supply and demand
- GPS tracking, routing, and route optimization for trip efficiency
- Massive scale with millions of location updates per second
- Complex business logic for driver management and rider experience
- Real-time notifications and trip status updates
- Advanced analytics for demand prediction and operational optimization
''';

  // =================================================================
  // TIER 3: ADVANCED & SPECIALIZED SYSTEMS (Complex Engineering)
  // =================================================================

  static const String collaborativeEditorNotes = '''
Collaborative Editor System Design (e.g., Google Docs, Figma)

SYSTEM OVERVIEW:
A collaborative editor enables multiple users to edit documents simultaneously with real-time synchronization, conflict resolution, and operational transforms. The system handles concurrent editing, user presence, and document versioning with ultra-low latency.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Web Editor: Rich text editor with real-time collaboration features
- Mobile Apps: Touch-optimized editing for smartphones and tablets
- Desktop Apps: Native applications for offline editing capabilities
- Browser Extensions: Quick editing and document access tools

Network & Communication Layer:
- WebSocket Servers: Real-time bidirectional communication for live editing
- Load Balancer: Distributes WebSocket connections across multiple servers
- CDN: Caches static assets and document templates globally
- API Gateway: Authentication and rate limiting for editor operations

APPLICATION LAYER:
- Collaborative Engine: Core logic for real-time document synchronization
- Operational Transforms: Conflict resolution for concurrent edits
- Document Service: Document creation, storage, and version management
- User Presence Service: Real-time cursor positions and user awareness
- Comment System: Threaded discussions and document annotations
- Permission Management: Access control and sharing permissions

REAL-TIME SYNCHRONIZATION:
- Event Stream: Document change events and user operations
- Conflict Resolution: Operational transform algorithms for edit conflicts
- State Synchronization: Ensuring all clients have consistent document state
- Presence Broadcasting: Real-time user cursor and selection updates

Storage & Database Layer:
- NoSQL Database: Document content and version history storage
- Key-Value Store: Real-time session data and user presence information
- Object Storage: Media files, images, and document attachments
- SQL Database: User accounts, permissions, and sharing settings

DOCUMENT PROCESSING:
- Version Control: Document history and rollback capabilities
- Auto-save: Continuous saving of document changes
- Export Service: Convert documents to various formats (PDF, Word, etc.)
- Template Engine: Document templates and formatting presets

COLLABORATION FEATURES:
- Real-time Editing: Simultaneous multi-user editing with live updates
- User Presence: See other users' cursors and selections in real-time
- Comment Threading: Collaborative discussions and feedback
- Suggestion Mode: Track changes and review proposed edits
- Document Sharing: Granular permission controls for access management

SECURITY & ACCESS CONTROL:
- Authentication: Secure user login and session management
- Authorization: Document-level and feature-level permissions
- Encryption: End-to-end encryption for sensitive documents
- Audit Logging: Track all document changes and user actions

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for editing, collaboration, and document management
- Event-Driven: Real-time document updates and user action broadcasting
- Pub/Sub: Message distribution for collaborative editing events
- Caching: Document caching for fast load times
- Replication: Document replication for availability and backup

PERFORMANCE OPTIMIZATION:
- Delta Compression: Efficient transmission of document changes
- Caching Strategy: Document fragments cached for fast loading
- Lazy Loading: Load document sections on-demand
- Offline Support: Local editing with synchronization when online

KEY CHARACTERISTICS:
- Real-time collaboration with operational transform and conflict resolution
- Conflict resolution for concurrent editing operations
- User presence awareness and live cursor tracking
- Document synchronization with ultra-low latency
- Version control and document history management
- WebSocket-based communication for instant updates
- Complex permission systems for document access control
- Offline editing capabilities with online synchronization
''';

  static const String liveStreamingPlatformNotes = '''
Live Streaming Platform System Design (e.g., Twitch, YouTube Live)

SYSTEM OVERVIEW:
A live streaming platform delivers real-time video content to millions of concurrent viewers with ultra-low latency, interactive chat, and content discovery. The system handles live video ingestion, transcoding, distribution, and real-time audience interaction.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Streaming Software: OBS, XSplit integration for content creators
- Mobile Apps: Live streaming and viewing on iOS and Android
- Web Player: Browser-based live video player with chat integration
- Smart TV Apps: Television applications for living room viewing

LIVE VIDEO PIPELINE:
- Video Ingest: RTMP/WebRTC servers for live video upload
- Live Transcoding: Real-time video processing and format conversion
- Adaptive Streaming: Multiple quality streams for different bandwidths
- Stream Distribution: Delivery to edge servers and CDN networks

Network & Delivery:
- Global CDN: Worldwide content delivery for low-latency streaming
- Edge Servers: Geographically distributed servers for regional delivery
- Load Balancer: Distributes streaming load across multiple servers
- WebRTC: Ultra-low latency streaming for interactive applications

APPLICATION LAYER:
- Stream Management: Live stream lifecycle and broadcaster tools
- Chat Service: Real-time messaging and audience interaction
- Content Discovery: Live stream recommendations and trending content
- User Management: Broadcaster profiles and viewer accounts
- Monetization: Subscriptions, donations, and advertising integration

REAL-TIME FEATURES:
- Live Chat: Real-time messaging with moderation capabilities
- Interactive Elements: Polls, donations, and viewer engagement tools
- Stream Analytics: Real-time viewership and engagement metrics
- Notification Service: Live stream alerts and follow notifications

Storage & Database Layer:
- Object Storage: Live stream recordings and video-on-demand content
- NoSQL Database: User profiles, chat history, and stream metadata
- Time Series Database: Viewership analytics and performance metrics
- CDN Storage: Cached stream segments for playback and recording

CHAT & INTERACTION:
- Message Queue: Real-time chat message distribution
- Chat Moderation: Automated and manual content filtering
- Emote System: Custom emojis and subscriber perks
- WebSocket Servers: Real-time bidirectional communication

CONTENT MANAGEMENT:
- Stream Recording: Automatic recording of live streams for VOD
- Clip Creation: User-generated highlights and shareable moments
- Content Moderation: AI-powered detection of inappropriate content
- DMCA Protection: Copyright detection and takedown procedures

MONETIZATION & BUSINESS:
- Subscription System: Paid channels and premium features
- Donation Processing: Real-time viewer contributions to streamers
- Advertising: Pre-roll, mid-roll, and banner advertisement integration
- Analytics Dashboard: Revenue tracking and audience insights

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for RTMP ingestion, transcoding, chat, and delivery
- Event-Driven: Real-time stream events and chat message processing
- Pub/Sub: Message queue for live chat distribution and notifications
- Caching: CDN caching for stream segments and content delivery
- Sharding: Geographic sharding for regional live streaming

PERFORMANCE & SCALING:
- Auto-scaling: Dynamic resource allocation for varying viewership
- Latency Optimization: Sub-second delay for interactive streaming
- Quality Adaptation: Automatic bitrate adjustment for viewer connections
- Global Distribution: Multi-region deployment for worldwide coverage

KEY CHARACTERISTICS:
- Ultra-low latency streaming with RTMP for real-time interaction
- Massive concurrent viewership support (millions of viewers)
- Real-time chat and live audience engagement features with broadcasting
- Live video transcoding and adaptive bitrate streaming
- Global CDN distribution for worldwide low-latency delivery
- Interactive features like donations, polls, and viewer participation
- Content creator tools and monetization features
- Stream recording and video-on-demand conversion
''';

  static const String globalGamingLeaderboardNotes = '''
Global Gaming Leaderboard System Design (e.g., Steam, Xbox Live)

SYSTEM OVERVIEW:
A global gaming leaderboard system handles millions of real-time score updates, player rankings, and competitive gaming data. The system provides instant rank calculations, anti-cheat measures, and high-performance sorting for massive player bases across multiple games.

CORE ARCHITECTURE COMPONENTS:
Client & Interface Layer:
- Game Clients: Integration with games for score submission and leaderboard display
- Mobile Apps: Leaderboard viewing and player statistics on mobile devices
- Web Dashboard: Comprehensive leaderboard views and player profiles
- API Gateway: Third-party integration for tournaments and esports platforms

Network & Communication Layer:
- Load Balancer: Distributes high-frequency score updates across servers
- API Gateway: Rate limiting and authentication for score submissions
- Real-time Sync: WebSocket connections for live leaderboard updates
- Regional Servers: Geographic distribution for low-latency score updates

APPLICATION LAYER:
- Score Processing Service: Validates and processes incoming game scores
- Ranking Engine: Real-time rank calculation and leaderboard generation
- Anti-cheat System: Anomaly detection and suspicious score validation
- Tournament Management: Competitive event organization and tracking
- Achievement System: Player badges, milestones, and recognition
- Statistics Engine: Player performance analytics and historical data

HIGH-PERFORMANCE STORAGE:
- Redis Sorted Sets: Primary data structure for fast ranking operations
- Key-Value Store: Player profiles and current rankings
- Time Series Database: Historical scores and performance trends
- SQL Database: Player accounts, game information, and tournament data
- In-Memory Cache: Hot leaderboard data for instant access

REAL-TIME PROCESSING:
- Stream Processor: Real-time score updates and rank recalculation
- Event Processing: Game completion events and score submissions
- Live Updates: Instant leaderboard changes pushed to connected clients
- Batch Processing: Periodic leaderboard cleanup and optimization

RANKING ALGORITHMS:
- ELO Rating System: Skill-based rating for competitive games
- Percentile Rankings: Player position relative to overall population
- Seasonal Rankings: Time-based leaderboard resets and competitions
- Multi-game Rankings: Cross-game player statistics and achievements

ANTI-CHEAT & VALIDATION:
- Score Validation: Server-side verification of submitted scores
- Anomaly Detection: Statistical analysis of unusual score patterns
- Rate Limiting: Prevents score submission abuse and gaming
- Audit Trail: Complete history of score changes and investigations

SHARDING & SCALABILITY:
- Horizontal Sharding: Distribute players across multiple database shards
- Regional Sharding: Geographic distribution for local leaderboards
- Game-specific Sharding: Separate leaderboards for different games
- Auto-scaling: Dynamic resource allocation based on player activity

ANALYTICS & INSIGHTS:
- Player Analytics: Detailed performance metrics and improvement tracking
- Game Balance: Statistical analysis for game difficulty balancing
- Competitive Intelligence: Tournament and esports data analysis
- Business Metrics: Player engagement and retention analytics

ARCHITECTURAL PATTERNS:
- Microservices: Distributed services for ranking, scores, anti-cheat, and analytics
- Event-Driven: Real-time score processing and rank updates
- Pub/Sub: Score update notifications and real-time updates broadcasting
- Caching: In-memory caching for hot leaderboard data
- Sharding: Horizontal sharding by game and region for scalability
- Replication: Score replication for high availability

SECURITY & INTEGRITY:
- Cryptographic Verification: Secure score submission with digital signatures
- Monitoring System: Real-time detection of cheating attempts and exploits
- Fair Play Enforcement: Automated penalties for cheating violations with competition integrity
- Data Integrity: Backup and recovery systems for leaderboard data

KEY CHARACTERISTICS:
- Real-time ranking with millisecond-level score updates and real-time updates
- High-performance sorted sets using Redis for instant rank queries
- Massive scale supporting millions of players across multiple games
- Anti-cheat systems with statistical anomaly detection
- Horizontal sharding for global player distribution
- Complex ranking algorithms including ELO and percentile systems
- Tournament and competitive gaming support with competition features
- Historical performance tracking and analytics
''';

  // =================================================================
  // SYSTEM CATEGORIZATION AND METADATA
  // =================================================================

  static const Map<String, Map<String, dynamic>> systemCategories = {
    'Tier 1: Foundational Systems': {
      'description': 'Perfect for learning core, fundamental concepts',
      'difficulty': 'Beginner to Intermediate',
      'systems': ['URL Shortener', 'Pastebin Service', 'Web Crawler'],
      'keyLearnings': [
        'Basic system design patterns',
        'Database design (SQL vs NoSQL)',
        'Caching strategies',
        'API design',
        'Load balancing fundamentals',
      ],
    },
    'Tier 2: Web-Scale Giants': {
      'description':
          'Covers systems that serve millions of users with complex features',
      'difficulty': 'Intermediate to Advanced',
      'systems': [
        'Social Media News Feed',
        'Video Streaming Service',
        'Ride-Sharing Service',
      ],
      'keyLearnings': [
        'Massive scale architecture',
        'Real-time systems',
        'Content delivery networks',
        'Machine learning integration',
        'Global distribution',
      ],
    },
    'Tier 3: Advanced & Specialized Systems': {
      'description':
          'Dives into complex, niche problems for experienced engineers',
      'difficulty': 'Advanced to Expert',
      'systems': [
        'Collaborative Editor',
        'Live Streaming Platform',
        'Global Gaming Leaderboard',
      ],
      'keyLearnings': [
        'Real-time collaboration',
        'Ultra-low latency systems',
        'Conflict resolution algorithms',
        'High-frequency data processing',
        'Specialized data structures',
      ],
    },
  };

  // =================================================================
  // QUICK REFERENCE MAPPING
  // =================================================================

  static const Map<String, String> systemNotesMapping = {
    'URL Shortener': urlShortenerNotes,
    'URL Shortener (e.g., TinyURL)': urlShortenerNotes,
    'Pastebin Service': pastebinServiceNotes,
    'Pastebin Service (e.g., Pastebin.com)': pastebinServiceNotes,
    'Web Crawler': webCrawlerNotes,
    'Social Media News Feed': socialMediaNewsFeedNotes,
    'Social Media News Feed (e.g., Facebook, X/Twitter)':
        socialMediaNewsFeedNotes,
    'Video Streaming Service': videoStreamingServiceNotes,
    'Video Streaming Service (e.g., Netflix, YouTube)':
        videoStreamingServiceNotes,
    'Ride-Sharing Service': rideSharingServiceNotes,
    'Ride-Sharing Service (e.g., Uber, Lyft)': rideSharingServiceNotes,
    'Collaborative Editor': collaborativeEditorNotes,
    'Collaborative Editor (e.g., Google Docs, Figma)': collaborativeEditorNotes,
    'Live Streaming Platform': liveStreamingPlatformNotes,
    'Global Gaming Leaderboard': globalGamingLeaderboardNotes,
  };

  // Helper method to get system notes by name
  static String? getSystemNotes(String systemName) {
    return systemNotesMapping[systemName];
  }

  // Helper method to get all system names
  static List<String> getAllSystemNames() {
    return systemCategories.values
        .expand((category) => category['systems'] as List<String>)
        .toList();
  }

  // Helper method to get systems by tier
  static List<String> getSystemsByTier(String tier) {
    return systemCategories[tier]?['systems'] ?? [];
  }
}
