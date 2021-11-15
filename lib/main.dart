import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A1'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(18),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 118,
        ),
        children: const [
          ActivityCard(
            activityName: "Receiving",
            activityNameLogo: "receiving1.png",
            isActive: true,
          ),
          ActivityCard(
            activityName: "Put Away",
            activityNameLogo: "put_away1.png",
            isActive: false,
          ),
          ActivityCard(
            activityName: "Picking",
            activityNameLogo: "picking1.png",
            isActive: false,
          ),
          ActivityCard(
            activityName: "Loading",
            activityNameLogo: "loading1.png",
            isActive: true,
          ),
          ActivityCard(
            activityName: "Replenishment",
            activityNameLogo: "replenishment1.png",
            isActive: true,
          ),
          ActivityCard(
            activityName: "Cycle Count",
            activityNameLogo: "cycle_count1.png",
            isActive: true,
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    required this.activityName,
    required this.activityNameLogo,
    this.isActive = false,
  }) : super(key: key);

  final String activityName;
  final String activityNameLogo;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isActive ? Theme.of(context).primaryColor : Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/activity_logo/$activityNameLogo',
            color: isActive ? Colors.white : Colors.black38,
            scale: 3.5,
          ),
          const SizedBox(height: 5),
          Text(
            activityName,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black38,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
