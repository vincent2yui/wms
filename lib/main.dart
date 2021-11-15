import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';

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
        primaryColor: ColorStyle.primaryColor,
      ),
      home: const LoginMenu(),
    );
  }
}

class LoginMenu extends StatelessWidget {
  const LoginMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Login'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
