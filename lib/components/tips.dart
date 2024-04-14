import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';


class Tips extends StatelessWidget {
  final List<String> tips = [
    "Friendly fire isn't",
    "When all else fails, dive again, and again and again and again and again and again and again and again and again and again and again",
    "Tips are shown here",
    "Remember to fill in your C-01 permit before any act that could result in a child",
    "Failure to complete the mission will NOT result in you being sent to a freedom camp, those are lies",
    "When unsure of what to do, don't think. Yell 'Democracy!' and charge forward!",
    "Don't drink and drive",
    "If an enemey ever attempts to engage in diplomacy, SHOOT THEM. We mustn't belive their lies",
  ];

  Tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tips.shuffle();

    return Expanded(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.black.withOpacity(.4),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'TRAINING MANUAL TIPS:',
                    style: TextStyle(
                      color: Color(0xffffe80a),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: MarqueeText(
                      text: TextSpan(
                        text: tips.join('   |   '),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      speed: 20,
                      alwaysScroll: true,
                      textDirection: TextDirection.rtl,
                      marqueeDirection: MarqueeDirection.rtl,
                      textAlign: TextAlign.start,
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
