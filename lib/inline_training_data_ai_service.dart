import 'package:flutter/foundation.dart';
import 'evaluation_result.dart';

class InlineTrainingDataAIService {
  // Method to evaluate system design using inline training data logic
  static Future<EvaluationResult> evaluateDesign({
    required String question,
    required String answer,
  }) async {
    try {
      if (kDebugMode) {
        print('🤖 Starting Enhanced AI evaluation...');
        print(
          '📝 Question: ${question.substring(0, question.length > 50 ? 50 : question.length)}...',
        );
        print('📄 Answer length: ${answer.length} characters');
      }

      // Analyze the answer using training data patterns
      final scoreResult = _calculateScore(answer);
      final feedback = _generateFeedback(scoreResult, answer);
      final concepts = _extractConcepts(answer);

      if (kDebugMode) {
        print('🎯 Calculated score: ${scoreResult.finalScore}');
        print('📊 Keywords found: ${scoreResult.foundKeywords.length}');
        print('⚠️ Negative penalties: ${scoreResult.negativePenalties}');
        print('🔗 Relationship bonuses: ${scoreResult.relationshipBonuses}');
      }

      return EvaluationResult(
        score: scoreResult.finalScore,
        feedback: feedback,
        isSystemDesignRelated: true,
        concepts: concepts,
        category: 'training_data_inline_v2',
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Enhanced AI Error: $e');
        print('📚 Stack trace: $stackTrace');
      }

      return EvaluationResult(
        score: 0,
        feedback: '❌ Unexpected error in AI evaluation: $e',
        isSystemDesignRelated: true,
        concepts: [],
        category: 'error',
      );
    }
  }

  // ==========================================
  // EXPANDED KEYWORD DATABASE (200+ keywords)
  // ==========================================

  static const Map<String, int> _coreArchitecture = {
    // Microservices & Architecture (8-10 pts)
    'microservice': 10, 'microservices': 10, 'monolith': 8, 'monolithic': 8,
    'service oriented': 8,
    'soa': 6,
    'serverless': 8,
    'function as a service': 8,
    'faas': 6, 'distributed system': 10, 'distributed': 8,

    // API & Communication (6-8 pts)
    'api': 6, 'api gateway': 10, 'rest': 6, 'restful': 6, 'graphql': 8,
    'grpc': 8, 'websocket': 8, 'http': 4, 'https': 4, 'http/2': 6,
    'protocol buffer': 6, 'protobuf': 6, 'json': 4, 'xml': 4,

    // Services (6-8 pts)
    'service': 6, 'web service': 8, 'backend': 6, 'frontend': 6,
    'middleware': 6, 'proxy': 6, 'reverse proxy': 8,
  };

  static const Map<String, int> _databaseStorage = {
    // Relational Databases (6-10 pts)
    'database': 8, 'db': 6, 'sql': 6, 'mysql': 6, 'postgresql': 8,
    'postgres': 8, 'oracle': 6, 'sql server': 6, 'mariadb': 6,
    'relational database': 8, 'rdbms': 6, 'acid': 8, 'transaction': 6,

    // NoSQL Databases (6-10 pts)
    'nosql': 8, 'mongodb': 8, 'cassandra': 10, 'dynamodb': 8,
    'couchdb': 6, 'document database': 8, 'document store': 8,
    'key value': 8, 'key-value': 8, 'column family': 8, 'wide column': 8,

    // Graph & Specialized (6-10 pts)
    'graph database': 8, 'neo4j': 8, 'time series': 8, 'influxdb': 6,
    'timescaledb': 6, 'elasticsearch': 8, 'solr': 6, 'search engine': 8,

    // Data Storage (6-8 pts)
    'blob storage': 8, 's3': 8, 'object storage': 8, 'file storage': 6,
    'data warehouse': 8, 'data lake': 8, 'hdfs': 6, 'data mart': 6,
    'snowflake': 6, 'redshift': 6, 'bigquery': 6,
  };

