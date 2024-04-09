import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:pieklo_nurki/components/active_stratagems.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class StratagemsScreen extends StatefulWidget {
  const StratagemsScreen({Key? key}) : super(key: key);

  @override
  State<StratagemsScreen> createState() => _StratagemsScreenState();
}

class _StratagemsScreenState extends State<StratagemsScreen> {
  @override
  Widget build(BuildContext context) {
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
                  // First Row: Title and Menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStratagemsTitle(),
                      _buildExpandableMenu(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Second Row: Stratagems list and Arrows
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildStratagemsColumn(),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: _buildArrowsSpace(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStratagemsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.4),
            child: ActiveStratagems(
              items: List.generate(
                5,
                (index) => CustomListItem(
                  iconData: Icons.star,
                  title: 'Stratagem $index',
                  subtitle: 'Description $index',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStratagemsTitle() {
    return Container(
      width: 170,
      height: 50,
      color: Colors.black.withOpacity(.4),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            'STRATAGEMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Chakra Petch',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowsSpace() {
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Image(
              //   width: 50,
              //   height: 50,
              //   image: Svg(
              //       'assets/stratagem_icons/Patriotic_Administration_Center/Spear.svg'),
              // ),
              Image.asset(
                'assets/images/logo.jpeg',
                width: 50,
                height: 50,
              ),
              Container(
                width: 470,
                height: 50,
                color: Colors.yellow,
              ),
            ],
          ),
          const SizedBox(height: 30),
          ArrowPad(),
        ],
      ),
    );
  }

  Widget _buildExpandableMenu() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ExpandableMenu(
        width: 50.0,
        height: 50.0,
        backgroundColor: Colors.black.withOpacity(.4),
        iconColor: Colors.white,
        itemContainerColor: Colors.black,
        items: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/settings_screen');
            },
            icon: Icon(Icons.settings, color: Colors.white),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/stratagems_selection_screen');
            },
            icon: Icon(Icons.select_all, color: Colors.white),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushNamed(context, '/companion_screen');
            },
            icon: Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
