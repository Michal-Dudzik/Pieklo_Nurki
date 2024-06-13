import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/utility.dart';
import 'package:pieklo_nurki/services/socket_connection_service.dart';

import 'gameConnectionStateNotifier.dart';

final stratagemsProvider =
    StateNotifierProvider<StratagemsNotifier, List<Stratagem>>((ref) {
  return StratagemsNotifier();
});

class StratagemsNotifier extends StateNotifier<List<Stratagem>> {
  StratagemsNotifier() : super([]);

  Future<void> loadStratagems() async {
    state = await Utils.loadStratagems();
  }
}

final gameConnectionStateNotifier =
    StateNotifierProvider<GameConnectionState, bool>((ref) {
  final socketService = ref.watch(socketConnectionProvider);
  return GameConnectionState(socketService);
});

final selectedIndexProvider = StateProvider<int>((ref) => -1);

final streakProvider = StateProvider<int>((ref) => 0);

final successfulCallProvider = StateProvider<bool>((ref) => false);

final pressedArrowsQueueProvider =
    StateProvider<Queue<String>>((ref) => Queue<String>());

final toggleProvider = StateProvider<bool>((ref) => false);

final scannedDataProvider = StateProvider<String?>((ref) => null);

final socketConnectionProvider =
    ChangeNotifierProvider<SocketConnectionService>((ref) {
  return SocketConnectionService();
});