  static const Map<String, int> _cachingPerformance = {
    // Caching Technologies (8-10 pts)
    'cache': 8, 'caching': 8, 'redis': 10, 'memcached': 8,
    'in-memory': 8, 'in memory': 8, 'memory cache': 8,
    'distributed cache': 10, 'cache layer': 8, 'caching layer': 8,
    'cache aside': 8, 'write through': 8, 'write back': 8,
    'cache invalidation': 10, 'ttl': 6, 'time to live': 6,

    // CDN (8-10 pts)
    'cdn': 10, 'content delivery': 10, 'content delivery network': 10,
    'cloudflare': 8, 'akamai': 8, 'fastly': 8, 'edge cache': 8,
    'edge server': 8, 'edge computing': 8,

    // Performance (6-8 pts)
    'performance': 8, 'latency': 8, 'throughput': 8, 'response time': 6,
    'optimization': 6, 'optimize': 6, 'bottleneck': 6, 'benchmark': 6,
  };

  static const Map<String, int> _scalability = {
    // Scaling Concepts (8-10 pts)
    'scale': 8, 'scaling': 8, 'scalability': 10, 'scalable': 8,
    'horizontal scaling': 10, 'vertical scaling': 8, 'scale out': 8,
    'scale up': 6, 'auto scaling': 10, 'auto-scaling': 10, 'autoscaling': 10,
    'elastic': 8, 'elasticity': 8,

    // Load Balancing (10 pts)
    'load balancer': 10, 'load balancing': 10, 'nginx': 8, 'haproxy': 8,
    'round robin': 6, 'least connections': 6, 'sticky session': 6,
    'health check': 8, 'traffic distribution': 8,

    // Partitioning (8-10 pts)
    'partition': 8, 'partitioning': 8, 'sharding': 10, 'shard': 8,
    'consistent hashing': 10, 'hash ring': 8, 'data partitioning': 10,
    'horizontal partitioning': 8, 'vertical partitioning': 8,
  };

  static const Map<String, int> _reliability = {
    // Fault Tolerance (10 pts)
    'fault tolerance': 10, 'fault tolerant': 10, 'high availability': 10,
    'ha': 6, 'availability': 8, 'resilience': 8, 'resilient': 8,
    'reliability': 10, 'reliable': 8, 'uptime': 6, 'sla': 6,
    'nine nines': 8, '99.9': 6, '99.99': 8,

    // Disaster Recovery (8-10 pts)
    'disaster recovery': 10, 'dr': 6, 'backup': 8, 'restore': 6,
    'recovery': 8, 'rpo': 8, 'rto': 8, 'point in time': 6,

    // Redundancy (8-10 pts)
    'redundancy': 10, 'redundant': 8, 'failover': 10, 'failback': 8,
    'active-passive': 8, 'active-active': 10, 'master-slave': 8,
    'primary-secondary': 8, 'replica': 8, 'replication': 10,
    'synchronous replication': 10, 'asynchronous replication': 8,

    // Circuit Breaker (8-10 pts)
    'circuit breaker': 10, 'bulkhead': 8, 'retry': 6, 'timeout': 6,
    'graceful degradation': 10, 'fallback': 8,
  };

  static const Map<String, int> _security = {
    // Core Security (8-10 pts)
    'security': 10, 'secure': 8, 'authentication': 10, 'authorization': 10,
    'auth': 6, 'oauth': 8, 'oauth2': 8, 'jwt': 8, 'json web token': 8,
    'sso': 8, 'single sign on': 8, 'mfa': 8, 'multi factor': 8,
    '2fa': 6, 'two factor': 6,

    // Encryption (8-10 pts)
    'encryption': 10, 'encrypt': 8, 'ssl': 8, 'tls': 8, 'https': 6,
    'certificate': 6, 'aes': 6, 'rsa': 6, 'hashing': 8, 'hash': 6,
    'bcrypt': 6, 'salt': 6, 'end to end': 8, 'e2e encryption': 8,

    // Access Control (8 pts)
    'rbac': 8, 'role based': 8, 'access control': 8, 'acl': 6,
    'permission': 6, 'privilege': 6, 'firewall': 8, 'waf': 8,
    'web application firewall': 8, 'ddos': 8, 'rate limiting': 10,
    'rate limiter': 10, 'throttling': 8, 'api key': 6,

    // Data Protection (8 pts)
    'data protection': 8, 'gdpr': 6, 'pci': 6, 'hipaa': 6,
    'compliance': 6, 'audit': 6, 'audit log': 8,
  };

