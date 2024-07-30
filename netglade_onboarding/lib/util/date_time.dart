import "package:intl/intl.dart";

String getTime(int timestamp) {
  final d = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final formatter = DateFormat('HH:mm:ss');
  return formatter.format(d);
}

String getDate(int timestamp) {
  final d = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final formatter = DateFormat('dd. MM. yyyy');
  return formatter.format(d);
}

String getDateTime(int timestamp) {
  final d = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final formatter = DateFormat('dd. MM. yyyy HH:mm:ss');
  return formatter.format(d);
}

String formatDateTime(DateTime d) {
  final formatter = DateFormat('dd. MM. yyyy');
  return formatter.format(d);
}

bool isNumber(String? s) {
  if (s == null) {
    return false;
  }

  print(s);
  print(int.tryParse(s) != null);

  return int.tryParse(s) != null;
}
