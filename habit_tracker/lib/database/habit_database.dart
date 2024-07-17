import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar _isar;

  // initialize the Isar instance
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar =
        await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

  // save the first launch date
  Future<void> saveFirstLaunchDate() async {
    final appSettings = await _isar.appSettings.where().findFirst();
    if (appSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await _isar.writeTxn(() => _isar.appSettings.put(settings));
    }

    notifyListeners();
  }

  // get the first launch date
  Future<DateTime?> getFirstLaunchDate() async {
    final appSettings = await _isar.appSettings.where().findFirst();
    return appSettings?.firstLaunchDate;
  }

  // CRUD Habit operations
  final List<Habit> currentHabits = [];

  Future<void> addHabit(String name) async {
    // cretae new habit
    final newHabit = Habit()..name = name;

    // save to db
    await _isar.writeTxn(() => _isar.habits.put(newHabit));

    // re read
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await _isar.habits.where().findAll();

    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    notifyListeners();
  }

  Future<void> toggleHabit(int id, bool isCompleted) async {
    final habit = await _isar.habits.get(id);

    if (habit != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (isCompleted) {
        habit.completedDays.add(today);
      } else {
        habit.completedDays.removeWhere((date) =>
            date.day == today.day &&
            date.month == today.month &&
            date.year == today.year);
      }

      await _isar.writeTxn(() => _isar.habits.put(habit));
    }
    readHabits();
  }

  Future<void> renameHabit(int id, String newName) async {
    final habit = await _isar.habits.get(id);

    if (habit == null) return;

    await _isar.writeTxn(() async {
      habit.name = newName;
      await _isar.habits.put(habit);
    });

    readHabits();
  }

  Future<void> deleteHabit(int id) async {
    await _isar.habits.delete(id);
    readHabits();
  }
}