  static const Map<String, int> _messagingAsync = {
    // Message Queues (8-10 pts)
    'message queue': 10, 'queue': 6, 'kafka': 10, 'rabbitmq': 10,
    'sqs': 8, 'amazon sqs': 8, 'activemq': 6, 'zeromq': 6,
    'redis pub sub': 8, 'pub sub': 8, 'publish subscribe': 8,

    // Event Driven (8-10 pts)
    'event driven': 10, 'event sourcing': 10, 'cqrs': 10,
    'command query': 8, 'event stream': 8, 'stream processing': 10,
    'kinesis': 8, 'event bus': 8,

    // Async Patterns (8 pts)
    'asynchronous': 8, 'async': 6, 'non-blocking': 8, 'producer consumer': 8,
    'worker': 6, 'job queue': 8, 'background job': 8, 'task queue': 8,
    'celery': 6, 'sidekiq': 6,
  };

  static const Map<String, int> _monitoring = {
    // Monitoring (6-10 pts)
    'monitor': 8, 'monitoring': 10, 'observability': 10, 'metrics': 8,
    'prometheus': 10, 'grafana': 8, 'datadog': 8, 'new relic': 6,
    'cloudwatch': 6, 'apm': 6, 'application monitoring': 8,

    // Logging (6-10 pts)
    'logging': 8, 'log': 6, 'logs': 6, 'elk': 8, 'elk stack': 10,
    'elasticsearch': 8, 'logstash': 6, 'kibana': 6, 'splunk': 8,
    'fluentd': 6, 'centralized logging': 10, 'log aggregation': 8,

    // Tracing (8-10 pts)
    'tracing': 10, 'distributed tracing': 10, 'jaeger': 8, 'zipkin': 8,
    'opentelemetry': 8, 'trace': 6, 'span': 6, 'correlation id': 8,

    // Alerting (6-8 pts)
    'alerting': 8, 'alert': 6, 'pagerduty': 6, 'opsgenie': 6,
    'incident': 6, 'on-call': 6,
  };

  static const Map<String, int> _containerization = {
    // Containers (8-10 pts)
    'container': 10, 'docker': 10, 'containerization': 10,
    'dockerfile': 6, 'image': 6, 'container image': 8,

    // Orchestration (10 pts)
    'kubernetes': 10, 'k8s': 8, 'orchestration': 8, 'pod': 8,
    'deployment': 6, 'service mesh': 10, 'istio': 10, 'linkerd': 8,
    'envoy': 8, 'sidecar': 8, 'helm': 6, 'kubectl': 6,

    // Platforms (6-8 pts)
    'eks': 6, 'gke': 6, 'aks': 6, 'openshift': 6, 'rancher': 6,
    'docker swarm': 6, 'mesos': 6, 'nomad': 6,
  };

  static const Map<String, int> _cloudServices = {
    // Cloud Providers (6-8 pts)
    'aws': 8, 'amazon web services': 8, 'azure': 8, 'microsoft azure': 8,
    'gcp': 8, 'google cloud': 8, 'cloud': 6, 'multi cloud': 8,
    'hybrid cloud': 8, 'private cloud': 6, 'public cloud': 6,

    // AWS Services (6-8 pts)
    'ec2': 6, 'lambda': 8, 'rds': 6, 'aurora': 8, 'dynamodb': 8,
    'sns': 6, 'sqs': 8, 'cloudfront': 6, 'route53': 6,
    'ecs': 6, 'fargate': 6, 'elastic beanstalk': 6,

    // Infrastructure (6-8 pts)
    'iaas': 6, 'paas': 6, 'saas': 6, 'infrastructure as code': 10,
    'iac': 6, 'terraform': 10, 'cloudformation': 8, 'ansible': 8,
    'puppet': 6, 'chef': 6,
  };

