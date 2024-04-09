import 'package:flutter/material.dart';

class ActiveStratagems extends StatelessWidget {
  final List<CustomListItem> items;

  const ActiveStratagems({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: items[index],
        );
      },
    );
  }
}

class CustomListItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const CustomListItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50, // Adjust size as needed
          height: 50, // Adjust size as needed
          color: Colors.blue, // Adjust color as needed
          child: Icon(
            iconData,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
