import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './design_manager.dart';
import './unlimited_design_screen.dart';

class SavedDesignsListScreen extends StatefulWidget {
  const SavedDesignsListScreen({super.key});

  @override
  State<SavedDesignsListScreen> createState() => _SavedDesignsListScreenState();
}

class _SavedDesignsListScreenState extends State<SavedDesignsListScreen> {
  List<SavedDesign> _savedDesigns = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedDesigns();
  }

  Future<void> _loadSavedDesigns() async {
    setState(() => _isLoading = true);
    try {
      final designs = await DesignManager.getSavedDesigns();
      setState(() {
        _savedDesigns = designs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load designs: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteDesign(SavedDesign design) async {
    try {
      await DesignManager.deleteDesign(design.id);
      await _loadSavedDesigns();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Design "${design.name}" deleted'),
          backgroundColor: const Color(0xFFFF6B35),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete design: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteConfirmation(SavedDesign design) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF4A3420),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: const Color(0xFFFF6B35), width: 2),
            ),
            title: Row(
              children: [
                Icon(Icons.delete_forever, color: Colors.red, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Delete Design',
                  style: GoogleFonts.saira(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              'Are you sure you want to delete "${design.name}"? This action cannot be undone.',
              style: GoogleFonts.saira(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.saira(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteDesign(design);
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.saira(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _openDesign(SavedDesign design) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => UnlimitedDesignScreen(initialDesign: design),
          ),
        )
        .then((_) => _loadSavedDesigns()); // Refresh list when returning
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1810),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C1810),
        foregroundColor: Colors.white,
        title: Text(
          'Saved Designs',
          style: GoogleFonts.saira(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loadSavedDesigns,
            icon: Icon(Icons.refresh, color: const Color(0xFFFF6B35)),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6B35)),
                ),
              )
              : _savedDesigns.isEmpty
              ? _buildEmptyState()
              : _buildDesignsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder:
                      (context) => UnlimitedDesignScreen(
                        initialDesign:
                            null, // Explicitly pass null to create new design
                      ),
                ),
              )
              .then((_) => _loadSavedDesigns());
        },
        backgroundColor: const Color(0xFFFF6B35),
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Create New Design',
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.design_services, size: 80, color: Colors.white24),
            const SizedBox(height: 24),
            Text(
              'No Saved Designs',
              style: GoogleFonts.saira(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Create your first unlimited design and save it to see it here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.saira(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => UnlimitedDesignScreen(),
                      ),
                    )
                    .then((_) => _loadSavedDesigns());
              },
              icon: Icon(Icons.add),
              label: Text(
                'Create New Design',
                style: GoogleFonts.saira(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedDesigns.length,
      itemBuilder: (context, index) {
        final design = _savedDesigns[index];
        return Card(
          color: const Color(0xFF4A3420),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white12, width: 1),
          ),
          child: InkWell(
            onTap: () => _openDesign(design),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          design.name,
                          style: GoogleFonts.saira(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.white54),
                        color: const Color(0xFF4A3420),
                        onSelected: (value) {
                          if (value == 'delete') {
                            _showDeleteConfirmation(design);
                          }
                        },
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Delete',
                                      style: GoogleFonts.saira(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (design.notes.isNotEmpty) ...[
                    Text(
                      design.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.saira(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.white38, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Updated ${_formatDate(design.updatedAt)}',
                        style: GoogleFonts.saira(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      if (design.canvasData['icons'] != null)
                        Row(
                          children: [
                            Icon(
                              Icons.widgets,
                              color: Colors.white38,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${design.canvasData['icons'].length} components',
                              style: GoogleFonts.saira(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
