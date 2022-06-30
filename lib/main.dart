import 'package:aquaponic_app/models/actuator.dart';
import 'package:aquaponic_app/models/sensors_data.dart';
import 'package:flutter/material.dart';
import 'screens/MyHomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => SensorDataProvider(),
        ),
        ChangeNotifierProvider(create: (ctx) => Actuator()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
