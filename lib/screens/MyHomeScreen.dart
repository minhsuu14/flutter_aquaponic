import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sensors_data.dart';
import '../models/actuator.dart';
import '../widgets/ControlActuator.dart';
import '../widgets/DataDisplay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> sensorFetchedData() {
    return Provider.of<SensorDataProvider>(context, listen: false)
        .fetchTempData();
  }

  late Future _futureSensor;
  @override
  void initState() {
    _futureSensor = sensorFetchedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: _futureSensor,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapshot.hasError) {
            throw (dataSnapshot.error.toString());
          } else {
            return SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: const [
                    Text(
                      'Sensors Data',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    DataDisplay(),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      thickness: 8,
                    ),
                    Text(
                      'Actuators',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    ControlActuator(),
                  ],
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
