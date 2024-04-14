import 'dart:async';
import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pieklo_nurki/components/CountDownTimer.dart';
import 'package:pieklo_nurki/components/active_stratagems.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pieklo_nurki/components/menu.dart';
import 'package:pieklo_nurki/components/tips.dart';
import 'package:pieklo_nurki/components/utility.dart';

class StratagemsScreen extends StatefulWidget {
  const StratagemsScreen({Key? key}) : super(key: key);

  @override
  State<StratagemsScreen> createState() => _StratagemsScreenState();
}

class _StratagemsScreenState extends State<StratagemsScreen> {
  int _selectedIndex = -1;
  List<Stratagem> stratagems = [];
  Queue<String> _pressedArrowsQueue = Queue<String>();
  int streak = 0;
  bool successfulCall = false;

  @override
  void initState() {
    super.initState();
     _initializeData();
  }

  Future<void> _initializeData() async {
    List<Stratagem> loadedStratagems = await Utils.loadStratagems();
    setState(() {
      stratagems = loadedStratagems;
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
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _StratagemsTitle(),
                      const SizedBox(width: 10),
                      Tips(),
                      const SizedBox(width: 60),
                    ],
                  ),
                  const SizedBox(height: 10),
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
            const Positioned(
              top: 10, 
              right: 10,
              child: Menu(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStratagemsColumn() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(.4),
                child: ActiveStratagems(
                  streak: 0,
                  stratagems: stratagems,
                  onItemSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                      successfulCall = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowsSpace() {
    String selectedSvgPath = _selectedIndex != -1 ? stratagems[_selectedIndex].svgPath : '';
    String selectedSvgName = _selectedIndex != -1 ? stratagems[_selectedIndex].name : '';
    List<String>? selectedArrows = _selectedIndex != -1 ? stratagems[_selectedIndex].arrowSet : [];

    bool checkArrowSequence(List<String> pressedArrows, List<String>? selectedArrows) {
      if (selectedArrows == null || selectedArrows.isEmpty) {
        return false;
      }

      if (pressedArrows.last == selectedArrows[streak]) {
        streak++;
        if (streak == selectedArrows.length) {
          streak = 0;
          successfulCall = true;
        }
        return true;
      } else {
        streak = 0;
        return false;
      }
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 60,
                      color: successfulCall ? const Color(0xffffe80a) : Colors.black.withOpacity(.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            successfulCall ? 'ACTIVATING' : selectedSvgName,
                            style:  TextStyle(
                              color: successfulCall ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          successfulCall ? CountdownTimer(
                            successfulCall: true,
                            onCountdownComplete: () {
                              setState(() {
                                successfulCall = false;
                              });
                            },
                          ) : Row(
                            children: Utils.mapDirectionsToArrows(selectedArrows, streak),
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
                      _pressedArrowsQueue.add(arrows.last);

                      if (_pressedArrowsQueue.length > 10) {
                        _pressedArrowsQueue.removeFirst();
                      }

                      List<String> pressedArrows = _pressedArrowsQueue.toList();

                      checkArrowSequence(pressedArrows, selectedArrows);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StratagemsTitle extends StatelessWidget {
  const _StratagemsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 170,
          height: 50,
          color: Colors.black.withOpacity(.4),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: 20,
                height: 20,
                image: AssetImage('assets/images/danger.png'),
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
        ),
      ),
    );
  }
}

