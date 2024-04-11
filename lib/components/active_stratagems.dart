import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pieklo_nurki/components/utility.dart';

class ActiveStratagems extends StatefulWidget {
  final List<String> svgPaths;
  final List<List<String>> arrowSets;
  final ValueChanged<int>? onItemSelected;

  const ActiveStratagems({
    Key? key,
    required this.svgPaths,
    required this.arrowSets,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _ActiveStratagemsState createState() => _ActiveStratagemsState();
}

class _ActiveStratagemsState extends State<ActiveStratagems> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.svgPaths.length,
      itemBuilder: (BuildContext context, int index) {
        return SelectableItem(
          index: index,
          svgPath: widget.svgPaths[index],
          arrows: widget.arrowSets[index],
          isSelected: _selectedIndex == index,
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(index);
            }
          },
        );
      },
    );
  }
}

class SelectableItem extends StatelessWidget {
  final int index;
  final String svgPath;
  final List<String> arrows;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableItem({
    Key? key,
    required this.index,
    required this.svgPath,
    required this.arrows,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.grey : Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              color: Colors.black,
              child: SvgPicture.asset(
                svgPath,
                // width: 40,
                // height: 40,
              ),
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Utils.getTitleFromPath(svgPath),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  Utils.mapDirectionsToArrows(arrows),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // String _getTitleFromPath(String path) {
    //   String fileName = path.split('/').last;
    //   String title = fileName.replaceAll('.svg', '');
    //   title = title.replaceAll('_', ' ');
    //   return title;
    // }
    //
    // String _getSubtitle(List<String> arrows) {
    //   List<String> arrowStrings = [];
    //   for (String arrow in arrows) {
    //     switch (arrow) {
    //       case 'up':
    //         arrowStrings.add('↑');
    //         break;
    //       case 'down':
    //         arrowStrings.add('↓');
    //         break;
    //       case 'left':
    //         arrowStrings.add('←');
    //         break;
    //       case 'right':
    //         arrowStrings.add('→');
    //         break;
    //       default:
    //         break;
    //     }
    //   }
    //   return arrowStrings.join(' ');
    // }

}
