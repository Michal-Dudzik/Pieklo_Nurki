import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pieklo_nurki/components/utility.dart';
import 'package:scrollable/exports.dart';

class ActiveStratagems extends StatefulWidget {
  final List<String> svgPaths;
  final Map<String, List<String>> arrowSets; // Updated to use a map
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
    return ScrollHaptics(

      child: ListView.builder(
        itemCount: widget.svgPaths.length,
        itemBuilder: (BuildContext context, int index) {
          final stratagemName = Utils.getTitleFromPath(widget.svgPaths[index]);
          final arrowSet = widget.arrowSets[stratagemName]; // Access arrow set using the stratagem name

          if (arrowSet == null) {
            print('Arrow set not found for $stratagemName');
            return Container();
          }

          return SelectableItem(
            index: index,
            svgPath: widget.svgPaths[index],
            arrows: arrowSet, // Pass the arrow set to the SelectableItem widget
            isSelected: _selectedIndex == index,
            onTap: () {
              HapticFeedback.heavyImpact();
              setState(() {
                _selectedIndex = index;
              });
              if (widget.onItemSelected != null) {
                widget.onItemSelected!(index);
              }
            },
          );
        },
      ),
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
            const SizedBox(width: 5),
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
}
