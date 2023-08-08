import 'package:flutter/material.dart';

import '../../match/domain/models/match_player.dart';
import '../../match/domain/models/match_player_status.dart';

class MatchPlayerWidget extends StatefulWidget {
  final MatchPlayer matchPlayer;
  final Function(MatchPlayer matchPlayer) onMatchPlayerStatusUpdate;

  const MatchPlayerWidget({Key? key, required this.matchPlayer, required this.onMatchPlayerStatusUpdate})
      : super(key: key);

  @override
  State<MatchPlayerWidget> createState() => _MatchPlayerWidgetState();
}

class _MatchPlayerWidgetState extends State<MatchPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    MatchPlayerStatus selectedPlayerStatus = widget.matchPlayer.status;
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(12)),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.matchPlayer.player.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(${widget.matchPlayer.status.value})",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Container(
                          color: getPlayerStatusColor(widget.matchPlayer),
                        ),
                      ),
                      PopupMenuButton<MatchPlayerStatus>(
                        initialValue: selectedPlayerStatus,
                        // Callback that sets the selected popup menu item.
                        onSelected: (MatchPlayerStatus item) {
                          setState(() {
                            selectedPlayerStatus = item;
                          });
                          widget.onMatchPlayerStatusUpdate.call(
                            MatchPlayer(
                                matchId: widget.matchPlayer.matchId, player: widget.matchPlayer.player, status: item),
                          );
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<MatchPlayerStatus>>[
                          const PopupMenuItem<MatchPlayerStatus>(
                            value: MatchPlayerStatus.NOT_CONFIRMED,
                            child: Text('Não Confirmado'),
                          ),
                          const PopupMenuItem<MatchPlayerStatus>(
                            value: MatchPlayerStatus.CANCELLED,
                            child: Text('Cancelado'),
                          ),
                          const PopupMenuItem<MatchPlayerStatus>(
                            value: MatchPlayerStatus.CONFIRMED,
                            child: Text('Confirmado'),
                          ),
                          const PopupMenuItem<MatchPlayerStatus>(
                            value: MatchPlayerStatus.READY,
                            child: Text('Pronto'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Overall Rating", style: TextStyle(fontSize: 12)),
                      Text(
                        widget.matchPlayer.player.overall.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
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
