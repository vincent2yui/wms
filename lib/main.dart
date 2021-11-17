import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/color_style.dart';

import 'core/entity/configuration.dart';
import 'user_auth/user_auth_login_page.dart';

final Injected<Configuration> config =
    RM.inject(() => Configuration.production);

final username = RM.inject<Username>(
  () => Username(''),
  stateInterceptor: (currentSnap, nextSnap) {
    if (nextSnap.data!.username.isEmpty) {
      return nextSnap.copyToHasError(
        Exception('Enter a valid username'),
        stackTrace: StackTrace.current,
      );
    }
  },
);
final password = RM.inject<Password>(
  () => Password(''),
  stateInterceptor: (currentSnap, nextSnap) {
    if (nextSnap.data!.password.isEmpty) {
      return nextSnap.copyToHasError(
        Exception('Enter a valid password'),
        stackTrace: StackTrace.current,
      );
    }
  },
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorStyle.primaryColor,
      ),
      home: OnReactive(
        () {
          if (config.state == Configuration.production) {
            return const LoginPage();
          }

          return Banner(
            location: BannerLocation.topStart,
            message: config.state.displayBannerName,
            color: config.state.bannerColor,
            // color: Colors.green.withOpacity(0.6), // Green Demo
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: const LoginPage(),
          );
        },
      ),
    );
  }
}

class Username {
  final String username;

  Username(this.username);
}

class Password {
  final String password;

  Password(this.password);
}
