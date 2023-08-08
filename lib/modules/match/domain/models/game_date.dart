import 'package:intl/intl.dart';

class GameDate {
  final int weekDay;

  GameDate({required this.weekDay});

  DateTime getNextDate() {
    DateTime now = DateTime.now();
    while(now.weekday != weekDay) {
      now = now.add(Duration(days: 1));
    }

    return now;
  }

  String getNextDateFormatted() {
    return DateFormat('EEEE (dd/MM)').format(getNextDate());
  }
}