import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';

class MatchWidget extends StatelessWidget {
  final Match match;
  final void Function(Match) onClick;

  const MatchWidget({Key? key, required this.match, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call(match);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(32.0),
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            //Align(alignment: Alignment.center,)
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/football-field.png", width: 100, height: 100,),
                  Text(DateFormat("EEEE (dd/MM)").format(match.date))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
