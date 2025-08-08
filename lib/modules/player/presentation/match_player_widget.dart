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
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.matchPlayer.player.name,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4,),
                      playerStatusChip(widget.matchPlayer),
                      /*Text(
                        "(${widget.matchPlayer.status.value})",
                        style: TextStyle(fontSize: 12, backgroundColor: getPlayerStatusColor(widget.matchPlayer)),
                      ),*/
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PopupMenuButton<MatchPlayerStatus>(
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
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Habilidade", style: TextStyle(fontSize: 12)),
                      Text(
                        widget.matchPlayer.player.overall.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        return Colors.red.withOpacity(.7);
      case MatchPlayerStatus.NOT_CONFIRMED:
        return Colors.amber.withOpacity(.7);
      case MatchPlayerStatus.CONFIRMED:
        return Colors.blue.withOpacity(.7);
      case MatchPlayerStatus.READY:
        return Colors.green.withOpacity(.7);
    }
  }

  Widget playerStatusChip(MatchPlayer player) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.transparent),
          color: getPlayerStatusColor(player),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Text(player.status?.value ?? "", style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold), ),
      ),
    );
  }
}
