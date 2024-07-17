import "package:isar/isar.dart";

// running `flutter pub run build_runner build` will generate the part file
part "note.g.dart";

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
