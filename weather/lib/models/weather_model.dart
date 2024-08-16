import "package:freezed_annotation/freezed_annotation.dart";

part "weather_model.freezed.dart";

@freezed
class Weather with _$Weather {
  const factory Weather({
    required double temperature,
    required String condition,
    required String city,
    required double feelsLike,
    required int humidity,
    required double windSpeed,
    required int windDirection,
    required int pressure,
  }) = _Weather;
}
