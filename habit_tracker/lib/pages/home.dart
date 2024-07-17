import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/main_drawer.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:habit_tracker/util/habit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _habitNameController = TextEditingController();

  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  void createHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Create a new habit"),
              content: TextField(
                controller: _habitNameController,
                decoration: const InputDecoration(hintText: "Habit name"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<HabitDatabase>()
                        .addHabit(_habitNameController.text);
                    Navigator.pop(context);
                    _habitNameController.clear();
                  },
                  child: const Text("Create"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createHabit,
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: _buildHabitList(),
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> habits = habitDatabase.currentHabits;

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];

        bool isCompletedToday = isHabitCompletedToday(habit, DateTime.now());

        return HabitTile(isCompleted: isCompletedToday, name: habit.name);
      },
    );
  }
}
