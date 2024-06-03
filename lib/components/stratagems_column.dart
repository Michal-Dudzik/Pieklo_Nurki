import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/active_stratagems.dart';
import 'package:pieklo_nurki/components/utility.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class StratagemsColumn extends ConsumerWidget {
  const StratagemsColumn({
    Key? key,
    required this.stratagems,
    required this.selectedIndex,
    required this.successfulCall,
  }) : super(key: key);

  final List<Stratagem> stratagems;
  final int selectedIndex;
  final bool successfulCall;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    ref.read(selectedIndexProvider.notifier).state = index;
                    ref.read(successfulCallProvider.notifier).state = false;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
