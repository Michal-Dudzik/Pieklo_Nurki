import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class AnimatedToggle extends ConsumerStatefulWidget {
  const AnimatedToggle({Key? key}) : super(key: key);

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends ConsumerState<AnimatedToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final switchValue = ref.watch(toggleProvider);

    if (switchValue) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    return IconButton(
      icon: RotationTransition(
        turns: _animation,
        child: Container(
          child: switchValue
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
        ref.read(toggleProvider.notifier).state = !switchValue;
      },
    );
  }
}
