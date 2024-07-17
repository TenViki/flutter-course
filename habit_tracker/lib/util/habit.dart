import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(Habit habit, DateTime today) {
  return habit.completedDays.any((date) =>
      date.day == today.day &&
      date.month == today.month &&
      date.year == today.year);
}
