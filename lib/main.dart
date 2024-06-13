import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/screens/companion_screen.dart';
import 'package:pieklo_nurki/screens/game_connection.dart';
import 'package:pieklo_nurki/screens/stratagems_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  Wakelock.enable().then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piekło Nurki',
      theme: ThemeData(
        fontFamily: 'ChakraPetch',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/game_connection': (context) => const GameConnection(),
        '/stratagems_screen': (context) => const StratagemsScreen(),
        '/companion_screen': (context) => const CompanionScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/intro_cropped.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying &&
          (_controller.value.position >= _controller.value.duration ||
              _controller.value.position >= const Duration(seconds: 31))) {
        Navigator.pushReplacementNamed(context, '/stratagems_screen');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/stratagems_screen');
          },
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
