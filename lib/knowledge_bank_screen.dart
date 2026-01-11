import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './topic_detail_screen.dart';
import './system_design_topics_data.dart';
import 'dart:math';

class KnowledgeBankScreen extends StatelessWidget {
  const KnowledgeBankScreen({super.key});

  final List<Map<String, dynamic>> topics = const [
    {
      'title': 'Performance & Optimization',
      'icon': Icons.speed,
      'color': Color(0xFF4CAF50),
      'description': 'Latency, Throughput, Caching, Memory optimization',
      'whatIs': 'Performance & Optimization is about making your app fast and efficient - like tuning a car engine to run smoother and quicker.',
      'whyNecessary': 'Users hate waiting! A slow app loses customers. Fast apps keep users happy and save money on servers.',
    },
    {
      'title': 'Scalability & Distribution',
      'icon': Icons.trending_up,
      'color': Color(0xFF2196F3),
      'description': 'Horizontal scaling, Load balancing, Sharding',
      'whatIs': 'Scalability is your system\'s ability to handle MORE - more users, more data, more requests - without breaking down.',
      'whyNecessary': 'When your app goes viral, you need it to handle millions of users, not crash. It\'s like having enough cashiers when the store gets busy.',
    },
    {
      'title': 'Database & Storage Systems',
      'icon': Icons.storage,
      'color': Color(0xFF9C27B0),
      'description': 'SQL, NoSQL, Graph databases, Blob storage',
      'whatIs': 'Databases are where your app stores all its data - user info, messages, photos. Different databases work best for different jobs.',
      'whyNecessary': 'Without proper storage, you lose data! Choosing the right database means faster queries and happier users.',
    },
    {
      'title': 'Data Consistency & Reliability',
      'icon': Icons.verified_user,
      'color': Color(0xFFFF9800),
      'description': 'ACID, Consensus algorithms, Idempotency',
      'whatIs': 'Consistency ensures all parts of your system agree on the data. Like making sure everyone reads the same menu at a restaurant.',
      'whyNecessary': 'Imagine transferring money and it disappears! Consistency prevents data corruption and keeps users\' trust.',
    },
    {
      'title': 'Messaging & Communication',
      'icon': Icons.message,
      'color': Color(0xFFE91E63),
      'description': 'Pub/Sub, Streaming, Message queues',
      'whatIs': 'Messaging systems let different parts of your app talk to each other - like a postal service for your code.',
      'whyNecessary': 'Apps have many pieces that need to communicate. Good messaging prevents lost messages and keeps everything in sync.',
    },
    {
      'title': 'Network & Security',
      'icon': Icons.security,
      'color': Color(0xFFF44336),
      'description': 'HTTP, TCP, Encryption, TLS handshake',
      'whatIs': 'Networking is how data travels between computers. Security makes sure only the right people can access your data.',
      'whyNecessary': 'Hackers are everywhere! Good security protects user data and prevents your app from being compromised.',
    },
    {
      'title': 'System Reliability & Monitoring',
      'icon': Icons.monitor_heart,
      'color': Color(0xFF607D8B),
      'description': 'SLA/SLO, Rate limiting, High availability',
      'whatIs': 'Reliability means your system works when users need it. Monitoring helps you spot problems before users complain.',
      'whyNecessary': 'Downtime costs money and reputation. Knowing when something breaks lets you fix it fast.',
    },
    {
      'title': 'Real-World System Examples',
      'icon': Icons.business,
      'color': Color(0xFF795548),
      'description': 'Dropbox, Facebook, WhatsApp, YouTube designs',
      'whatIs': 'Real examples show how big companies built their systems - the patterns and tricks that made them successful.',
      'whyNecessary': 'Learning from giants saves you from reinventing the wheel. Their solutions are battle-tested at massive scale.',
    },
    {
      'title': 'Technologies & Tools',
      'icon': Icons.build,
      'color': Color(0xFF009688),
      'description': 'Redis, MySQL, Kafka, S3, Hadoop, NginX',
      'whatIs': 'These are the building blocks engineers use - databases, caches, message brokers, and more.',
      'whyNecessary': 'Knowing your tools makes you faster. Each tool solves specific problems - pick the right one for the job.',
    },
    {
      'title': 'Advanced Concepts',
      'icon': Icons.rocket_launch,
      'color': Color(0xFF3F51B5),
      'description': 'MapReduce, P2P networks, CDN, Edge computing',
      'whatIs': 'Advanced concepts are powerful techniques for handling huge scale - processing big data, global distribution, and more.',
      'whyNecessary': 'When basic solutions aren\'t enough, these techniques let you build systems that handle billions of users.',
    },
    {
      'title': 'API Design Principles',
      'icon': Icons.api,
      'color': Color(0xFFFF5722),
      'description': 'REST, CRUD, Pagination, Authentication',
      'whatIs': 'APIs are how different apps talk to each other - like a menu that tells other programs what your app can do.',
      'whyNecessary': 'Good APIs are easy to use and hard to misuse. Bad APIs cause bugs and frustrate developers.',
    },
    {
      'title': 'System Architecture Patterns',
      'icon': Icons.architecture,
      'color': Color(0xFF8BC34A),
      'description': 'Microservices, Event-driven, Service mesh',
      'whatIs': 'Architecture patterns are proven blueprints for organizing your system - like floor plans for buildings.',
      'whyNecessary': 'Good architecture makes your system easier to build, test, and change. Bad architecture creates a tangled mess.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Cozy pixel-like gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1810), // Dark brown
              Color(0xFF3D2817), // Medium brown
              Color(0xFF4A3420), // Light brown
              Color(0xFF5C4129), // Tan
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Cozy pixel-style stars/dots background
            ...List.generate(40, (index) {
              final random = Random(index);
              return Positioned(
                left: random.nextDouble() * screenWidth,
                top: random.nextDouble() * screenHeight,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4B5).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
            SafeArea(
              child: Column(
                children: [
                  // Header with back button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3420),
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: const Color(0xFFFFE4B5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 0,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFFFFE4B5),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Knowledge Bank',
                            style: GoogleFonts.saira(
                              textStyle: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFE4B5),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Explore System Design Topics',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Topics Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          final topic = topics[index];
                          return _buildTopicCard(topic, context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(Map<String, dynamic> topic, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final topicData = SystemDesignTopicsData.getTopicData();
            final subtopics = topicData[topic['title']] ?? [];

            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => TopicDetailScreen(
                      title: topic['title'],
                      color: topic['color'],
                      icon: topic['icon'],
                      subtopics: subtopics,
                      whatIs: topic['whatIs'] ?? '',
                      whyNecessary: topic['whyNecessary'] ?? '',
                    ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: topic['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(topic['icon'], color: topic['color'], size: 28),
                ),

                const SizedBox(height: 12),

                // Title
                Text(
                  topic['title'],
                  style: GoogleFonts.saira(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Description
                Expanded(
                  child: Text(
                    topic['description'],
                    style: GoogleFonts.saira(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 8),

                // Explore button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: topic['color'].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Explore',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.saira(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
