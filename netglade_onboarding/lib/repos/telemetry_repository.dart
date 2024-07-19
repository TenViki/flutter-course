import "package:dio/dio.dart";
import "package:netglade_onboarding/models/telemetry.dart";

class TelemetryRepository {
  final Dio _dio;

  TelemetryRepository(this._dio);

  Future<List<Telemetry>> retrieveTelemetry(
    String token,
    DateTime? start,
    DateTime? end,
    int? minAltitude,
    int? maxAltitude,
  ) async {
    try {
      final response = await _dio.get("/telemetry",
          options: Options(headers: {"Authorization": "Bearer $token"}),
          queryParameters: {
            "pageSize": "99",
            if (maxAltitude != null) "highestAltitude": maxAltitude.toString(),
            if (minAltitude != null) "lowestAltitude": minAltitude.toString(),
            if (start != null)
              "startingTimeStamp":
                  (start.microsecondsSinceEpoch ~/ 1000).toString(),
            if (end != null)
              "endingTimeStamp":
                  (end.microsecondsSinceEpoch ~/ 1000).toString(),
          });

      if (response.statusCode == 200) {
        print("Telemetry retrieved");
        return (response.data as List)
            .map((e) => Telemetry.fromJson(e))
            .toList();
      } else {
        print(response);
        throw Exception("Failed to retrieve telemetry");
      }
    } on DioException catch (e) {
      print(e.response);

      //

      throw Exception("Failed to retrieve telemetry");
    }
  }
}
