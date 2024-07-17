import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(Habit habit, DateTime today) {
  return habit.completedDays.any((date) =>
      date.day == today.day &&
      date.month == today.month &&
      date.year == today.year);
}

Map<DateTime, int> getHeatMapData(List<Habit> habits) {
  Map<DateTime, int> data = {};

  habits.forEach((habit) {
    for (var date in habit.completedDays) {
      final normalizedDate = DateTime(date.year, date.month, date.day);

      if (data.containsKey(normalizedDate)) {
        data[normalizedDate] = data[normalizedDate]! + 1;
      } else {
        data[normalizedDate] = 1;
      }
    }
  });

  print(data);

  return data;
}
