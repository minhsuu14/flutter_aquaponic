import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Actuator with ChangeNotifier {
  bool water;
  bool light;
  bool manual;

  Actuator({this.light = false, this.water = false, this.manual = false});

  Future<void> controlFuntion(String field, bool value) async {
    final url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/data/actuators/$field.json');
    var oldStatus = value;
    value = !value;
    notifyListeners();
    final response = await http.put(url, body: json.encode(value));
    if (response.statusCode >= 400) {
      value = oldStatus;
      throw Exception();
    }
  }

  Future<void> controlWater() async {
    final url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/data/actuators/water.json');
    var oldStatus = water;
    water = !water;
    notifyListeners();
    final response = await http.put(url, body: json.encode(water));
    if (response.statusCode >= 400) {
      water = oldStatus;
      notifyListeners();
      throw Exception();
    }
  }

  Future<void> controlLight() async {
    final url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/data/actuators/light.json');
    var oldStatus = light;
    light = !light;
    notifyListeners();
    final response = await http.put(url, body: json.encode(light));
    if (response.statusCode >= 400) {
      light = oldStatus;
      notifyListeners();
      throw Exception();
    }
  }

  Future<void> isManual() async {
    final url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/data/actuators/manual.json');
    var oldStatus = manual;
    manual = !manual;
    notifyListeners();
    final response = await http.put(url, body: json.encode(manual));
    if (response.statusCode >= 400) {
      manual = oldStatus;
      notifyListeners();
      throw Exception();
    }
  }

  Future<void> fetchActuatorState() async {
    final url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/data/actuators.json');
    try {
      final response = await http.get(url);
      final loadedData = json.decode(response.body);
      water = loadedData['water'];
      light = loadedData['light'];
      manual = loadedData['manual'];
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }
}
