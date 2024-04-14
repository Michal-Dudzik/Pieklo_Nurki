import 'dart:convert';
import 'package:flutter/material.dart';
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
      throw Exception("Failed to load stratagems: $e");
    }
  }

  static List<Widget> mapDirectionsToArrows(List<String> directions, int streak) {
    List<Widget> arrowWidgets = [];
    for (int i = 0; i < directions.length; i++) {
      String arrow = directions[i];
      Color color = i < streak ? const Color(0xffffe80a): Colors.white;
      switch (arrow) {
        case 'Up':
          arrowWidgets.add(Text(
            '🠉',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontFamily: 'Symbola',
            ),
          ));
          break;
        case 'Down':
          arrowWidgets.add(Text(
            '🠋',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontFamily: 'Symbola',
            ),
          ));
          break;
        case 'Left':
          arrowWidgets.add(Text(
            '🠈',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontFamily: 'Symbola',
            ),
          ));
          break;
        case 'Right':
          arrowWidgets.add(Text(
            '🠊',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontFamily: 'Symbola',
            ),
          ));
          break;
        default:
          break;
      }
    }
    return arrowWidgets;
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