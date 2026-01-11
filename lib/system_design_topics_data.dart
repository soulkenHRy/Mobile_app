class SystemDesignTopicsData {
  static Map<String, List<Map<String, String>>> getTopicData() {
    return {
      'Performance & Optimization': [
        {
          'title': 'Latency',
          'definition': 'How long it takes for one request to get a response',
          'example': 'Time between asking a question and getting an answer',
          'importance': 'Users hate waiting for apps to respond',
        },
        {
          'title': 'Throughput',
          'definition': 'How much work a system can do in a given time period',
          'example': 'How many customers a restaurant can serve per hour',
          'importance': 'Determines how many users your system can handle',
        },
        {
          'title': 'Memory (RAM) vs SSD vs Internet vs Global Network',
          'definition': 'Different storage and transmission speeds',
          'additional':
              'RAM: Like your desk - super fast to access but limited space\nSSD: Like a filing cabinet in your room - fast but slower than desk\nInternet: Like ordering something online - takes time to travel\nGlobal Network: Like shipping internationally - longest travel time',
        },
        {
          'title': 'Caching',
          'definition':
              'Keeping frequently used items close by for quick access',
          'example':
              'Keeping snacks in your room instead of walking to the kitchen every time',
          'additional':
              'When NOT to use: When data changes constantly (like live sports scores)',
        },
        {
          'title': 'Cache Hits',
          'definition':
              'When the data you want is already stored in the fast cache',
          'example':
              'Finding the book you need on your desk instead of going to the library',
          'importance': 'Much faster than getting data from the main database',
        },
        {
          'title': 'In-memory Caching',
          'definition': 'Storing data in super-fast computer memory (RAM)',
          'additional':
              'Limitation: Data disappears when power goes out\nTrade-off: Speed vs permanence',
        },
      ],
      'Scalability & Distribution': [
        {
          'title': 'Horizontal Scaling',
          'definition': 'Adding more machines to handle more work',
          'example':
              'Hiring more cashiers instead of making one cashier work faster',
          'additional':
              'Alternative: Vertical scaling (making one machine more powerful)',
        },
        {
          'title': 'Vertical Scaling',
          'definition': 'Making existing machines more powerful',
          'example': 'Giving one cashier a faster cash register',
          'additional': 'Limitation: Eventually you hit hardware limits',
        },
        {
          'title': 'Load Balancing',
          'definition': 'Distributing work evenly across multiple servers',
          'example': 'A hostess directing customers to different empty tables',
          'importance': 'Prevents any single server from getting overwhelmed',
        },
        {
          'title': 'Round-robin Load Balancing',
          'definition':
              'Taking turns - send first request to server A, second to server B, third to server C, then back to A',
          'example': 'Dealing cards in a circle',
          'additional': 'When to use: When all servers are equally powerful',
        },
        {
          'title': 'Client-IP-based Load Balancing',
          'definition': 'Always sending the same user to the same server',
          'example':
              'Having a "regular customer" always served by the same waiter',
          'importance': 'Maintains user sessions and shopping carts',
        },
        {
          'title': 'Server-health-based Load Balancing',
          'definition': 'Only sending work to servers that aren\'t struggling',
          'example':
              'Not giving more tasks to someone who\'s already overwhelmed',
          'additional':
              'How it works: Monitors CPU, memory usage, and response times',
        },
        {
          'title': 'Sharding',
          'definition':
              'Splitting a large database into smaller pieces across multiple servers',
          'example':
              'Organizing a massive library by dividing books into different buildings',
          'importance':
              'One database can\'t handle all the data for millions of users',
        },
        {
          'title': 'Data Distribution',
          'definition': 'Spreading data across multiple storage locations',
          'additional':
              'Benefit: No single storage location gets overloaded\nChallenge: Need to keep track of where everything is stored',
        },
        {
          'title': 'Hot Spots',
          'definition':
              'Parts of the system that get much more traffic than others',
          'example': 'One checkout line having way more customers than others',
          'additional': 'Problem: Can overwhelm that part of the system',
        },
        {
          'title': 'Consistent Hashing',
          'definition':
              'A method to distribute data that minimizes reshuffling when adding/removing servers',
          'example':
              'A seating arrangement that requires moving fewest people when adding a new table',
          'importance':
              'Adding servers doesn\'t require moving all existing data',
        },
      ],
      'Database & Storage Systems': [
        {
          'title': 'SQL Databases',
          'definition':
              'Databases that organize data in tables with rows and columns',
          'example': 'Excel spreadsheets with strict rules',
          'additional':
              'Examples: MySQL, PostgreSQL\nBest for: Structured data that needs to follow strict rules',
        },
        {
          'title': 'NoSQL Databases',
          'definition': 'Databases that don\'t use traditional table structure',
          'example':
              'A flexible filing system that can hold any type of document',
          'additional':
              'When to use: When data structure varies or you need to scale quickly',
        },
        {
          'title': 'Graph Databases',
          'definition':
              'Databases designed to store relationships between things',
          'example':
              'A map showing how people are connected (friends, family, coworkers)',
          'additional':
              'Example: Neo4j\nBest for: Social networks, recommendation systems',
        },
        {
          'title': 'Time Series Databases',
          'definition': 'Databases specialized for data that changes over time',
          'example': 'Recording temperature every minute for a year',
          'additional':
              'Example: Prometheus\nBest for: Monitoring, stock prices, sensor data',
        },
        {
          'title': 'Key-Value Stores',
          'definition':
              'Simple databases that store data as pairs (like a dictionary)',
          'example': 'Phone book - name (key) → phone number (value)',
          'additional':
              'Examples: Redis, Etcd, ZooKeeper\nBest for: Caching, session storage, simple lookups',
        },
        {
          'title': 'Blob Stores',
          'definition':
              'Storage systems designed for large files like photos and videos',
          'example': 'A warehouse for storing big items',
          'additional':
              'Examples: Amazon S3, Google Cloud Storage\nBest for: Images, videos, documents, backups',
        },
        {
          'title': 'Object Storage',
          'definition':
              'Storage that treats each file as a separate object with metadata',
          'example':
              'A safety deposit box system where each box has a unique ID',
          'additional':
              'Why different: No folders or hierarchy like traditional file systems',
        },
        {
          'title': 'HDFS (Hadoop Distributed File System)',
          'definition': 'A way to store huge files across many computers',
          'example':
              'Storing a massive book by putting different chapters on different shelves',
          'additional': 'Purpose: Handle files too big for any single computer',
        },
      ],
      'Data Consistency & Reliability': [
        {
          'title': 'ACID Properties',
          'definition':
              'Four rules that ensure database transactions are reliable',
          'additional':
              'Atomicity: All parts of a transaction succeed or all fail (no half-completed actions)\nConsistency: Data always follows the rules you set\nIsolation: Multiple operations don\'t interfere with each other\nDurability: Once saved, data won\'t be lost even if power goes out',
        },
        {
          'title': 'BASE Model',
          'definition':
              'Alternative to ACID that prioritizes availability over consistency',
          'additional':
              'Trade-off: System stays online even if some data is temporarily inconsistent\nWhen used: Large distributed systems where perfect consistency is less important than availability',
        },
        {
          'title': 'Eventually Consistent Systems',
          'definition':
              'System where all copies of data will match eventually, but not immediately',
          'example':
              'News spreading through word of mouth - everyone eventually hears it, but not at the same time',
          'additional':
              'Trade-off: Speed and availability vs immediate consistency',
        },
        {
          'title': 'Stale Data',
          'definition': 'Old information that hasn\'t been updated yet',
          'example': 'Reading yesterday\'s newspaper for today\'s weather',
          'additional':
              'When it happens: In caching or eventually consistent systems',
        },
        {
          'title': 'Consensus Algorithms',
          'definition': 'Methods for multiple computers to agree on something',
          'example': 'How a group of friends decides which restaurant to go to',
          'importance': 'Prevents conflicts in distributed systems',
        },
        {
          'title': 'Paxos',
          'definition': 'A specific algorithm for getting computers to agree',
          'example': 'A formal voting procedure with specific rules',
          'additional':
              'Known for: Being mathematically correct but complex to implement',
        },
        {
          'title': 'Raft',
          'definition':
              'Another algorithm for computer agreement, simpler than Paxos',
          'example': 'Simplified voting procedure that\'s easier to understand',
          'additional':
              'Why popular: Easier to implement and understand than Paxos',
        },
        {
          'title': 'Leader Election',
          'definition':
              'Process of choosing which computer makes important decisions',
          'example': 'Electing a team captain',
          'importance':
              'Prevents multiple computers from making conflicting decisions',
        },
        {
          'title': 'Idempotency',
          'definition':
              'Operations that have the same result even if done multiple times',
          'example':
              'Turning on a light switch - doesn\'t matter if you flip it multiple times, light is still on',
          'importance':
              'Makes systems more reliable when messages might be duplicated',
        },
      ],
      'Messaging & Communication': [
        {
          'title': 'Pub/Sub Systems',
          'definition':
              'Messaging system where senders (publishers) don\'t send directly to receivers (subscribers)',
          'example':
              'Newspaper delivery - publishers write, delivery service distributes to subscribers',
          'additional':
              'Benefits: Senders and receivers don\'t need to know about each other',
        },
        {
          'title': 'Publisher/Subscriber Pattern',
          'definition':
              'Communication pattern where message senders and receivers are independent',
          'example': 'Social media notifications',
          'additional':
              'How it works: Publishers post messages to topics, subscribers listen to topics they care about',
        },
        {
          'title': 'Message Delivery Guarantees',
          'definition':
              'Promises about whether and how messages will be delivered',
          'additional':
              'Types: At-most-once, at-least-once, exactly-once\nTrade-offs: Reliability vs performance',
        },
        {
          'title': 'At-least-once Delivery',
          'definition':
              'Promise that every message will be delivered, but some might be delivered multiple times',
          'example':
              'Making sure everyone gets invited to a party, even if some get multiple invitations',
          'importance': 'Better to get duplicates than miss important messages',
        },
        {
          'title': 'Message Ordering',
          'definition':
              'Ensuring messages arrive in the same order they were sent',
          'example': 'Text messages arriving in the order you sent them',
          'importance': 'Prevents confusing conversations or incorrect data',
        },
        {
          'title': 'Message Replayability',
          'definition': 'Ability to re-send or re-process old messages',
          'example': 'Being able to replay a voicemail message',
          'additional':
              'Use case: Recovery when systems crash or for debugging',
        },
        {
          'title': 'Streaming vs Request-Response',
          'definition': 'Two different communication patterns',
          'additional':
              'Streaming: Continuous flow of data (like watching live TV)\nRequest-Response: Ask for something specific and get an answer (like ordering from a menu)\nWhen to use each: Streaming for real-time data, request-response for specific queries',
        },
      ],
      'Network & Security': [
        {
          'title': 'HTTP (Hypertext Transfer Protocol)',
          'definition':
              'The language web browsers and servers use to communicate',
          'example':
              'A standardized way for customers and shop owners to communicate',
          'importance': 'Foundation of how the web works',
        },
        {
          'title': 'TCP (Transmission Control Protocol)',
          'definition':
              'A reliable way for computers to send data over networks',
          'example': 'Registered mail - guarantees delivery and correct order',
          'additional':
              'Features: Error checking, guaranteed delivery, correct ordering',
        },
        {
          'title': 'IP (Internet Protocol)',
          'definition':
              'System that gives every computer an address and routes data between them',
          'example': 'Postal address system for the internet',
          'additional': 'Purpose: Ensures data gets from source to destination',
        },
        {
          'title': 'Protocol Stack (HTTP over TCP over IP)',
          'definition': 'Layers of communication protocols working together',
          'example': 'Letter → envelope → postal system → delivery truck',
          'importance': 'Each layer handles a specific responsibility',
        },
        {
          'title': 'Symmetric Encryption',
          'definition': 'Using the same key to both lock and unlock data',
          'example': 'House key that both locks and unlocks the door',
          'additional': 'Problem: How do you safely share the key?',
        },
        {
          'title': 'Asymmetric Encryption',
          'definition': 'Using different keys to lock and unlock data',
          'example':
              'Mailbox where anyone can put mail in (public key) but only you can take it out (private key)',
          'additional':
              'Benefit: Can share the "lock" key publicly while keeping "unlock" key secret',
        },
        {
          'title': 'Public/Private Key Pairs',
          'definition':
              'Two mathematically related keys used in asymmetric encryption',
          'example': 'Mailbox slot (public) and mailbox key (private)',
          'additional':
              'Public key: Safe to share with everyone, used to encrypt data\nPrivate key: Keep secret, used to decrypt data',
        },
        {
          'title': 'TLS Handshake',
          'definition':
              'Process where client and server agree on how to communicate securely',
          'example':
              'Two people agreeing on a secret code before having a private conversation',
          'additional':
              'Result: Both sides have the same secret key for secure communication',
        },
        {
          'title': 'Man-in-the-middle Attack',
          'definition':
              'Someone secretly listening to or changing messages between two people',
          'example':
              'Someone intercepting and reading your mail before delivering it',
          'additional': 'Prevention: Encryption and certificate verification',
        },
        {
          'title': 'Proxies',
          'definition':
              'Intermediary servers that handle requests between clients and servers',
          'example': 'Personal assistant who handles your calls and messages',
          'additional':
              'Types: Forward proxy (helps clients), reverse proxy (helps servers)',
        },
        {
          'title': 'Forward Proxy',
          'definition': 'Server that acts on behalf of clients',
          'example': 'Personal assistant making calls for you',
          'additional': 'Uses: Privacy, content filtering, caching',
        },
        {
          'title': 'Reverse Proxy',
          'definition': 'Server that acts on behalf of web servers',
          'example': 'Receptionist handling visitors for a company',
          'additional': 'Uses: Load balancing, SSL termination, security',
        },
      ],
      'System Reliability & Monitoring': [
        {
          'title': 'High Availability',
          'definition': 'System that stays online and working most of the time',
          'example': 'Emergency services that must always be available',
          'additional':
              'Measurement: Percentage of time system is working (99.9% = 8.76 hours downtime per year)',
        },
        {
          'title': 'Fault Tolerance',
          'definition':
              'System\'s ability to continue working even when parts break',
          'example': 'Car that still runs even if one tire goes flat',
          'additional': 'How achieved: Redundancy and backup systems',
        },
        {
          'title': 'Redundancy',
          'definition': 'Having backup copies or alternative systems',
          'example': 'Having spare tires in your car',
          'additional': 'Purpose: Continue working when primary system fails',
        },
        {
          'title': 'SLA (Service Level Agreement)',
          'definition':
              'Contract promising specific levels of service to customers',
          'example': 'Pizza delivery guarantee - "30 minutes or it\'s free"',
          'additional':
              'Contains: Uptime guarantees, performance targets, penalties for failures',
        },
        {
          'title': 'SLO (Service Level Objective)',
          'definition': 'Internal goals for service quality',
          'example': 'Restaurant\'s internal goal to serve food in 15 minutes',
          'additional':
              'Difference from SLA: SLOs are internal targets, SLAs are customer promises',
        },
        {
          'title': 'Rate Limiting',
          'definition':
              'Controlling how many requests a user can make in a time period',
          'example': '"Limit 2 free samples per customer"',
          'additional': 'Purpose: Prevent abuse and ensure fair usage',
        },
        {
          'title': 'DoS/DDoS Attacks',
          'definition': 'Overwhelming a system to make it unavailable',
          'example': 'Flash mob blocking a store entrance',
          'additional':
              'DoS (Denial of Service): Using one computer\nDDoS (Distributed DoS): Using many computers\nImpact: Legitimate users can\'t access the service',
        },
        {
          'title': 'Circuit Breaker',
          'definition':
              'Safety mechanism that stops sending requests to failing services',
          'example':
              'Electrical circuit breaker that cuts power to prevent fires',
          'additional':
              'Benefit: Prevents cascade failures and allows recovery time',
        },
      ],
      'Real-World System Examples': [
        {
          'title': 'Dropbox Design',
          'definition':
              'System designed to store and sync files for millions of users',
          'additional':
              'Key components: Blob storage for files, databases for metadata, sync algorithms\nLesson: Different storage types for different data needs',
        },
        {
          'title': 'Facebook News Feed',
          'definition':
              'System that shows relevant posts to billions of users in real-time',
          'additional':
              'Key components: Pub/Sub for real-time updates, recommendation algorithms, massive caching\nLesson: Real-time systems at scale require specialized architectures',
        },
        {
          'title': 'WhatsApp Chat System',
          'definition':
              'System designed to deliver messages instantly to users worldwide',
          'additional':
              'Key components: WebSocket connections, message queues, presence systems\nLesson: Real-time communication needs low-latency infrastructure',
        },
        {
          'title': 'YouTube Video Streaming',
          'definition':
              'System that streams videos to billions of users with minimal delay',
          'additional':
              'Key components: CDN for global distribution, adaptive bitrate streaming, massive storage\nLesson: Content delivery benefits greatly from edge caching',
        },
        {
          'title': 'Stock Trading Platform',
          'definition':
              'System designed to execute trades with microsecond latency',
          'additional':
              'Key components: Co-located servers, in-memory databases, direct market connections\nLesson: Some applications require extreme performance optimization',
        },
      ],
      'Technologies & Tools': [
        {
          'title': 'Redis',
          'definition': 'Super-fast in-memory database used for caching',
          'example': 'Keeping frequently used tools on your workbench',
          'additional':
              'Best for: Session storage, caching, real-time analytics',
        },
        {
          'title': 'Etcd',
          'definition':
              'Distributed key-value store for configuration and coordination',
          'example':
              'Shared notebook where team members write important information',
          'additional': 'Best for: Service discovery, configuration management',
        },
        {
          'title': 'ZooKeeper',
          'definition': 'Coordination service for distributed systems',
          'example': 'Air traffic control for distributed applications',
          'additional':
              'Best for: Leader election, configuration management, distributed locking',
        },
        {
          'title': 'MySQL',
          'definition': 'Popular relational database with ACID properties',
          'example': 'Well-organized filing system with strict rules',
          'additional': 'Best for: Structured data requiring consistency',
        },
        {
          'title': 'PostgreSQL',
          'definition': 'Advanced relational database with many features',
          'example':
              'Professional-grade filing system with special capabilities',
          'additional':
              'Best for: Complex applications requiring advanced database features',
        },
        {
          'title': 'Neo4j',
          'definition':
              'Database designed specifically for storing relationships',
          'example': 'Family tree or social network map',
          'additional':
              'Best for: Social networks, recommendation engines, fraud detection',
        },
        {
          'title': 'Prometheus',
          'definition': 'Database specialized for storing metrics over time',
          'example': 'Chart tracking your weight over months',
          'additional':
              'Best for: System monitoring, alerting, performance tracking',
        },
        {
          'title': 'Amazon S3',
          'definition': 'Cloud storage service for files and objects',
          'example': 'Massive warehouse in the cloud',
          'additional': 'Best for: Backup, static websites, data archiving',
        },
        {
          'title': 'Google Cloud Storage (GCS)',
          'definition': 'Google\'s version of cloud object storage',
          'example': 'Google\'s warehouse in the cloud',
          'additional':
              'Similar to: Amazon S3 but with Google\'s infrastructure',
        },
        {
          'title': 'Hadoop',
          'definition':
              'Framework for processing huge amounts of data across many computers',
          'example':
              'Organizing thousands of people to count every grain of sand on a beach',
          'additional': 'Best for: Big data analytics, batch processing',
        },
        {
          'title': 'Kafka',
          'definition': 'High-performance message queue system',
          'example': 'Extremely efficient post office for digital messages',
          'additional':
              'Best for: Real-time data streaming, event-driven architectures',
        },
        {
          'title': 'NginX',
          'definition': 'Web server that can also act as a load balancer',
          'example':
              'Versatile receptionist who can handle visitors and route calls',
          'additional': 'Best for: Web serving, load balancing, reverse proxy',
        },
        {
          'title': 'HDFS (Hadoop Distributed File System)',
          'definition':
              'File system that spreads large files across many computers',
          'example':
              'Storing a massive encyclopedia by putting different volumes in different libraries',
          'additional': 'Best for: Storing very large datasets for analytics',
        },
      ],
      'Advanced Concepts': [
        {
          'title': 'MapReduce',
          'definition':
              'Method for processing huge datasets by breaking work into smaller tasks',
          'example':
              'Counting words in all books by giving each person a few books to count, then adding up all counts',
          'additional':
              'How it works: Map (divide work), Reduce (combine results)',
        },
        {
          'title': 'Batch Processing',
          'definition':
              'Processing large amounts of data all at once, not in real-time',
          'example':
              'Doing all your laundry on Sunday instead of washing clothes one by one',
          'additional':
              'When to use: Large data analysis, reports, non-urgent processing',
        },
        {
          'title': 'Asynchronous Processing',
          'definition':
              'Starting a task and not waiting for it to finish before starting the next task',
          'example':
              'Putting clothes in washing machine and doing other chores while it runs',
          'additional':
              'Benefit: Better resource utilization, improved responsiveness',
        },
        {
          'title': 'Peer-to-Peer Networks',
          'definition':
              'Network where computers communicate directly with each other',
          'example':
              'Group of friends sharing photos directly instead of through one central person',
          'additional':
              'Benefits: No single point of failure, can use combined bandwidth\nChallenges: Harder to coordinate, security concerns',
        },
        {
          'title': 'Content Delivery Networks (CDN)',
          'definition':
              'Network of servers worldwide that store copies of content close to users',
          'example':
              'Having convenience stores in every neighborhood instead of one big store downtown',
          'additional':
              'Benefit: Faster access to content, reduced load on main servers',
        },
        {
          'title': 'Points of Presence (PoP)',
          'definition': 'Locations where CDN servers are physically placed',
          'example': 'Neighborhood post offices vs one central post office',
          'additional': 'Purpose: Bring content closer to users geographically',
        },
        {
          'title': 'Edge Computing',
          'definition':
              'Processing data close to where it\'s generated instead of in distant data centers',
          'example':
              'Having a first-aid station at a sports event instead of sending everyone to the hospital',
          'additional': 'Benefit: Lower latency, reduced bandwidth usage',
        },
        {
          'title': 'Configuration Management',
          'definition':
              'Systematic way to manage settings and configurations for systems',
          'example':
              'Recipe book that ensures all restaurant locations make food the same way',
          'additional': 'Benefits: Consistency, easier updates, reduced errors',
        },
        {
          'title': 'YAML (YAML Ain\'t Markup Language)',
          'definition': 'Human-readable format for configuration files',
          'example': 'Well-organized recipe with clear ingredients and steps',
          'additional': 'Why popular: Easy for humans to read and write',
        },
        {
          'title': 'JSON (JavaScript Object Notation)',
          'definition': 'Lightweight format for storing and exchanging data',
          'example': 'Standardized form for collecting information',
          'additional': 'Common uses: APIs, configuration files, data exchange',
        },
        {
          'title': 'Feature Flags',
          'definition':
              'Switches that can turn features on or off without changing code',
          'example':
              'Light switches that can turn lights on/off for different rooms',
          'additional':
              'Benefits: Safe feature rollouts, A/B testing, quick rollbacks',
        },
      ],
      'API Design Principles': [
        {
          'title': 'RESTful Design',
          'definition':
              'Set of principles for designing APIs that are predictable and easy to use',
          'example': 'Standardized menu format that all restaurants follow',
          'additional': 'Benefits: Consistency, ease of use, wide adoption',
        },
        {
          'title': 'CRUD Operations',
          'definition': 'Four basic operations you can do with data',
          'additional':
              'Create: Add new data (like writing a new note)\nRead: View existing data (like reading a note)\nUpdate: Change existing data (like editing a note)\nDelete: Remove data (like throwing away a note)',
        },
        {
          'title': 'Pagination',
          'definition': 'Breaking large lists into smaller, manageable pages',
          'example':
              'Phone book divided into pages instead of one endless list',
          'importance':
              'Prevents overwhelming users and servers with too much data at once',
        },
        {
          'title': 'Authentication',
          'definition': 'Verifying who someone is',
          'example': 'Checking ID before entering a club',
          'additional': 'Methods: Passwords, tokens, biometrics',
        },
        {
          'title': 'Authorization',
          'definition': 'Determining what someone is allowed to do',
          'example': 'Employee badge that determines which rooms you can enter',
          'additional':
              'Difference from Authentication: Authentication = who you are, Authorization = what you can do',
        },
      ],
      'System Architecture Patterns': [
        {
          'title': 'Microservices',
          'definition':
              'Building applications as a collection of small, independent services',
          'example':
              'Restaurant with specialized stations (grill, salad, dessert) vs one chef doing everything',
          'additional':
              'Benefits: Independent scaling, technology diversity, fault isolation',
        },
        {
          'title': 'Monolith',
          'definition': 'Building applications as one large, integrated system',
          'example': 'Swiss Army knife - all tools in one package',
          'additional':
              'Trade-offs: Simpler to deploy but harder to scale individual parts',
        },
        {
          'title': 'Event-Driven Architecture',
          'definition':
              'System where components communicate by sending and receiving events',
          'example':
              'Domino effect - one event triggers a chain of other events',
          'additional': 'Benefits: Loose coupling, scalability, responsiveness',
        },
        {
          'title': 'Service Mesh',
          'definition':
              'Infrastructure layer that handles communication between microservices',
          'example':
              'Telephone operator connecting calls between different departments',
          'additional': 'Benefits: Security, monitoring, traffic management',
        },
        {
          'title': 'Auto-scaling',
          'definition':
              'Automatically adding or removing servers based on demand',
          'example': 'Opening more checkout lanes during busy shopping periods',
          'additional':
              'Benefits: Cost efficiency, automatic handling of traffic spikes',
        },
        {
          'title': 'Geographic Distribution',
          'definition':
              'Placing servers and data in multiple geographic locations',
          'example': 'Chain restaurant with locations in different cities',
          'additional':
              'Benefits: Lower latency for users, disaster recovery, compliance',
        },
        {
          'title': 'Multi-region Deployments',
          'definition':
              'Running your application in multiple geographic regions simultaneously',
          'example': 'Company with offices on different continents',
          'additional':
              'Benefits: Better performance for global users, redundancy',
        },
        {
          'title': 'Data Locality',
          'definition':
              'Storing data close to where it\'s most frequently accessed',
          'example': 'Keeping work documents at your office instead of at home',
          'additional':
              'Benefits: Faster access, reduced network traffic, compliance',
        },
      ],
    };
  }
}