  static const Map<String, int> _dataProcessing = {
    // Big Data (8-10 pts)
    'big data': 8, 'hadoop': 8, 'spark': 10, 'apache spark': 10,
    'mapreduce': 8, 'map reduce': 8, 'hive': 6, 'pig': 6,
    'presto': 6, 'flink': 8, 'apache flink': 8,

    // ETL & Pipelines (8-10 pts)
    'etl': 10, 'extract transform load': 10, 'data pipeline': 10,
    'pipeline': 6, 'batch processing': 10, 'stream processing': 10,
    'real-time': 8, 'real time': 8, 'near real-time': 8,
    'airflow': 8, 'dag': 6, 'workflow': 6,

    // ML/AI (6-8 pts)
    'machine learning': 8, 'ml': 6, 'ai': 6, 'artificial intelligence': 8,
    'model serving': 8, 'inference': 6, 'training': 6,
    'recommendation': 8, 'recommendation engine': 10,
  };

  static const Map<String, int> _consistencyPatterns = {
    // CAP Theorem (10 pts)
    'cap theorem': 10, 'cap': 6, 'consistency': 10, 'partition tolerance': 10,
    'eventual consistency': 10, 'strong consistency': 10,

    // Consensus (8-10 pts)
    'consensus': 10, 'raft': 10, 'paxos': 10, 'leader election': 10,
    'quorum': 10, 'two phase commit': 10, '2pc': 8, 'three phase commit': 8,
    'saga': 10, 'saga pattern': 10, 'distributed transaction': 10,

    // Isolation Levels (6-8 pts)
    'isolation': 6, 'serializable': 6, 'read committed': 6,
    'repeatable read': 6, 'snapshot isolation': 6,
  };

  static const Map<String, int> _canvasIcons = {
    // Client & Interface
    'mobile client': 6, 'desktop client': 6, 'tablet client': 6,
    'web browser': 6, 'user': 4, 'admin user': 6, 'group users': 6,

    // Network & Communication
    'router': 6, 'network hub': 6, 'internet connection': 6,
    'global network': 6, 'dns server': 8, 'proxy server': 8,
    'websocket server': 8, 'global load balancer': 10,

    // Servers & Computing
    'web server': 8, 'application server': 10, 'api server': 8,
    'single server': 6, 'server cluster': 10, 'virtual machine': 8, 'vm': 6,

    // Caching & Performance
    'redis cache': 10, 'in-memory cache': 10, 'cdn cache': 8,
    'browser cache': 6, 'application cache': 8, 'cache layer': 8,

    // Message Systems
    'event stream': 8, 'publisher': 6, 'subscriber': 6,
    'notification service': 8, 'email service': 6, 'sms service': 6,
    'push notification': 8, 'crawl queue': 6,

    // Security & Monitoring
    'security gateway': 10, 'monitoring system': 10, 'analytics service': 8,
    'logging service': 8, 'metrics collector': 8, 'alert system': 8,
    'content moderation': 6, 'drm system': 6, 'anti-cheat system': 6,
    'fraud detection': 8, 'security scanner': 6,

    // Cloud & Infrastructure
    'cloud service': 8, 'cloud storage': 8, 'cloud database': 8,
    'backup service': 8, 'sync service': 6, 'geographic region': 8,
    'data center': 8,

    // System Utilities
    'configuration service': 8, 'scheduler': 6, 'auto-scaling group': 10,
    'api manager': 8, 'version control': 6, 'build system': 6,
    'deployment pipeline': 8, 'ci/cd': 10, 'cicd': 8,

    // Data Processing
    'stream processor': 10, 'batch processor': 10, 'etl pipeline': 10,
    'data pipeline': 10, 'recommendation engine': 10, 'ml model': 8,
    'analytics engine': 8, 'video transcoding': 8, 'video processing': 8,
    'image processing': 6, 'thumbnail generator': 6,

    // External Services
    'third party api': 6, 'payment gateway': 10, 'social media api': 6,
    'map service': 6, 'weather service': 6, 'file upload service': 8,
    'video streaming': 8,

    // Application Services
    'feed generation': 8, 'social graph service': 10, 'content publishing': 6,
    'user presence': 8, 'comment system': 6, 'chat service': 8,
    'url shortening service': 8, 'url redirect service': 6,
    'content storage': 6, 'content retrieval': 6, 'expiration service': 6,
    'crawl coordinator': 8, 'url discovery': 6, 'content extractor': 6,
    'duplicate detection': 8, 'matching engine': 10, 'routing service': 8,
    'pricing engine': 8, 'trip management': 6, 'ranking engine': 10,
    'score processing': 6, 'tournament manager': 6, 'achievement system': 6,
    'document service': 6, 'collaboration engine': 10, 'stream management': 8,
    'video upload': 6, 'video ingest': 6,

    // Geospatial & Location
    'location service': 8, 'geospatial database': 10, 'geohashing': 10,
    'quadtree': 10, 'gps tracking': 8, 'map routing': 8,
  };

