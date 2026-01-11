import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SavedDesign {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> canvasData;
  final String notes;

  SavedDesign({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.canvasData,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'canvasData': canvasData,
      'notes': notes,
    };
  }

  factory SavedDesign.fromJson(Map<String, dynamic> json) {
    return SavedDesign(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      canvasData: json['canvasData'],
      notes: json['notes'] ?? '',
    );
  }

  SavedDesign copyWith({
    String? name,
    DateTime? updatedAt,
    Map<String, dynamic>? canvasData,
    String? notes,
  }) {
    return SavedDesign(
      id: id,
      name: name ?? this.name,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      canvasData: canvasData ?? this.canvasData,
      notes: notes ?? this.notes,
    );
  }
}

class DesignManager {
  static const String _savedDesignsKey = 'saved_unlimited_designs';

  static Future<List<SavedDesign>> getSavedDesigns() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_savedDesignsKey);

      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => SavedDesign.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveDesign(SavedDesign design) async {
    try {
      final designs = await getSavedDesigns();

      // Check if design with same ID exists
      final existingIndex = designs.indexWhere((d) => d.id == design.id);

      if (existingIndex != -1) {
        // Update existing design
        designs[existingIndex] = design;
      } else {
        // Add new design
        designs.add(design);
      }

      // Sort by updated date (most recent first)
      designs.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(designs.map((d) => d.toJson()).toList());
      await prefs.setString(_savedDesignsKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save design: $e');
    }
  }

  static Future<void> deleteDesign(String designId) async {
    try {
      final designs = await getSavedDesigns();
      designs.removeWhere((d) => d.id == designId);

      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(designs.map((d) => d.toJson()).toList());
      await prefs.setString(_savedDesignsKey, jsonString);
    } catch (e) {
      throw Exception('Failed to delete design: $e');
    }
  }

  static Future<SavedDesign?> getDesign(String designId) async {
    try {
      final designs = await getSavedDesigns();
      return designs.firstWhere((d) => d.id == designId);
    } catch (e) {
      return null;
    }
  }

  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
