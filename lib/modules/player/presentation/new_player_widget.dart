import 'package:flutter/material.dart';

import '../../match/domain/models/match_player.dart';
import '../../match/domain/models/match_player_status.dart';
import '../domain/player.dart';

class NewPlayerWidget extends StatelessWidget {
  final Player player;

  const NewPlayerWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(
              const Radius.circular(12)
            ),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Habilidade", style: TextStyle(fontSize: 12)),
                    Text(
                      player.overall.toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getPlayerStatusColor(MatchPlayer player) {
    switch (player.status) {
      case MatchPlayerStatus.CANCELLED:
        return Colors.red.withOpacity(.5);
      case MatchPlayerStatus.NOT_CONFIRMED:
        return Colors.amber.withOpacity(.5);
      case MatchPlayerStatus.CONFIRMED:
        return Colors.blue.withOpacity(.5);
      case MatchPlayerStatus.READY:
        return Colors.green.withOpacity(.5);
    }
  }
}