  // ==========================================
  // NEGATIVE KEYWORDS (Penalty Detection)
  // ==========================================

  static const Map<String, int> _negativeKeywords = {
    // Wrong approaches
    'single point of failure': -10,
    'spof': -8,
    'no backup': -10,
    'without backup': -8,
    'without cache': -6,
    'without authentication': -10,
    'no security': -15,
    'without security': -12,
    'no encryption': -10,
    'unencrypted': -8,
    'plaintext password': -15,
    'plain text password': -15,
    'hardcoded': -6,
    'hard coded': -6,
    'no monitoring': -8,
    'without monitoring': -6,
    'no logging': -6,

    // Bad practices
    'tight coupling': -8,
    'tightly coupled': -8,
    'god class': -6,
    'spaghetti': -6,
    'monolithic without': -6,

    // Contradictions (detect wrong statements)
    'sql is nosql': -10,
    'nosql is sql': -10,
    'synchronous async': -8,
  };

  // ==========================================
  // CONCEPT RELATIONSHIPS (Bonus for proper combinations)
  // ==========================================

  static const Map<String, List<String>> _conceptRelationships = {
    // If microservices → expect these
    'microservice': [
      'api gateway',
      'service discovery',
      'load balancer',
      'message queue',
      'docker',
      'kubernetes',
    ],
    'microservices': [
      'api gateway',
      'service discovery',
      'load balancer',
      'message queue',
      'docker',
      'kubernetes',
    ],

    // If database → expect these
    'database': ['backup', 'replication', 'index', 'query', 'transaction'],
    'sql': ['acid', 'transaction', 'join', 'index', 'normalization'],
    'nosql': [
      'eventual consistency',
      'partition',
      'horizontal scaling',
      'document',
    ],

    // If cache → expect these
    'cache': ['ttl', 'invalidation', 'eviction', 'redis', 'memcached'],
    'redis': ['cache', 'pub sub', 'cluster', 'sentinel'],

    // If scaling → expect these
    'horizontal scaling': ['load balancer', 'stateless', 'partition'],
    'load balancer': ['health check', 'round robin', 'server', 'nginx'],

    // If kafka → expect these
    'kafka': [
      'topic',
      'partition',
      'consumer',
      'producer',
      'broker',
      'zookeeper',
    ],

    // If kubernetes → expect these
    'kubernetes': ['pod', 'deployment', 'service', 'ingress', 'container'],
    'k8s': ['pod', 'deployment', 'service', 'ingress', 'container'],

    // If high availability → expect these
    'high availability': [
      'redundancy',
      'failover',
      'replication',
      'load balancer',
    ],
    'fault tolerance': ['circuit breaker', 'retry', 'fallback', 'bulkhead'],

    // If security → expect these
    'authentication': ['oauth', 'jwt', 'session', 'token'],
    'authorization': ['rbac', 'permission', 'role', 'access control'],

    // If monitoring → expect these
    'monitoring': ['metrics', 'alert', 'dashboard', 'prometheus', 'grafana'],
    'observability': ['logging', 'tracing', 'metrics'],
  };

  // ==========================================
  // SCORE CALCULATION
  // ==========================================

