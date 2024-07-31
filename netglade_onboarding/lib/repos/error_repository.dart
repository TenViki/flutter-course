import 'package:dio/dio.dart';
import 'package:netglade_onboarding/models/telemetry_error.dart';

class ErrorRepository {
  final Dio _dio;

  ErrorRepository(this._dio);

  Future<List<TelemetryError>> getErrors(String token) async {
    final response = await _dio.get('/telemetry/errors',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {
          'pageSize': '99',
        });

    if (response.statusCode == 200) {
      final errors = response.data as List;
      return errors.map((e) => TelemetryError.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get errors');
    }
  }
}
