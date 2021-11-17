import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms/core/color_style.dart';
import 'package:wms/core/entity/configuration.dart';
import 'package:wms/core/entity/user.dart';
import 'package:wms/main.dart';

import 'repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]'))
                ],
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white12,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: ColorStyle.defaultScaffoldColor,
                    hintStyle: const TextStyle(
                      color: ColorStyle.disableMainColor,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Username"),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]'))
                ],
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white12,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: ColorStyle.defaultScaffoldColor,
                    hintStyle: const TextStyle(
                      color: ColorStyle.disableMainColor,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Password"),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(280, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                'LOGIN',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {},
            ),
            Center(
              child: FutureBuilder<List<User>>(
                future: fetchUsers(),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 25.0),
              child: GestureDetector(
                child: Image.asset(
                  'assets/company_logo.png',
                  scale: 2.5,
                ),
                onLongPress: () {
                  buildShowModalBottomSheet(context);
                },
              ),
            ),
            const Text(
              'Warehouse Management System 1.0.0',
              style: TextStyle(color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 60,
                        scrollController: FixedExtentScrollController(
                            initialItem: config.state.index),
                        onSelectedItemChanged: (index) {
                          debugPrint(index.toString());
                          config.state = Configuration.values[index];
                        },
                        children: <Widget>[
                          Center(
                            child: Text(Configuration.embedded.displayName),
                          ),
                          Center(
                            child: Text(Configuration.development.displayName),
                          ),
                          Center(
                            child: Text(Configuration.production.displayName),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}