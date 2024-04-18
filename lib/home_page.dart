import 'package:flutter/material.dart';

import 'analysis_page.dart';
import 'radial_gauge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;

  List<Widget> widgetList = const [
    RadialGauge(),
    AnalysisPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        backgroundColor: const Color(0xFF00A8B5),
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Analysis'
          ),
        ]),
          appBar: AppBar(
    title: const Text(
      "LifeLine",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    ),
    backgroundColor: Color(0xFF00A8B5),
    elevation: 10,
          ),
          body: IndexedStack(
    index: myIndex,
    children: widgetList,
          ),
        );
  }
}