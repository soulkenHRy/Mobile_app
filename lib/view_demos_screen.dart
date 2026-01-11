import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'url_shortener_designs_gallery.dart';
import 'system_design_gallery.dart';

class ViewDemosScreen extends StatelessWidget {
  final String folderPath;
  const ViewDemosScreen({super.key, required this.folderPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Files'),
        backgroundColor: const Color(0xFF3D2817),
      ),
      body: ListView(
        children: [
          _buildGalleryTile(
            context,
            'Gaming Leaderboard Designs (10 Designs)',
            'View all 10 gaming leaderboard architectures',
            const Color(0xFF00BCD4),
            SystemDesignType.gamingLeaderboard,
          ),
          _buildGalleryTile(
            context,
            'Live Streaming Designs (10 Designs)',
            'View all 10 live streaming platform architectures',
            const Color(0xFFE91E63),
            SystemDesignType.liveStreaming,
          ),
          _buildGalleryTile(
            context,
            'Video Streaming Designs (10 Designs)',
            'View all 10 Netflix-like streaming architectures',
            const Color(0xFFE50914),
            SystemDesignType.videoStreaming,
          ),
          _buildGalleryTile(
            context,
            'Ride Sharing Designs (10 Designs)',
            'View all 10 Uber-like ride sharing architectures',
            const Color(0xFF00BCD4),
            SystemDesignType.rideSharing,
          ),
          _buildGalleryTile(
            context,
            'Collaborative Editor Designs (10 Designs)',
            'View all 10 Google Docs-like architectures',
            const Color(0xFF4CAF50),
            SystemDesignType.collaborativeEditor,
          ),
          ListTile(
            title: Text(
              'URL Shortener Canvas Designs (10 Designs)',
              style: GoogleFonts.saira(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3D2817),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Text(
              'View all 10 predefined URL shortener architectures',
              style: GoogleFonts.saira(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8B7355),
                ),
              ),
            ),
            leading: const Icon(Icons.architecture, color: Color(0xFF764BA2)),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF3D2817),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const URLShortenerDesignsGallery(),
                ),
              );
            },
          ),
          _buildGalleryTile(
            context,
            'Pastebin Service Designs (10 Designs)',
            'View all 10 Pastebin-like architectures',
            const Color(0xFFFF9800),
            SystemDesignType.pastebin,
          ),
          _buildGalleryTile(
            context,
            'Web Crawler Designs (10 Designs)',
            'View all 10 search engine/crawler architectures',
            const Color(0xFF2196F3),
            SystemDesignType.webCrawler,
          ),
          _buildGalleryTile(
            context,
            'News Feed Designs (10 Designs)',
            'View all 10 Facebook-like feed architectures',
            const Color(0xFF1976D2),
            SystemDesignType.newsFeed,
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryTile(
    BuildContext context,
    String title,
    String subtitle,
    Color themeColor,
    SystemDesignType designType,
  ) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.saira(
          textStyle: TextStyle(
            fontSize: 18,
            color: themeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.saira(
          textStyle: const TextStyle(fontSize: 12, color: Color(0xFF8B7355)),
        ),
      ),
      leading: Icon(Icons.architecture, color: themeColor),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF3D2817),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SystemDesignGallery(designType: designType),
          ),
        );
      },
    );
  }
}
