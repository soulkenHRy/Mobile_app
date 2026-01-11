import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './system_detail_screen.dart';
import './view_demos_screen.dart';

class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  final List<Map<String, dynamic>> tiers = const [
    {
      'tier': 'Tier 1: Foundational Systems',
      'description': 'Perfect for learning core, fundamental concepts.',
      'color': Color(0xFF4CAF50),
      'systems': [
        {
          'name': 'URL Shortener (e.g., TinyURL)',
          'concept':
              'The "Hello, World!" of system design. Teaches hashing, data modeling, and high-volume reads.',
          'keyProblems': [
            'Unique Hash Generation',
            'High-Availability Redirects',
            'Database Schema Design (SQL vs. NoSQL)',
            'Analytics Tracking',
          ],
        },
        {
          'name': 'Pastebin Service (e.g., Pastebin.com)',
          'concept':
              'Focuses on write-heavy systems, data storage, and content lifecycle management.',
          'keyProblems': [
            'Storing Large Text/Code Blocks',
            'Automatic Content Expiration',
            'Custom URL Generation',
            'High Write Throughput',
          ],
        },
        {
          'name': 'Web Crawler',
          'concept':
              'Introduces distributed systems, data pipelines, and asynchronous processing.',
          'keyProblems': [
            'URL Discovery & Crawl Queue Management',
            'HTML Parsing and Data Extraction',
            'Respecting robots.txt',
            'Distributed Task Processing (using queues like RabbitMQ/SQS)',
          ],
        },
      ],
    },
    {
      'tier': 'Tier 2: Web-Scale Giants',
      'description':
          'Covers systems that serve millions of users with complex features.',
      'color': Color(0xFF2196F3),
      'systems': [
        {
          'name': 'Social Media News Feed (e.g., Facebook, X/Twitter)',
          'concept':
              'The classic problem of balancing real-time data with algorithmic personalization at massive scale.',
          'keyProblems': [
            'Feed Generation (Fan-out on Write vs. Pull on Read)',
            'Algorithmic Timeline Ranking',
            'Multi-Layered Caching Strategy',
            'Real-time Updates for Likes/Comments',
          ],
        },
        {
          'name': 'Video Streaming Service (e.g., Netflix, YouTube)',
          'concept':
              'Tackles the challenges of storing and delivering massive binary files with low latency globally.',
          'keyProblems': [
            'Video Upload and Transcoding Pipeline',
            'Content Delivery Network (CDN) Design',
            'Adaptive Bitrate Streaming',
            'Personalized Recommendation Engine',
          ],
        },
        {
          'name': 'Ride-Sharing Service (e.g., Uber, Lyft)',
          'concept':
              'A masterclass in real-time geospatial systems, state management, and matchmaking.',
          'keyProblems': [
            'Real-time Geolocation Tracking',
            'Efficient Driver-Rider Matchmaking',
            'Geospatial Indexing (Quadtrees, Geohashing)',
            'Dynamic/Surge Pricing Logic',
          ],
        },
      ],
    },
    {
      'tier': 'Tier 3: Advanced & Specialized Systems',
      'description':
          'Dives into complex, niche problems for experienced engineers.',
      'color': Color(0xFFFF9800),
      'systems': [
        {
          'name': 'Collaborative Editor (e.g., Google Docs, Figma)',
          'concept':
              'Explores the difficult challenge of real-time conflict resolution and data synchronization.',
          'keyProblems': [
            'Concurrent Edit Management',
            'Conflict Resolution Algorithms (Operational Transforms vs. CRDTs)',
            'Low-Latency Communication (WebSockets)',
            'User Presence and Cursor Tracking',
          ],
        },
        {
          'name': 'Live Streaming Platform (e.g., Twitch, YouTube Live)',
          'concept':
              'Focuses on ultra-low latency video and building a chat system for millions of concurrent users.',
          'keyProblems': [
            'Low-Latency Video Protocols (WebRTC, LL-HLS)',
            'Highly Scalable Chat Architecture (WebSockets + Pub/Sub)',
            'Real-time Chat Moderation',
            'Stream Ingest and Distribution',
          ],
        },
        {
          'name': 'Global Gaming Leaderboard',
          'concept':
              'A performance-critical system that requires a deep understanding of data structures for real-time ranking.',
          'keyProblems': [
            'High-Performance Data Structure (e.g., Redis Sorted Sets)',
            'Scalability and Sharding',
            'Real-time Score Updates and Rank Calculation',
            'Handling Ties and Cheating',
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 82, 0, 105),
              Color.fromARGB(255, 6, 4, 4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Design a System',
                        style: GoogleFonts.saira(
                          textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.engineering, color: Colors.white, size: 28),
                  ],
                ),
              ),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Choose a System to Design',
                  style: GoogleFonts.saira(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tiers List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: tiers.length,
                  itemBuilder: (context, index) {
                    final tier = tiers[index];
                    return _buildTierCard(tier, context);
                  },
                ),
              ),

              // View Demos Button (at the bottom, after all tiers)
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D2817),
                      foregroundColor: const Color(0xFFFFE4B5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Color(0xFFFFE4B5),
                          width: 2,
                        ),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(
                      Icons.folder_open,
                      color: Color(0xFFFFE4B5),
                    ),
                    label: Text(
                      'View Demos',
                      style: GoogleFonts.saira(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFE4B5),
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const ViewDemosScreen(
                                folderPath:
                                    '/home/shaken/quiz_game/lib/Flowchart, Diagrams',
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTierCard(Map<String, dynamic> tier, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: tier['color'],
        collapsedIconColor: tier['color'],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 30,
                  decoration: BoxDecoration(
                    color: tier['color'],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tier['tier'],
                    style: GoogleFonts.saira(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                tier['description'],
                style: GoogleFonts.saira(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
        children: [
          ...tier['systems']
              .map<Widget>(
                (system) => _buildSystemCard(system, tier['color'], context),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSystemCard(
    Map<String, dynamic> system,
    Color tierColor,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tierColor.withOpacity(0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => SystemDetailScreen(
                      systemName: system['name'],
                      concept: system['concept'],
                      keyProblems: List<String>.from(system['keyProblems']),
                      color: tierColor,
                    ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tierColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.settings_suggest,
                    color: tierColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        system['name'],
                        style: GoogleFonts.saira(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${system['keyProblems'].length} Key Problems',
                        style: GoogleFonts.saira(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: tierColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
