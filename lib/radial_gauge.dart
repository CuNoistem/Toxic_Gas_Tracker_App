// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatefulWidget {
  const RadialGauge({super.key});

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge> {

  final ScrollController _scrollController = ScrollController();

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
        sensorData = {};

        sensorData['h2s'] = dataMap['H2S'] as double?;
        sensorData['acetone'] = dataMap['acetone'] as double?;
        sensorData['ch4'] = dataMap['cH4'] as double?;
        sensorData['co'] = dataMap['cO'] as double?;
        sensorData['nh4'] = dataMap['nH4'] as double?;
        sensorData['h2'] = dataMap['ppmH2'] as double?;
        sensorData['lpg'] = dataMap['ppmLPG'] as double?;

        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease
            );
          },
          child: const Icon(Icons.arrow_upward),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: -4000,
                    maximum: 4000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['acetone'] != null
                                          ? sensorData['acetone']!.toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500,), 
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Acetone",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: sensorData['acetone'] ?? 0.0,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 1000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['h2s'] != null
                                          ? sensorData['h2s']!.toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Hydrogen Sulphide",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: sensorData['h2s'] ?? 0.0,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 1000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['ch4'] != null
                                          ? (sensorData['ch4']! / 100).toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Methane",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: (sensorData['ch4']! / 100),
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 1000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['co'] != null
                                          ? sensorData['co']!.toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Carbon Monoxide",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: sensorData['co'] ?? 0.0,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 1000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['nh4'] != null
                                          ? sensorData['nh4']!.toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Ammonia",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: sensorData['nh4'] ?? 0.0,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 1000,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['h2'] != null
                                          ? sensorData['h2']!.toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Hydrogen",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: sensorData['h2'] ?? 0.0,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 100,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sensorData !=
                                      null // Check if sensorData is initialized
                                  ? Text(
                                      sensorData['lpg'] != null
                                          ? (sensorData['lpg']! / 100).toStringAsFixed(2)
                                          : 'Loading...',
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                                    )
                                  : const Text('Loading data...'),
                              const Column(
                                children: [
                                  Text(
                                    "Sulphur Dioxide",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ]),
                        angle: 90,
                        positionFactor: 0.4,
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: (sensorData['lpg']! / 100),
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3200,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color.fromARGB(147, 29, 163, 105),
                        width: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
