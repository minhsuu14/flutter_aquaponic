import 'package:flutter/material.dart';
import '../models/actuator.dart';
import 'package:provider/provider.dart';

class ControlActuator extends StatefulWidget {
  const ControlActuator({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlActuator> createState() => _ControlActuatorState();
}

class _ControlActuatorState extends State<ControlActuator> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) =>
        Provider.of<Actuator>(context, listen: false).fetchActuatorState());
  }

  @override
  Widget build(BuildContext context) {
    final actuator = Provider.of<Actuator>(context);
    return LayoutBuilder(
      builder: ((context, constraints) => Container(
            width: constraints.maxWidth * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Manual',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: actuator.manual,
                        onChanged: (value) async {
                          await actuator.isManual();
                          await actuator.fetchActuatorState();
                        }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Water Pump',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: actuator.water,
                        onChanged: actuator.manual
                            ? (value) async {
                                await actuator.controlWater();
                              }
                            : null),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Light',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: actuator.light,
                        onChanged: actuator.manual
                            ? (value) async {
                                await actuator.controlLight();
                              }
                            : null),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
