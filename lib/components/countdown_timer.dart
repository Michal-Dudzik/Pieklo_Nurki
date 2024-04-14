import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final bool successfulCall;
  final Function()? onCountdownComplete;

  const CountdownTimer({Key? key, required this.successfulCall, this.onCountdownComplete}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _counter = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          if (widget.onCountdownComplete != null) {
            widget.onCountdownComplete!();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: const TextStyle(fontSize: 40),
    );
  }
}
