import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  const ArrowButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.size = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: size),
        color: color,
        onPressed: onPressed,
        highlightColor: Colors.transparent,
      ),
    );
  }
}

class ArrowPad extends StatefulWidget {
  const ArrowPad({Key? key}) : super(key: key);

  @override
  _ArrowPadState createState() => _ArrowPadState();
}

class _ArrowPadState extends State<ArrowPad> {
  Color leftArrowColor = Colors.white;
  Color rightArrowColor = Colors.white;
  Color upArrowColor = Colors.white;
  Color downArrowColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 180,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Transform.rotate(
                  angle: -90 * 3.14159 / 180,
                  child: ArrowButton(
                    icon: Icons.forward,
                    color: upArrowColor,
                    onPressed: () => _handleArrowButtonPress('up'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Transform.rotate(
                  angle: 180 * 3.14159 / 180,
                  child: ArrowButton(
                    icon: Icons.forward,
                    color: leftArrowColor,
                    onPressed: () => _handleArrowButtonPress('left'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: ArrowButton(
                  icon: Icons.forward,
                  color: rightArrowColor,
                  onPressed: () => _handleArrowButtonPress('right'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Transform.rotate(
                  angle: 180 * 3.14159 / 360,
                  child: ArrowButton(
                    icon: Icons.forward,
                    color: downArrowColor,
                    onPressed: () => _handleArrowButtonPress('down'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleArrowButtonPress(String direction) {
    HapticFeedback.heavyImpact();
    setState(() {
      switch (direction) {
        case 'left':
          leftArrowColor = Colors.yellow;
          break;
        case 'right':
          rightArrowColor = Colors.yellow;
          break;
        case 'up':
          upArrowColor = Colors.yellow;
          break;
        case 'down':
          downArrowColor = Colors.yellow;
          break;
      }
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        switch (direction) {
          case 'left':
            leftArrowColor = Colors.white;
            break;
          case 'right':
            rightArrowColor = Colors.white;
            break;
          case 'up':
            upArrowColor = Colors.white;
            break;
          case 'down':
            downArrowColor = Colors.white;
            break;
        }
      });
    });
  }
}
