import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:netglade_onboarding_flutter/satellite_telemetry.dart';

class TelemetryWidget extends StatefulWidget {
  final String? authToken;
  const TelemetryWidget({super.key, this.authToken});

  @override
  State<TelemetryWidget> createState() => _TelemetryWidgetState();
}

class _TelemetryWidgetState extends State<TelemetryWidget> {
  List<SatelliteTelemetry>? telemetries;
  static const _pageSize = 20;
  final PagingController<int, SatelliteTelemetry> _pagingController =
      PagingController(firstPageKey: 1);
  dynamic input;

  String? fetchError;

  Future<void> fetchData(int pageKey) async {
    try {
      final uri = Uri.http('10.0.2.2:5104', '/telemetry', {
        'page': pageKey.toString(),
        'pageSize': _pageSize.toString(),
      });
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List;
        telemetries = jsonResponse
            .map(
              (data) =>
                  SatelliteTelemetry.fromJson(data as Map<String, dynamic>),
            )
            .toList()
            .reversed
            .toList();
        final isLastPage = telemetries!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(telemetries!);
        } else {
          final newPageKey = pageKey + 1;
          _pagingController.appendPage(telemetries!, newPageKey);
        }
      } else {
        throw Exception('Failed to load satelite telemetry');
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log(e.toString());
      fetchError = e.toString();
      _pagingController.error = e;
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_lambdas
    _pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        _pagingController.refresh,
      ),
      child: Stack(
        children: [
          PagedListView<int, SatelliteTelemetry>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<SatelliteTelemetry>(
              itemBuilder: (context, item, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: const Color.fromARGB(255, 206, 223, 235),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateTime.fromMillisecondsSinceEpoch(item.timestamp * 1000)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text('Altitude: ${item.altitude}'),
                          Text('Temperature: ${item.temperature}'),
                          Text('Velocity: ${item.velocity}'),
                          Text('Radiation: ${item.radiation}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _pagingController.refresh,
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
    );
  }
}
