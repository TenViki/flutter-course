import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import "package:netglade_onboarding/providers.dart";
import 'package:netglade_onboarding/util/telemetry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "telemetry_service.g.dart";

class TelemetryState extends Equatable {
  const TelemetryState();

  @override
  List<Object> get props => [];
}

class TelemetryLoading extends TelemetryState {}

class TelemetryData extends TelemetryState {
  final List<Telemetry> telemetry;
  final List<Telemetry> favouriteTelemetries;

  const TelemetryData(this.telemetry, this.favouriteTelemetries);

  @override
  List<Object> get props => [telemetry];
}

class TelemetryError extends TelemetryState {
  final String message;

  const TelemetryError(this.message);

  @override
  List<Object> get props => [message];
}

@riverpod
class TelemetryService extends _$TelemetryService {
  DateTime? startDate;
  DateTime? endDate;
  int? minAltitude;
  int? maxAltitude;
  List<Telemetry> favouriteTelemetries = [];

  @override
  TelemetryState build() {
    print("Building telemetry service");
    updateTelemetry(shouldUpdateFavourites: true);
    final timer = Timer.periodic(
      const Duration(seconds: 10),
      (t) => updateTelemetry(),
    );

    ref.onDispose(timer.cancel);

    return TelemetryLoading();
  }

  Future<void> updateTelemetry({bool shouldUpdateFavourites = false}) async {
    print("Updating telemetry");
    final telemetryRepository = ref.read(telemetryRepositoryProvider);
    final authState = ref.read(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return;
    }

    try {
      final telemetry = await telemetryRepository.retrieveTelemetry(
          authState.token, startDate, endDate, minAltitude, maxAltitude);

      if (shouldUpdateFavourites) {
        favouriteTelemetries = await updateFavourites();
      }

      state = TelemetryData(telemetry, favouriteTelemetries);
    } catch (e) {
      state = const TelemetryError("Failed to retrieve telemetry");
      return;
    }
  }

  Future<List<Telemetry>> updateFavourites() {
    final telemetryRepository = ref.read(telemetryRepositoryProvider);
    final authState = ref.read(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return Future.value([]);
    }

    final userId = authState.user.id;
    return telemetryRepository.getFavouriteTelemtries(authState.token, userId);
  }

  Future<void> toggleFavourite(
      Telemetry telemetry, BuildContext? context) async {
    final telemetryRepository = ref.read(telemetryRepositoryProvider);
    final authState = ref.read(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return;
    }
    final userId = authState.user.id;

    try {
      if (isFavorite(telemetry, favouriteTelemetries)) {
        await telemetryRepository.removeFavourite(
          authState.token,
          userId,
          telemetry.telemetryId,
        );
      } else {
        await telemetryRepository.addFavourite(
          authState.token,
          userId,
          telemetry.telemetryId,
        );
      }

      favouriteTelemetries = await updateFavourites();
      updateTelemetry(shouldUpdateFavourites: false);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite(telemetry, favouriteTelemetries)
                  ? "Added to favourites"
                  : "Removed from favourites",
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void setStartDate(DateTime? date) {
    print("Setting start date");
    startDate = date;
    updateTelemetry();
  }

  void setEndDate(DateTime? date) {
    endDate = date;
    updateTelemetry();
  }

  void setMinAltitude(int? altitude) {
    minAltitude = altitude;
    updateTelemetry();
  }

  void setMaxAltitude(int? altitude) {
    maxAltitude = altitude;
    updateTelemetry();
  }
}
