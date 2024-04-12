import 'dart:convert';
import 'package:flutter/services.dart';

class Utils {
  static String getTitleFromPath(String path) {
    String fileName = path.split('/').last;
    String title = fileName.replaceAll('.svg', '');
    title = title.replaceAll('_', ' ');
    return title;
  }

  static String mapDirectionsToArrows(List<String> directions) {
    List<String> arrowStrings = [];
    for (String arrow in directions) {
      switch (arrow) {
        case 'up':
          arrowStrings.add('↑');
          break;
        case 'down':
          arrowStrings.add('↓');
          break;
        case 'left':
          arrowStrings.add('←');
          break;
        case 'right':
          arrowStrings.add('→');
          break;
        default:
          break;
      }
    }
    return arrowStrings.join(' ');
  }

  static List<String> extractSVGPaths(Iterable<String> keys) {
    List<String> svgPaths = [];
    for (String key in keys) {
      if (key.contains('.svg')) {
        svgPaths.add(key);
      }
    }
    return svgPaths;
  }

  static Future<List<String>> loadSVGPaths() async {
    try {
      List<String> svgPaths = [];
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      for (String key in manifestMap.keys) {
        if (key.startsWith('assets/stratagems/') && key.endsWith('.svg')) {
          svgPaths.add(key);
        }
      }
      return svgPaths;
    } catch (e) {
      print("Error loading SVG paths: $e");
      throw Exception("Failed to load SVG paths: $e");
    }
  }

  static Future<Map<String, List<String>>> loadArrowSets() async {
    try {
      String filePath = 'assets/stratagemsCombos.txt';
      String fileContent = await rootBundle.loadString(filePath);
      List<String> lines = fileContent.split('\n');
      Map<String, List<String>> arrowSets = {};
      for (String line in lines) {
        List<String> parts = line.split(',').map((part) => part.trim()).toList();
        if (parts.isNotEmpty) {
          String stratagemName = parts[0];
          List<String> arrows = parts.sublist(1);
          arrowSets[stratagemName] = arrows;
        }
      }
      print("Loaded SVG paths: $arrowSets");
      return arrowSets;
    } catch (e) {
      print("Error reading arrow sets file: $e");
      throw Exception("Failed to load arrow sets: $e");
    }
  }

}