  static _ScoreResult _calculateScore(String answer) {
    int baseScore = 0;
    int negativePenalties = 0;
    int relationshipBonuses = 0;
    final lowerAnswer = answer.toLowerCase();
    final foundKeywords = <String>[];
    final foundRelationships = <String>[];
    final negativeFindings = <String>[];

    // Combine all keyword maps
    final allKeywords = <String, int>{
      ..._coreArchitecture,
      ..._databaseStorage,
      ..._cachingPerformance,
      ..._scalability,
      ..._reliability,
      ..._security,
      ..._messagingAsync,
      ..._monitoring,
      ..._containerization,
      ..._cloudServices,
      ..._dataProcessing,
      ..._consistencyPatterns,
      ..._canvasIcons,
    };

    // Count positive keywords
    allKeywords.forEach((keyword, points) {
      if (lowerAnswer.contains(keyword)) {
        baseScore += points;
        foundKeywords.add(keyword);
      }
    });

    // Check negative keywords (penalties)
    _negativeKeywords.forEach((keyword, penalty) {
      if (lowerAnswer.contains(keyword)) {
        negativePenalties += penalty.abs();
        negativeFindings.add(keyword);
      }
    });

    // Check concept relationships (bonuses)
    _conceptRelationships.forEach((mainConcept, relatedConcepts) {
      if (lowerAnswer.contains(mainConcept)) {
        int relatedFound = 0;
        for (final related in relatedConcepts) {
          if (lowerAnswer.contains(related)) {
            relatedFound++;
          }
        }
        // Bonus for having related concepts (up to 3 per main concept)
        if (relatedFound > 0) {
          final bonus = (relatedFound.clamp(1, 3)) * 5;
          relationshipBonuses += bonus;
          foundRelationships.add('$mainConcept + $relatedFound related');
        }
      }
    });

    // Length and detail bonus
    final lengthBonus = (answer.length / 100).floor().clamp(0, 20);
    baseScore += lengthBonus;

    // Word count bonus for detailed explanations
    final wordCount = answer.split(' ').length;
    final wordBonus = (wordCount / 50).floor().clamp(0, 15);
    baseScore += wordBonus;

    // Specific metrics bonus (numbers with units)
    if (answer.contains(
      RegExp(
        r'\d+\s*(ms|millisecond|seconds?|minutes?|hours?|requests?|req/s|qps|tps|users?|GB|MB|KB|TB|PB|%|rps)',
        caseSensitive: false,
      ),
    )) {
      baseScore += 12; // Bonus for specific numbers/metrics
    }

    // Trade-off discussion bonus
    if (lowerAnswer.contains('trade-off') ||
        lowerAnswer.contains('tradeoff') ||
        lowerAnswer.contains('trade off') ||
        lowerAnswer.contains('versus') ||
        lowerAnswer.contains(' vs ') ||
        lowerAnswer.contains('pros and cons') ||
        lowerAnswer.contains('advantage') ||
        lowerAnswer.contains('disadvantage')) {
      baseScore += 8;
    }

    // Diagram/visual reference bonus
    if (lowerAnswer.contains('diagram') ||
        lowerAnswer.contains('flowchart') ||
        lowerAnswer.contains('architecture diagram') ||
        lowerAnswer.contains('component diagram')) {
      baseScore += 5;
    }

    // Calculate final score
    final rawScore = baseScore + relationshipBonuses - negativePenalties;
    final finalScore = rawScore.clamp(0, 100);

    return _ScoreResult(
      baseScore: baseScore,
      negativePenalties: negativePenalties,
      relationshipBonuses: relationshipBonuses,
      finalScore: finalScore,
      foundKeywords: foundKeywords,
      foundRelationships: foundRelationships,
      negativeFindings: negativeFindings,
    );
  }

  // ==========================================
  // FEEDBACK GENERATION
  // ==========================================

