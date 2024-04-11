import 'dart:convert';
import 'dart:io';
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

  // static List<List<String>> initializeArrowSets(int length) {
  //   List<List<String>> arrowSets = [];
  //   for (int i = 0; i < length; i++) {
  //     arrowSets.add([]);
  //   }
  //   return arrowSets;
  // }

  static Future<List<List<String>>> readArrowSetsFromFile(String filePath) async {
    try {
      File file = File(filePath);
      List<String> lines = await file.readAsLines();
      List<List<String>> arrowSets = [];
      for (String line in lines) {
        arrowSets.add(line.split(','));
      }
      return arrowSets;
    } catch (e) {
      print("Error reading arrow sets file: $e");
      return [];
    }
  }

}