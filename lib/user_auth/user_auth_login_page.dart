import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/color_style.dart';
import 'package:wms/core/entity/configuration.dart';
import 'package:wms/core/entity/user.dart';
import 'package:wms/main.dart';
import 'package:wms/user_auth/widgets/login_textfield.dart';

import 'user_auth_main_menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  bool get isValid => username.hasData && password.hasData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: OnReactive(
          () => Column(
            children: [
              LoginTextField(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                isObscureText: false,
                hintText: "Username",
                errorText: username.error?.message,
                onChanged: (String value) => username.state = Username(value),
              ),
              const SizedBox(height: 10),
              LoginTextField(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10),
                isObscureText: true,
                hintText: "Password",
                errorText: password.error?.message,
                onChanged: (String value) => password.state = Password(value),
                onSubmitted: isValid
                    ? (String value) async {
                        await processLogin(context);
                      }
                    : (String value) {}, // Disable Login Process,
              ),
              const SizedBox(height: 10),
              OnBuilder.data(
                listenToMany: [username, password],
                builder: (exposedModel) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(280, 60),
                      primary: ColorStyle.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: isValid
                        ? () async {
                            await processLogin(context);
                          }
                        : () {}, // Disable Login Process
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 20.0),
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
      ),
    );
  }

  Future<void> processLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder<bool>(
              future: authService.state.isUserValid(User(
                username: username.state.username.toUpperCase(),
                password: password.state.password,
              )),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    debugPrint('User Authenticated');
                  } else {
                    debugPrint('Invalid User Details');
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.timesCircle,
                          size: 30,
                          color: ColorStyle.errorColor,
                        ),
                        SizedBox(width: 10),
                        Text('Invalid User Details'),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.timesCircle,
                        size: 30,
                        color: ColorStyle.errorColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${snapshot.error}',
                        softWrap: true,
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircularProgressIndicator(
                      color: ColorStyle.primaryColor,
                    ),
                    SizedBox(width: 20),
                    Text('Checking Details...'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
    var result = await authService.state.isUserValid(User(
      username: username.state.username.toUpperCase(),
      password: password.state.password,
    ));
    if (result) {
      RM.navigate.toReplacement(const MainMenu());
    }
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