  static String _generateFeedback(_ScoreResult scoreResult, String answer) {
    final lowerAnswer = answer.toLowerCase();
    final feedbackParts = <String>[];
    final score = scoreResult.finalScore;

    // Status indicator based on score
    if (score >= 80) {
      feedbackParts.add(
        '🏆 **Outstanding!** Exceptional system design with comprehensive coverage and depth.',
      );
    } else if (score >= 70) {
      feedbackParts.add(
        '✅ **Excellent!** Strong system design with good technical coverage.',
      );
    } else if (score >= 55) {
      feedbackParts.add(
        '👍 **Good Foundation!** Solid understanding but room for more depth.',
      );
    } else if (score >= 40) {
      feedbackParts.add(
        '⚠️ **Needs Improvement.** Cover more architectural components and patterns.',
      );
    } else {
      feedbackParts.add(
        '❌ **Insufficient.** Response lacks essential system design concepts.',
      );
    }

    // Statistics
    feedbackParts.add('\n\n**📊 Analysis:**');
    feedbackParts.add(
      '• Keywords detected: ${scoreResult.foundKeywords.length}',
    );
    if (scoreResult.relationshipBonuses > 0) {
      feedbackParts.add(
        '• Concept relationships: +${scoreResult.relationshipBonuses} pts',
      );
    }
    if (scoreResult.negativePenalties > 0) {
      feedbackParts.add(
        '• Penalties applied: -${scoreResult.negativePenalties} pts',
      );
    }

    // Negative findings warning
    if (scoreResult.negativeFindings.isNotEmpty) {
      feedbackParts.add('\n\n**⚠️ Issues Detected:**');
      for (final issue in scoreResult.negativeFindings.take(3)) {
        feedbackParts.add('• Concern: "$issue"');
      }
    }

    // Strengths section
    if (score > 25) {
      final strengths = <String>[];

      if (lowerAnswer.contains('microservice') ||
          lowerAnswer.contains('distributed')) {
        strengths.add('Distributed systems architecture');
      }
      if (lowerAnswer.contains('kubernetes') ||
          lowerAnswer.contains('docker')) {
        strengths.add('Container orchestration knowledge');
      }
      if (lowerAnswer.contains('load balancer') ||
          lowerAnswer.contains('scaling')) {
        strengths.add('Scalability considerations');
      }
      if (lowerAnswer.contains('cache') || lowerAnswer.contains('redis')) {
        strengths.add('Performance optimization with caching');
      }
      if (lowerAnswer.contains('kafka') ||
          lowerAnswer.contains('message queue')) {
        strengths.add('Asynchronous communication patterns');
      }
      if (lowerAnswer.contains('security') ||
          lowerAnswer.contains('authentication')) {
        strengths.add('Security awareness');
      }
      if (lowerAnswer.contains('monitoring') ||
          lowerAnswer.contains('observability')) {
        strengths.add('Operational monitoring');
      }
      if (lowerAnswer.contains('database') && lowerAnswer.contains('replica')) {
        strengths.add('Data layer reliability');
      }
      if (lowerAnswer.contains('cap') || lowerAnswer.contains('consistency')) {
        strengths.add('Distributed systems theory');
      }
      if (lowerAnswer.contains('circuit breaker') ||
          lowerAnswer.contains('fault tolerance')) {
        strengths.add('Resilience patterns');
      }

      if (strengths.isNotEmpty) {
        feedbackParts.add('\n\n**✅ Strengths:**');
        for (final strength in strengths.take(5)) {
          feedbackParts.add('• $strength');
        }
      }
    }

    // Areas for improvement
    final improvements = <String>[];

    // Core areas check
    if (!lowerAnswer.contains('load balancer') &&
        !lowerAnswer.contains('scaling')) {
      improvements.add('Add load balancing and scaling strategy');
    }
    if (!lowerAnswer.contains('cache') && !lowerAnswer.contains('redis')) {
      improvements.add('Include caching layer for performance');
    }
    if (!lowerAnswer.contains('database') && !lowerAnswer.contains('storage')) {
      improvements.add('Discuss data storage and database choices');
    }
    if (!lowerAnswer.contains('security') && !lowerAnswer.contains('auth')) {
      improvements.add('Address security and authentication');
    }
    if (!lowerAnswer.contains('monitor') &&
        !lowerAnswer.contains('logging') &&
        !lowerAnswer.contains('observability')) {
      improvements.add('Add monitoring and observability');
    }
    if (!lowerAnswer.contains('fault') &&
        !lowerAnswer.contains('failover') &&
        !lowerAnswer.contains('redundan')) {
      improvements.add('Discuss fault tolerance and redundancy');
    }
    if (!lowerAnswer.contains('api gateway') &&
        lowerAnswer.contains('microservice')) {
      improvements.add('Consider API Gateway for microservices');
    }

    // Advanced areas check
    if (!lowerAnswer.contains('trade') &&
        !lowerAnswer.contains('pros') &&
        !lowerAnswer.contains('cons')) {
      improvements.add('Analyze trade-offs in your design choices');
    }
    if (!answer.contains(
      RegExp(r'\d+\s*(ms|seconds?|GB|requests?)', caseSensitive: false),
    )) {
      improvements.add('Include specific capacity numbers and metrics');
    }
    if (answer.split(' ').length < 100) {
      improvements.add('Expand explanation with more architectural detail');
    }
    if (!lowerAnswer.contains('eventual') &&
        !lowerAnswer.contains('strong consistency') &&
        !lowerAnswer.contains('cap')) {
      improvements.add('Consider consistency model (CAP theorem)');
    }

    if (improvements.isNotEmpty) {
      feedbackParts.add('\n\n**📈 Areas to Improve:**');
      for (final improvement in improvements.take(5)) {
        feedbackParts.add('• $improvement');
      }
    }

    // Concept relationship suggestions
    if (score < 70 && scoreResult.foundRelationships.isEmpty) {
      feedbackParts.add('\n\n**💡 Tip:** Connect your concepts! For example:');
      feedbackParts.add('• Microservices + API Gateway + Service Discovery');
      feedbackParts.add('• Database + Replication + Backup');
      feedbackParts.add('• Cache + TTL + Invalidation strategy');
    }

    return feedbackParts.join('\n');
  }

