import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/color_style.dart';
import 'package:wms/core/entity/configuration.dart';
import 'package:wms/core/entity/user.dart';
import 'package:wms/main.dart';
import 'package:wms/user_auth/repository/demo_user_repository.dart';
import 'package:wms/user_auth/repository/development_user_repository.dart';
import 'package:wms/user_auth/repository/production_user_repository.dart';
import 'package:wms/user_auth/services/authentication_service.dart';
import 'package:wms/user_auth/widgets/login_textfield.dart';

import 'user_auth_main_menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  bool get isValid => username.hasData && password.hasData;

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: OnReactive(
                () => Column(
                  children: [
                    LoginTextField(
                      controller: _usernameController,
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0),
                      isObscureText: false,
                      hintText: "Username",
                      errorText: username.error?.message,
                      onChanged: (String value) =>
                          username.state = Username(value),
                    ),
                    const SizedBox(height: 10),
                    LoginTextField(
                      controller: _passwordController,
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10),
                      isObscureText: true,
                      hintText: "Password",
                      errorText: password.error?.message,
                      onChanged: (String value) =>
                          password.state = Password(value),
                      onSubmitted: (areTextFieldsValid(
                              _usernameController, _passwordController))
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
                          key: const Key('LoginButtonKey'),
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
                          onPressed: areTextFieldsValid(
                                  _usernameController, _passwordController)
                              ? () async {
                                  await processLogin(context);
                                }
                              : () {}, // Disable Login Process
                        );
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 20.0),
                      child: GestureDetector(
                        key: const Key('CompanyLogoKey'),
                        child: Image.asset(
                          'assets/company_logo.png',
                          scale: 2.5,
                        ),
                        onLongPress: () {
                          buildEnvironmentShowActionBottomSheet(context);
                        },
                      ),
                    ),
                    Text(
                      'Warehouse Management System ${snapshot.data?.version}',
                      style: const TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool areTextFieldsValid(TextEditingController usernameController,
      TextEditingController passwordController) {
    return isValid &&
        (usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty);
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
                    CupertinoActivityIndicator(
                      animating: true,
                      radius: 20,
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

  Future<dynamic> buildEnvironmentShowActionBottomSheet(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose Environment'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(Configuration.embedded.displayName),
              onPressed: () {
                Navigator.pop(context);
                config.state = Configuration.embedded;
                authService.setState((s) => AuthenticationService(
                    userRepository: DemoUserRepository()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text(Configuration.development.displayName),
              onPressed: () {
                Navigator.pop(context);
                config.state = Configuration.development;
                authService.setState((s) => AuthenticationService(
                    userRepository: DevelopmentUserRepository()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text(Configuration.production.displayName),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                config.state = Configuration.production;
                authService.setState((s) => AuthenticationService(
                    userRepository: ProductionUserRepository()));
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }
}
