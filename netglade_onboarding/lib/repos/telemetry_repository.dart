import "package:dio/dio.dart";
import "package:netglade_onboarding/models/telemetry.dart";

class TelemetryRepository {
  final Dio _dio;

  TelemetryRepository(this._dio);

  Future<List<Telemetry>> retrieveTelemetry(
    String token,
    DateTime? start,
    DateTime? end,
  ) async {
    final response = await _dio.get("/telemetry?pageSize=99",
        options: Options(headers: {
          "Authorization": "Bearer $token"
        }, extra: {
          "startingTimeStamp":
              start != null ? start.microsecondsSinceEpoch / 1000 : null,
          "endingTimeStamp":
              end != null ? end.microsecondsSinceEpoch / 1000 : null,
        }));

    if (response.statusCode == 200) {
      print("Telemetry retrieved");
      return (response.data as List).map((e) => Telemetry.fromJson(e)).toList();
    } else {
      print(response);
      throw Exception("Failed to retrieve telemetry");
    }
  }
}
