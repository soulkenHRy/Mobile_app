import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'url_shortener_canvas_designs.dart';
import 'url_shortener_demo_canvas.dart';

/// Gallery screen to preview and load URL Shortener designs
class URLShortenerDesignsGallery extends StatelessWidget {
  const URLShortenerDesignsGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final designs = URLShortenerCanvasDesigns.getAllDesigns();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 4, 4),
      appBar: AppBar(
        title: Text(
          'URL Shortener Design Gallery',
          style: GoogleFonts.saira(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 0, 52),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: designs.length,
          itemBuilder: (context, index) {
            final design = designs[index];
            final name = design['name'] as String;
            final description = design['description'] as String;
            final iconCount = (design['icons'] as List).length;
            final connectionCount = (design['connections'] as List).length;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _openDesignInCanvas(context, design),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildStatChip(
                            Icons.widgets,
                            '$iconCount icons',
                            Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          _buildStatChip(
                            Icons.connecting_airports,
                            '$connectionCount connections',
                            Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _openDesignInCanvas(BuildContext context, Map<String, dynamic> design) {
    // Convert connections to lines for the canvas
    final lines = URLShortenerCanvasDesigns.connectionsToLines(design);

    // Prepare canvas data with explanation
    final canvasData = {
      'icons': design['icons'],
      'lines': lines,
      'explanation': design['explanation'],
    };

    // Navigate to simplified demo canvas screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => URLShortenerDemoCanvas(
              designName: design['name'] as String,
              designData: canvasData,
            ),
      ),
    );
  }
}
