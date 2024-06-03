import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:pieklo_nurki/components/countdown_timer.dart';
import 'package:pieklo_nurki/components/utility.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class ArrowsSpace extends ConsumerWidget {
  const ArrowsSpace({
    Key? key,
    required this.stratagems,
    required this.selectedIndex,
    required this.streak,
    required this.successfulCall,
    required this.pressedArrowsQueue,
  }) : super(key: key);

  final List<Stratagem> stratagems;
  final int selectedIndex;
  final int streak;
  final bool successfulCall;
  final Queue<String> pressedArrowsQueue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selectedSvgPath =
        selectedIndex != -1 ? stratagems[selectedIndex].svgPath : '';
    String selectedSvgName =
        selectedIndex != -1 ? stratagems[selectedIndex].name : '';
    List<String>? selectedArrows =
        selectedIndex != -1 ? stratagems[selectedIndex].arrowSet : [];

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
                    child: selectedIndex != -1
                        ? Image(
                            width: 60,
                            height: 60,
                            image: Svg(selectedSvgPath),
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 60,
                      color: successfulCall
                          ? const Color(0xffffe80a)
                          : Colors.black.withOpacity(.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            successfulCall ? 'ACTIVATING' : selectedSvgName,
                            style: TextStyle(
                              color:
                                  successfulCall ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          successfulCall
                              ? CountdownTimer(
                                  successfulCall: true,
                                  onCountdownComplete: () {
                                    ref
                                        .read(successfulCallProvider.notifier)
                                        .state = false;
                                  },
                                )
                              : Row(
                                  children: Utils.mapDirectionsToArrows(
                                      selectedArrows, streak),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ArrowPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
