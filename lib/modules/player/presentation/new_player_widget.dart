import 'package:flutter/material.dart';

import '../../game/domain/models/player.dart';

class NewPlayerWidget extends StatelessWidget {
  final Player player;

  const NewPlayerWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(
            Radius.circular(12)
          ),
          shape: BoxShape.rectangle,
          color: Colors.grey.withOpacity(0.1),
        ),
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
      ),
    );
  }
}
