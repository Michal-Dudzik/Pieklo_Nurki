import 'dart:convert';
import 'package:flutter/services.dart';

class Utils {

  static Future<List<Stratagem>> loadStratagems() async {
    try {
      String jsonString = await rootBundle.loadString('assets/stratagems.json');
      List<dynamic> data = json.decode(jsonString);

      List<Stratagem> stratagems = [];

      for (var item in data) {
        stratagems.add(Stratagem.fromJson(item));
      }

      return stratagems;
    } catch (e) {
      print("Error reading stratagems file: $e");
      throw Exception("Failed to load stratagems: $e");
    }
  }

  static String mapDirectionsToArrows(List<String> directions) {
    List<String> arrowStrings = [];
    for (String arrow in directions) {
      switch (arrow) {
        case 'Up':
          arrowStrings.add('↑');
          break;
        case 'Down':
          arrowStrings.add('↓');
          break;
        case 'Left':
          arrowStrings.add('←');
          break;
        case 'Right':
          arrowStrings.add('→');
          break;
        default:
          break;
      }
    }
    return arrowStrings.join(' ');
  }

}


class Stratagem {
  final String name;
  final String svgPath;
  final List<String> arrowSet;

  Stratagem({
    required this.name,
    required this.svgPath,
    required this.arrowSet,
  });

  factory Stratagem.fromJson(Map<String, dynamic> json) {
    return Stratagem(
      name: json['name'],
      svgPath: json['svgPath'],
      arrowSet: List<String>.from(json['arrowSet']),
    );
  }

}