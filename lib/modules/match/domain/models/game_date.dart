class GameDate {
  final int weekDay;

  GameDate({required this.weekDay});

  @override
  DateTime getNextDate() {
    DateTime now = DateTime.now();
    while(now.weekday != weekDay) {
      now = now.add(Duration(days: 1));
    }

    return now;
  }
}