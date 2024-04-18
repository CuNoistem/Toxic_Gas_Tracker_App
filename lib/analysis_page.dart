import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference refdb = FirebaseDatabase.instance.ref("GASESS");
  late Stream<DatabaseEvent> stream;
  late Map<String, double?> sensorData = {};

  @override
  void initState() {
    super.initState();
    stream = refdb.onValue; // Use refdb instead of creating a new reference

    stream.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;

        sensorData['h2s'] = dataMap['H2S'] as double?;
        sensorData['acetone'] = dataMap['acetone'] as double?;
        sensorData['ch4'] = dataMap['cH4'] as double?;
        sensorData['co'] = dataMap['cO'] as double?;
        sensorData['nh4'] = dataMap['nH4'] as double?;
        sensorData['h2'] = dataMap['ppmH2'] as double?;
        sensorData['lpg'] = dataMap['ppmLPG'] as double?;

        setState(() {
          // UI update here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showLabels: false,
                  showAxisLine: false,
                  showTicks: false,
                  minimum: -4000,
                  maximum: 4000,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: -4000, 
                      endValue: 0,
                      color: Colors.green,
                      label: "Safe",
                      sizeUnit: GaugeSizeUnit.factor,
                      labelStyle: const GaugeTextStyle(
                          fontFamily: 'Times'),
                      startWidth: 0.65,
                      endWidth: 0.65,
                    ),
                    GaugeRange(
                      startValue: 0, 
                      endValue: 4000,
                      color: Colors.red,
                      label: "Danger",
                      sizeUnit: GaugeSizeUnit.factor,
                      labelStyle: const GaugeTextStyle(
                          fontFamily: 'Times'),
                      startWidth: 0.65,
                      endWidth: 0.65,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      enableAnimation: true,
                      animationType: AnimationType.bounceOut,
                      value: sensorData['acetone'] ?? 0.0,
                      needleLength: 0.7,
                      knobStyle: const KnobStyle(
                        knobRadius: 12,
                        sizeUnit: GaugeSizeUnit.logicalPixel,
                      )
                    )
                  ],
                )
              ],
            ),
            const Text(
              "Safety Analysis",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),   
            ),
          ],
        ),
      ),
    );
  }
}
