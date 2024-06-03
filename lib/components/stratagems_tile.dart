import 'dart:ui';

import 'package:flutter/material.dart';

class StratagemsTitle extends StatelessWidget {
  const StratagemsTitle({Key? key}) : super(key: key);

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
