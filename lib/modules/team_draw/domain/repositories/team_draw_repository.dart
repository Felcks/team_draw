import 'package:team_randomizer/modules/team_draw/domain/models/team_draw.dart';

class TeamDrawRepository {

  static TeamDraw? _teamDraw = null;

  void setTeamDraw(TeamDraw? value) {
    _teamDraw = value;
  }

  TeamDraw? getTeamDraw() => _teamDraw;
}