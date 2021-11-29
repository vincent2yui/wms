import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/color_style.dart';
import 'package:wms/user_auth/repository/production_user_repository.dart';
import 'package:wms/user_auth/user_auth_login_page.dart';

import 'core/entity/configuration.dart';
import 'core/entity/user.dart';
import 'user_auth/services/authentication_service.dart';

final Injected<Configuration> config =
    RM.inject(() => Configuration.production);

final Injected<AuthenticationService> authService = RM.inject(
    () => AuthenticationService(userRepository: ProductionUserRepository()));

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
      navigatorKey: RM.navigate.navigatorKey,
      title: 'Warehouse Management System',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorStyle.primaryColor,
          primarySwatch: createMaterialColor(ColorStyle.primaryColor)),
      home: const BannerPage(
        child: LoginPage(),
      ),
    );
  }
}

class BannerPage extends StatelessWidget {
  const BannerPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OnReactive(
      () {
        if (config.state == Configuration.production) {
          return child;
        }

        return Banner(
          location: BannerLocation.topStart,
          message: config.state.displayBannerName,
          color: config.state.bannerColor,
          textStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
          textDirection: TextDirection.ltr,
          child: child,
        );
      },
    );
  }
}
