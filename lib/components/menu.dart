import 'package:flutter/material.dart';

import 'credits.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _isOpen
              ? _buildMenu()
              : SizedBox.shrink(key: const ValueKey("empty")),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: ElevatedButton(
            onPressed: _toggle,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffe80a),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              padding: EdgeInsets.zero,
            ),
            child: RotationTransition(
              turns: _controller,
              child: Icon(
                _isOpen ? Icons.close : Icons.menu,
                color: Colors.black,
                size: 32, // Icon size
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return Column(
      key: const ValueKey("menu"),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 60),
        _buildMenuItem(
          'assets/images/danger_black.png',
          "GAME CONNECTION",
          () {
            Navigator.pushNamed(context, '/game_connection');
          },
        ),
        _buildMenuItem(
          Icons.token,
          "COMPANION SCREEN",
          () {
            Navigator.pushNamed(context, '/companion_screen');
          },
        ),
        _buildMenuItem(Icons.group, "CREDITS", () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CreditsDialog();
            },
          );
        }),
      ],
    );
  }

  Widget _buildMenuItem(dynamic iconOrPath, String label, VoidCallback onTap) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero)
          .animate(_controller),
      child: FadeTransition(
        opacity: _controller,
        child: GestureDetector(
          onTap: () {
            _toggle();
            onTap();
          },
          child: Container(
            height: 50,
            width: 215,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              color: Color(0xffffe80a),
              borderRadius: BorderRadius.zero,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconOrPath is IconData)
                  Icon(iconOrPath, size: 22, color: Colors.black)
                else
                  Image.asset(iconOrPath, width: 20, height: 20),
                const SizedBox(width: 8),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
