import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final bool activation;
  final ValueChanged<bool> onChanged;

  const AnimatedToggle({
    Key? key,
    required this.activation,
    required this.onChanged,
  }) : super(key: key);

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.activation;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    if (_switchValue) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: RotationTransition(
        turns: _animation,
        child: Container(
          child: _switchValue
              ? Image.asset(
                  'assets/images/danger_yellow.png',
                  width: 120.0,
                  height: 120.0,
                )
              : Image.asset(
                  'assets/images/danger.png',
                  width: 120.0,
                  height: 120.0,
                ),
        ),
      ),
      onPressed: () {
        setState(() {
          _switchValue = !_switchValue;
          if (_switchValue) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          widget.onChanged(_switchValue);
        });
      },
    );
  }
}
