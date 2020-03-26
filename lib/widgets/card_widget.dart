import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardWidget extends StatelessWidget {
  final int data;
  final String title;
  final IconData icon;
  final Color color;

  const CardWidget({this.data, this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(color: color, fontSize: 20)),
        subtitle: FaIcon(icon, color: color),
        trailing: Text(data.toString(), style: TextStyle(color: color,fontSize: 30)),
      ),
      elevation: 5,
    );
  }
}
