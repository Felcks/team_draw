import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../game/domain/models/player.dart';


class PlayerWidget extends StatefulWidget {

  Player player;
  final int position;
  void Function(Player) changeStarCallback;

  PlayerWidget({Key? key, required this.player, required this.position, required this.changeStarCallback})
      : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {

  List<String> playerPhotos = [
    "https://img.a.transfermarkt.technology/portrait/header/46741-1472656986.jpg?lm=1"
    "https://img.a.transfermarkt.technology/portrait/header/28003-1671435885.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/3373-1515762355.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/177907-1663841733.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/403296-1598272878.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/653152-1650891670.JPG?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/547443-1547563183.png?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/50144-1458293316.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/47592-1512665647.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/348263-1483531190.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/418560-1656179352.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/88755-1684245748.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/371009-1582109366.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/68290-1669394812.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/8198-1685035469.png?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/45146-1663830086.jpg?lm=1"
    "https://img.a.transfermarkt.technology/portrait/header/3455-1579506060.jpg?lm=1"
    "https://img.a.transfermarkt.technology/portrait/header/244275-1660003081.jpg?lm=1",
    "https://img.a.transfermarkt.technology/portrait/header/248410-1668501457.jpg?lm=1"
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    playerPhotos[Random().nextInt(playerPhotos.length)],
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                Text(
                  "${this.widget.position} - ${this.widget.player.name}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 32 * 5,
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return getFilledOrEmptyStar(index+1);
              },
            ),
          ),
        ],),
      ),
    );
  }

  Widget getFilledOrEmptyStar(int star) {
    if(star <= this.widget.player.overall) {
      return SizedBox(
        width: 32,
        child: IconButton(
          onPressed: () {
            setState(() {
              this.widget.player = Player(name: this.widget.player.name, overall: star);
              this.widget.changeStarCallback(this.widget.player);
            });
          },
          icon: Icon(
            Icons.star,
            weight: 2,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 32,
        child: IconButton(
          onPressed: () {
            setState(() {
              this.widget.player = Player(name: this.widget.player.name, overall: star);
              this.widget.changeStarCallback(this.widget.player);
            });
          },
          icon: Icon(
            Icons.star_border,
            weight: 2,
          ),
        ),
      );
    }
  }
}
