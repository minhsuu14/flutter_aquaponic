import '../models/sensors_data.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';

class DataDisplay extends StatefulWidget {
  const DataDisplay({Key? key}) : super(key: key);

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  Timer? timer;

  Future<void> _fetchData() async {
    final dataProvider =
        Provider.of<SensorDataProvider>(context, listen: false);
    await dataProvider.fetchTempData();
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _fetchData();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<SensorDataProvider>(context);
    var temp = dataProvider.data.last.temp;
    var hum = dataProvider.data.last.hum;

    return Container(
      child: Column(children: [
        Container(
          height: 300,
          width: 300,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 4000,
              axes: [
                RadialAxis(
                  radiusFactor: 0.75,
                  showTicks: false,
                  minimum: 0,
                  maximum: 50,
                  showLabels: false,
                  pointers: [
                    RangePointer(
                      gradient: const SweepGradient(
                          colors: [Colors.orange, Colors.deepOrange]),
                      value: temp ?? 0,
                      enableAnimation: true,
                    )
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Column(
                        children: [
                          Image.asset(
                            'assets/images/weather.png',
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$temp℃',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      ),
                      positionFactor: 0.7,
                      angle: 90,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 300,
          width: 300,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 4000,
              axes: [
                RadialAxis(
                  radiusFactor: 0.75,
                  showTicks: false,
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  pointers: [
                    RangePointer(
                      gradient: SweepGradient(
                          colors: [Colors.blue, Colors.blue.shade800]),
                      value: hum ?? 0,
                      enableAnimation: true,
                    )
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Column(
                        children: [
                          Image.asset(
                            'assets/images/humidity.png',
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$hum%',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      ),
                      positionFactor: 0.7,
                      angle: 90,
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
