import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ExpandableMenu(
        width: 50.0,
        height: 50.0,
        backgroundColor: Colors.black.withOpacity(.4),
        iconColor: Colors.white,
        itemContainerColor: const Color(0xffffe80a),
        items: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Navigator.pushNamed(context, '/settings_screen');
            },
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
          IconButton(
            padding: const EdgeInsets.all(8),
            onPressed: () {
              Navigator.pushNamed(context, '/game_connection');
            },
            icon: Image.asset('assets/images/danger_black.png'),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/companion_screen');
            },
            icon: const Icon(Icons.token, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
