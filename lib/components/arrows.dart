import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Color pressedColor;
  final Duration animationDuration;

  const ArrowButton({
    required this.icon,
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
          child: Icon(
            widget.icon,
            size: widget.size,
            color: _isPressed ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class ArrowPad extends StatefulWidget {
  final void Function(List<String>) onArrowsPressed;

  const ArrowPad({
    required this.onArrowsPressed,
    Key? key,
  }) : super(key: key);

  @override
  _ArrowPadState createState() => _ArrowPadState();
}

class _ArrowPadState extends State<ArrowPad> {
  final List<String> _pressedArrows = [];

  void _handleArrowButtonPress(String direction) {
    setState(() {
      _pressedArrows.add(direction);
    });
    HapticFeedback.heavyImpact();
    widget.onArrowsPressed(_pressedArrows.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 175,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          const SizedBox(),
          ArrowButton(
            icon: Icons.arrow_upward,
            onPressed: () => _handleArrowButtonPress('Up'),
          ),
          const SizedBox(),
          ArrowButton(
            icon: Icons.arrow_back,
            onPressed: () => _handleArrowButtonPress('Left'),
          ),
          ArrowButton(
            icon: Icons.arrow_downward,
            onPressed: () => _handleArrowButtonPress('Down'),
          ),
          ArrowButton(
            icon: Icons.arrow_forward,
            onPressed: () => _handleArrowButtonPress('Right'),
          ),
        ],
      ),
    );
  }
}

