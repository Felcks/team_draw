sealed class GameDate {
  DateTime getNextDate();
}

class OneTimeDate extends GameDate {
  final DateTime date;

  OneTimeDate({required this.date});

  @override
  DateTime getNextDate() {
    return date;
  }
}

class RecurrentDate extends GameDate {
  final int weekDay;

  RecurrentDate({required this.weekDay});

  @override
  DateTime getNextDate() {
    DateTime now = DateTime.now();
    while(now.weekday != weekDay) {
      now = now.add(Duration(days: 1));
    }

    return now;
  }
}