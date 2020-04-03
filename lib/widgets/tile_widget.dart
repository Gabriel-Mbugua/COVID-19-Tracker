import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TileWidget extends StatelessWidget {
  final int data;
  final String title;
  final IconData icon;
  final Color color;

  const TileWidget({this.data, this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        dense: false,
        title: Text(title, style: TextStyle(color: color, fontSize: 20)),
        leading: FaIcon(icon, color: color),
        trailing: Text(data.toString(), style: TextStyle(color: color,fontSize: 20)),
      ),
    );
  }
}
