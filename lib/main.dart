import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wms/core/color_style.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorStyle.primaryColor,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.length.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<List<User>> fetchUsers() async {
  Map<String, String> requestHeaders = {
    'Authorization': 'Basic Vm9jb2xsZWN0OkFiY2RAMTIzNDU=',
    'Cookie': 'sap-usercontext=sap-client=200',
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': 'X'
  };

  final response = await http.get(
      Uri.parse(
          'http://s4prdapp01.ffpgroup.net:8000/sap/opu/odata/sap/ZEWM_USERS_SRV/usersrecordSet'),
      headers: requestHeaders);

  if (response.statusCode == 200) {
    List<User> userList = [];

    for (var user in json.decode(response.body).values.first.values.first) {
      userList.add(
        User(
            warehouseName: user['Lgnum'],
            username: user['Uname'],
            password: user['Password'],
            isReceivingActive: user['InbAct'],
            isPutAwayActive: user['PtaAct'],
            isPickingActive: user['OutAct'],
            isLoadingActive: user['LdgAct'],
            isReplenishmentActive: user['PrmAct'],
            isCycleCountActive: user['CycAct']),
      );
    }
    return userList;
  } else {
    throw Exception('Failed to load users');
  }
}

class User {
  final String warehouseName;
  final String username;
  final String password;
  final String isReceivingActive;
  final String isPutAwayActive;
  final String isPickingActive;
  final String isLoadingActive;
  final String isReplenishmentActive;
  final String isCycleCountActive;

  User({
    required this.warehouseName,
    required this.username,
    required this.password,
    required this.isReceivingActive,
    required this.isPutAwayActive,
    required this.isPickingActive,
    required this.isLoadingActive,
    required this.isReplenishmentActive,
    required this.isCycleCountActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      warehouseName: json['Lgnum'],
      username: json['Uname'],
      password: json['Password'],
      isReceivingActive: json['InbAct'],
      isPutAwayActive: json['PtaAct'],
      isPickingActive: json['OutAct'],
      isLoadingActive: json['LdgAct'],
      isReplenishmentActive: json['PrmAct'],
      isCycleCountActive: json['CycAct'],
    );
  }
}
