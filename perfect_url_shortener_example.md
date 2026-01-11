# URL Shortener System Design - Comprehensive Architecture

## System Overview
A scalable URL shortener service like TinyURL that converts long URLs into short, shareable links with comprehensive analytics and high availability.

## Core Components

### 1. Client Layer
- **Web Browser & Mobile Client**: User interfaces for creating and accessing short URLs
- **CDN**: Cloudflare/Akamai for caching static content and redirect responses at edge locations
- **DNS Server**: GeoDNS for geographic routing to nearest region

### 2. Gateway & Security Layer
- **Global Load Balancer**: Distributes traffic across multiple regions with health checks
- **API Gateway**: Single entry point for all requests, handles routing and validation
- **Rate Limiter**: Token bucket algorithm to prevent abuse (100 requests/min per IP)
- **Firewall (WAF)**: Blocks malicious traffic and DDoS attacks
- **Authentication Service**: OAuth/JWT for user authentication and API key management

### 3. Application Layer
- **URL Shortening Service**: Generates unique short codes using Base62 encoding
- **URL Redirect Service**: Handles 301/302 HTTP redirects to original URLs
- **ID Generator Service**: Snowflake-based distributed ID generation for collision-free short codes
- **Fraud Detection Service**: ML-based detection of phishing URLs and malware
- **Security Scanner**: Integrates with Google Safe Browsing API

### 4. Caching Architecture (Multi-tier)
- **Browser Cache**: HTTP cache headers (Cache-Control, ETag) for instant redirects
- **CDN Cache**: Edge caching at 80+ locations globally with TTL-based invalidation
- **Redis Cache**: Distributed cache cluster with LRU eviction policy
- **In-Memory Cache**: Application-level cache-aside pattern for hot URLs
- **Cache Hierarchy**: Browser (0ms) → CDN (5ms) → Redis (2ms) → Database (10ms)

### 5. Storage Layer
- **SQL Database**: PostgreSQL with write-through caching for URL mappings
- **Key-Value Store**: Redis for fast lookups, stores mapping: short_code → original_url
- **NoSQL Database**: Cassandra for read-heavy workloads with eventual consistency
- **Time Series Database**: InfluxDB for analytics metrics storage
- **Data Warehouse**: BigQuery for historical analytics and reporting

### 6. Analytics Pipeline
- **Message Queue**: Kafka for buffering click events (1M+ events/sec)
- **Stream Processor**: Apache Flink for real-time event processing
- **Analytics Engine**: Complex event processing with click-through rate calculations
- **Metrics Collector**: Captures geo-IP location, device type, browser, referrer
- **Monitoring System**: Prometheus + Grafana for system health metrics

## Architecture Patterns

### Microservices Architecture
- **Service Mesh**: Istio with mTLS encryption between services
- **URL Generator Microservice**: Owns URL generation logic, scales independently
- **URL Resolver Microservice**: Optimized for read-heavy redirect workloads
- **Analytics Microservice**: Processes click events asynchronously
- **Configuration Service**: Centralized config management with feature flags
- **Database-per-service**: Each microservice owns its data store

### Scalability Strategy
- **Horizontal Scaling**: Add more server clusters as traffic grows (auto-scaling)
- **Database Sharding**: Shard by short code prefix for distributed storage
- **Consistent Hashing**: Distribute cache keys evenly across Redis cluster
- **Connection Pooling**: Reuse database connections for efficiency

### High Availability
- **Multi-Region Deployment**: Active-active setup in US-East, US-West, EU, Asia
- **Cross-Region Replication**: Sub-second replication lag between regions
- **Automatic Failover**: DNS-level failover when region goes down
- **Backup Service**: Point-in-time recovery with geo-redundant storage
- **Health Checks**: Continuous monitoring with automated incident response

### Caching Strategy
- **Write-Through**: New URLs written to cache and database simultaneously
- **Read-Through**: Cache misses fetch from database and populate cache
- **Cache Invalidation**: Pub/Sub notifications for cache coherency
- **TTL Management**: Popular URLs never expire, others have 7-day TTL

## Key Features

### URL Generation
- **Base62 Encoding**: Converts numeric IDs to short codes (a-z, A-Z, 0-9)
- **Collision Avoidance**: Distributed ID generation ensures uniqueness
- **Custom Short Codes**: Users can specify vanity URLs (premium feature)
- **Expiration Policies**: URLs can expire after time (1 hour, 1 day, never)

### Click Analytics
- **Real-time Tracking**: Every click logged with <50ms latency
- **Geo-IP Detection**: Country, city, ISP information
- **Device Detection**: Browser, OS, device type (mobile/desktop)
- **Referrer Tracking**: Know where clicks come from
- **Unique vs Returning Visitors**: Cookie-based tracking
- **Click Velocity**: Detect viral content with clicks per minute metrics

### Security Features
- **Malware Scanning**: Check destination URLs for viruses
- **Phishing Detection**: Block known phishing domains
- **Rate Limiting**: Per-user and global limits to prevent spam
- **HTTPS Enforcement**: All traffic encrypted with TLS 1.3
- **Audit Logging**: Complete trail for forensic investigation

### Performance Optimization
- **Adaptive Caching**: Popular links cached more aggressively
- **Database Read Replicas**: Scale reads across multiple replicas
- **Async Processing**: Click tracking doesn't block redirect response
- **CDN Push**: Pre-populate CDN with trending links

## Data Flow

### URL Creation Flow
1. User submits long URL → API Gateway validates request
2. Rate Limiter checks user quota → Security Scanner validates URL
3. ID Generator creates unique numeric ID → Base62 encoding creates short code
4. URL Shortening Service stores mapping in database (write-through to cache)
5. Response returns short URL: https://tiny.url/abc123

### URL Redirect Flow
1. User clicks short URL → DNS routes to nearest region
2. CDN checks edge cache → If hit, return 301 redirect (5ms total)
3. If miss, check Redis cache → If hit, return redirect (10ms total)
4. If miss, query database → Store in all cache layers
5. Async: Log click event to Kafka → Stream processor enriches with metadata
6. Analytics engine aggregates metrics → Store in time series database

## Scaling Numbers

### Current Scale
- 100 million active short URLs
- 10 billion redirects per month
- 1 million URL creations per day
- 99.99% uptime SLA

### Performance Metrics
- P50 redirect latency: 8ms
- P99 redirect latency: 50ms
- Cache hit rate: 95%
- Database queries: 5% of traffic

## Advanced Optimizations

### Edge Computing
- Deploy redirect logic at CDN edge for <5ms response
- Use Cloudflare Workers or AWS Lambda@Edge

### Bloom Filters
- Fast negative lookups: "Does this short code exist?"
- Reduces unnecessary database queries by 30%

### Eventual Consistency
- Accept slightly stale analytics data for better performance
- Use CRDT for conflict-free cross-region updates

### Cost Optimization
- Archive old URLs to cheaper cold storage (S3 Glacier)
- Compress analytics data older than 90 days
- Use spot instances for batch processing jobs

This architecture handles billions of redirects with sub-second latency, comprehensive analytics, and five-nines availability through distributed caching, microservices, and multi-region deployment.
