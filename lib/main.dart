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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                child: const Text(
                  'RECEIVING',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.assignment_ind),
                              title: const Text('Picking Module'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const TextField(),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Photo'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.music_note),
                              title: const Text('Music'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.videocam),
                              title: const Text('Video'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'PUT AWAY',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'PICKING',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'LOADING',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'REPLENISHMENT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'CYCLE COUNT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
