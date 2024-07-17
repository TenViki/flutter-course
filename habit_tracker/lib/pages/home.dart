import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/heatmap.dart';
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
    _habitNameController.clear();
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
              context.read<HabitDatabase>().addHabit(_habitNameController.text);
              Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void checkHabit(Habit habit, bool? value) {
    if (value == null) return;
    context.read<HabitDatabase>().toggleHabit(habit.id, value);
  }

  // on edit
  void editHabitBox(Habit habit) {
    _habitNameController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename habit"),
        content: TextField(
          controller: _habitNameController,
          decoration: const InputDecoration(hintText: "Habit name"),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              context
                  .read<HabitDatabase>()
                  .renameHabit(habit.id, _habitNameController.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete habit"),
        content: Text("Are you sure you want to delete this habit?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor:
                  WidgetStateProperty.all(Theme.of(context).colorScheme.error),
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.errorContainer),
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
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
      body: ListView(children: [_buildHeatmap(), _buildHabitList()]),
    );
  }

  Widget _buildHeatmap() {
    final database = context.watch<HabitDatabase>();
    List<Habit> habits = database.currentHabits;

    return FutureBuilder(
      future: database.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return HabitHeatMap(
            startDate: snapshot.data!,
            dataset: getHeatMapData(habits),
          );
        else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildHabitList() {
    final database = context.watch<HabitDatabase>();
    List<Habit> habits = database.currentHabits;

    return ListView.builder(
      itemCount: habits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = habits[index];

        bool isCompletedToday = isHabitCompletedToday(habit, DateTime.now());

        return HabitTile(
          isCompleted: isCompletedToday,
          name: habit.name,
          onChanged: (newValue) => checkHabit(habit, newValue),
          onEdit: () => editHabitBox(habit),
          onDelete: () => deleteHabitBox(habit),
        );
      },
    );
  }
}
