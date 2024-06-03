import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class ArrowButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Color pressedColor;
  final Duration animationDuration;

  const ArrowButton({
    required this.text,
    required this.onPressed,
    this.size = 50,
    this.color = Colors.grey,
    this.pressedColor = Colors.yellow,
    this.animationDuration = const Duration(milliseconds: 50),
    Key? key,
  }) : super(key: key);

  @override
  _ArrowButtonState createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: widget.animationDuration,
        decoration: BoxDecoration(
          color: _isPressed ? widget.pressedColor : widget.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 3, color: Colors.black),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Symbola',
              fontSize: widget.size,
              color: _isPressed ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowPad extends ConsumerStatefulWidget {
  const ArrowPad({Key? key}) : super(key: key);

  @override
  _ArrowPadState createState() => _ArrowPadState();
}

class _ArrowPadState extends ConsumerState<ArrowPad> {
  void _handleArrowButtonPress(String direction) {
    HapticFeedback.heavyImpact();

    final queueNotifier = ref.read(pressedArrowsQueueProvider.notifier);
    final pressedArrowsQueue = Queue<String>.from(queueNotifier.state);
    pressedArrowsQueue.add(direction);

    if (pressedArrowsQueue.length > 10) {
      pressedArrowsQueue.removeFirst();
    }

    queueNotifier.state = pressedArrowsQueue;

    _checkArrowSequence(ref, pressedArrowsQueue);
  }

  void _checkArrowSequence(WidgetRef ref, Queue<String> pressedArrowsQueue) {
    final selectedIndex = ref.read(selectedIndexProvider);
    if (selectedIndex == -1) return;

    final stratagems = ref.read(stratagemsProvider);
    final selectedStratagem = stratagems[selectedIndex];
    final selectedArrows = selectedStratagem.arrowSet;

    if (selectedArrows.isEmpty) return;

    final streak = ref.read(streakProvider);
    final pressedArrows = pressedArrowsQueue.toList();

    if (pressedArrows.last == selectedArrows[streak]) {
      ref.read(streakProvider.notifier).state++;
      if (streak + 1 == selectedArrows.length) {
        ref.read(streakProvider.notifier).state = 0;
        ref.read(successfulCallProvider.notifier).state = true;
      }
    } else {
      ref.read(streakProvider.notifier).state = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          const SizedBox(),
          ArrowButton(
            text: '🠉',
            onPressed: () => _handleArrowButtonPress('Up'),
          ),
          const SizedBox(),
          ArrowButton(
            text: '🠈',
            onPressed: () => _handleArrowButtonPress('Left'),
          ),
          ArrowButton(
            text: '🠋',
            onPressed: () => _handleArrowButtonPress('Down'),
          ),
          ArrowButton(
            text: '🠊',
            onPressed: () => _handleArrowButtonPress('Right'),
          ),
        ],
      ),
    );
  }
}
