import 'package:netglade_onboarding/models/telemetry.dart';

bool isFavorite(Telemetry telemetry, List<Telemetry> favouriteTelemetries) {
  return favouriteTelemetries
      .any((t) => t.telemetryId == telemetry.telemetryId);
}
