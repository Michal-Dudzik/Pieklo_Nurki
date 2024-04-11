import 'dart:convert';

import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pieklo_nurki/components/active_stratagems.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pieklo_nurki/components/utility.dart';

class StratagemsScreen extends StatefulWidget {
  const StratagemsScreen({Key? key}) : super(key: key);

  @override
  State<StratagemsScreen> createState() => _StratagemsScreenState();
}

class _StratagemsScreenState extends State<StratagemsScreen> {
  List<String> _pressedArrows = [];
  int _selectedIndex = -1;

  // List<String> svgPaths = [
  //   'assets/stratagems/Bridge/HMG_Emplacement.svg',
  //   'assets/stratagems/Bridge/Orbital_EMS_Strike.svg',
  //   // Add more SVG paths as needed
  // ];
  //
  // List<List<String>> arrowSets = [
  //   ['up', 'down', 'left'],
  //   ['right', 'up'],
  //   // Define arrow sets for each SVG
  // ];

  List<String> svgPaths = [];
  List<List<String>> arrowSets = [];

  @override
  void initState() {
    super.initState();
    _loadSVGPaths();
    _loadArrowSets();
  }

  Future<void> _loadSVGPaths() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final paths = manifestMap.keys
        .where((String key) => key.contains('stratagems'))
        .toList();
    setState(() {
      svgPaths = paths;
    });
  }

  Future<void> _loadArrowSets() async {
    List<List<String>> loadedArrowSets =
    await Utils.readArrowSetsFromFile('assets/stratagemsCombos.txt');
    setState(() {
      arrowSets = loadedArrowSets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // First Row: Title and Menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _StratagemsTitle(),
                      _ExpandableMenu(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Second Row: Stratagems list and Arrows
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildStratagemsColumn(),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: _buildArrowsSpace(),
                        ),
                      ],
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

  Widget _buildStratagemsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.4),
            child: ActiveStratagems(
              svgPaths: svgPaths,
              arrowSets: arrowSets,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArrowsSpace() {
    String selectedSvgPath = _selectedIndex != -1 ? svgPaths[_selectedIndex] : '';
    String selectedSvgName = _selectedIndex != -1 ? Utils.getTitleFromPath(selectedSvgPath) : '';
    List<String> selectedArrows = _selectedIndex != -1 ? arrowSets[_selectedIndex] : [];

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: _selectedIndex != -1
                    ? Image(
                  width: 60,
                  height: 60,
                  image: Svg(selectedSvgPath),
                )
                    : SizedBox(),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  color: const Color(0xffffe80a),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedSvgName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utils.mapDirectionsToArrows(selectedArrows),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ArrowPad(
              onArrowsPressed: (arrows) {
                setState(() {
                  _pressedArrows = arrows;
                  print(_pressedArrows);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StratagemsTitle extends StatelessWidget {
  const _StratagemsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 50,
      color: Colors.black.withOpacity(.4),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            'STRATAGEMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableMenu extends StatelessWidget {
  const _ExpandableMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ExpandableMenu(
        width: 50.0,
        height: 50.0,
        backgroundColor: Colors.black.withOpacity(.4),
        iconColor: Colors.white,
        itemContainerColor: Colors.black,
        items: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/settings_screen');
            },
            icon: Icon(Icons.settings, color: Colors.white),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/stratagems_selection_screen');
            },
            icon: Icon(Icons.select_all, color: Colors.white),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/companion_screen');
            },
            icon: Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
