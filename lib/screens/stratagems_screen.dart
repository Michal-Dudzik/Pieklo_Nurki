import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/arrows_space.dart';
import 'package:pieklo_nurki/components/menu.dart';
import 'package:pieklo_nurki/components/stratagems_column.dart';
import 'package:pieklo_nurki/components/stratagems_tile.dart';
import 'package:pieklo_nurki/components/tips.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class StratagemsScreen extends ConsumerStatefulWidget {
  const StratagemsScreen({Key? key}) : super(key: key);

  @override
  _StratagemsScreenState createState() => _StratagemsScreenState();
}

class _StratagemsScreenState extends ConsumerState<StratagemsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(stratagemsProvider.notifier).loadStratagems();
  }

  @override
  Widget build(BuildContext context) {
    final stratagems = ref.watch(stratagemsProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final streak = ref.watch(streakProvider);
    final successfulCall = ref.watch(successfulCallProvider);
    final pressedArrowsQueue = ref.watch(pressedArrowsQueueProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const StratagemsTitle(),
                      const SizedBox(width: 10),
                      Tips(),
                      const SizedBox(width: 60),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: StratagemsColumn(
                            stratagems: stratagems,
                            selectedIndex: selectedIndex,
                            successfulCall: successfulCall,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: ArrowsSpace(
                            stratagems: stratagems,
                            selectedIndex: selectedIndex,
                            streak: streak,
                            successfulCall: successfulCall,
                            pressedArrowsQueue: pressedArrowsQueue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 10,
              right: 10,
              child: Menu(),
            ),
          ],
        ),
      ),
    );
  }
}