  // ==========================================
  // CONCEPT EXTRACTION
  // ==========================================

  static List<String> _extractConcepts(String answer) {
    final concepts = <String>[];
    final lowerAnswer = answer.toLowerCase();

    final conceptMap = {
      'Microservices': ['microservice', 'microservices', 'service mesh'],
      'API Design': ['api', 'rest', 'graphql', 'grpc', 'api gateway'],
      'Database': [
        'database',
        'db',
        'sql',
        'nosql',
        'mongodb',
        'postgresql',
        'mysql',
      ],
      'Caching': ['cache', 'caching', 'redis', 'memcached', 'cdn'],
      'Load Balancing': ['load balancer', 'load balancing', 'nginx', 'haproxy'],
      'Scaling': ['scale', 'scaling', 'horizontal', 'vertical', 'auto scaling'],
      'Partitioning': ['partition', 'sharding', 'consistent hashing'],
      'Security': [
        'security',
        'auth',
        'authentication',
        'ssl',
        'encryption',
        'jwt',
      ],
      'Monitoring': [
        'monitor',
        'monitoring',
        'logging',
        'observability',
        'prometheus',
      ],
      'Message Queues': [
        'message queue',
        'queue',
        'kafka',
        'rabbitmq',
        'pub sub',
      ],
      'Containers': ['docker', 'kubernetes', 'k8s', 'container', 'pod'],
      'Cloud Services': ['aws', 'azure', 'gcp', 'cloud', 'lambda', 'ec2'],
      'Fault Tolerance': [
        'fault tolerance',
        'failover',
        'redundancy',
        'circuit breaker',
        'disaster recovery',
      ],
      'Consistency': [
        'cap',
        'consistency',
        'eventual consistency',
        'strong consistency',
        'consensus',
      ],
      'Data Processing': [
        'etl',
        'pipeline',
        'batch',
        'stream processing',
        'spark',
        'hadoop',
      ],
      'Performance': ['performance', 'latency', 'throughput', 'optimization'],
    };

    conceptMap.forEach((concept, keywords) {
      for (final keyword in keywords) {
        if (lowerAnswer.contains(keyword)) {
          if (!concepts.contains(concept)) {
            concepts.add(concept);
          }
          break;
        }
      }
    });

    return concepts;
  }
}

// ==========================================
// HELPER CLASS FOR SCORE RESULT
// ==========================================

class _ScoreResult {
  final int baseScore;
  final int negativePenalties;
  final int relationshipBonuses;
  final int finalScore;
  final List<String> foundKeywords;
  final List<String> foundRelationships;
  final List<String> negativeFindings;

  _ScoreResult({
    required this.baseScore,
    required this.negativePenalties,
    required this.relationshipBonuses,
    required this.finalScore,
    required this.foundKeywords,
    required this.foundRelationships,
    required this.negativeFindings,
  });
}
