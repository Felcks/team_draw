import 'package:flutter/material.dart';

import '../../domain/models/player.dart';

class NewPlayerWidget extends StatelessWidget {
  final Player player;

  const NewPlayerWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              player.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                Text("Overall Rating", style: TextStyle(fontSize: 12)),
                Text(
                  player.overall.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
