import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/entity/user.dart';
import 'package:wms/main.dart';

import 'widgets/user_auth_activity_card.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  get loginUser => authService.state.loginUser(User(
        username: username.state.username.toUpperCase(),
        password: password.state.password,
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _onLogoutBackPress(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: OnReactive(() => Text(username.state.username)),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () async {
                return await _onLogoutBackPress(context);
              },
            )
          ],
        ),
        body: OnReactive(
          () => FutureBuilder<User>(
              future: loginUser,
              builder: (context, snapshot) {
                return GridView(
                  padding: const EdgeInsets.all(18),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 118,
                  ),
                  children: [
                    ActivityCard(
                      activityName: "Receiving",
                      activityNameLogo: "receiving1.png",
                      isActive: snapshot.data?.isReceivingActive == 'X',
                    ),
                    ActivityCard(
                      activityName: "Put Away",
                      activityNameLogo: "put_away1.png",
                      isActive: snapshot.data?.isPutAwayActive == 'X',
                    ),
                    ActivityCard(
                      activityName: "Picking",
                      activityNameLogo: "picking1.png",
                      isActive: snapshot.data?.isPickingActive == 'X',
                    ),
                    ActivityCard(
                      activityName: "Loading",
                      activityNameLogo: "loading1.png",
                      isActive: snapshot.data?.isLoadingActive == 'X',
                    ),
                    ActivityCard(
                      activityName: "Replenishment",
                      activityNameLogo: "replenishment1.png",
                      isActive: snapshot.data?.isReplenishmentActive == 'X',
                    ),
                    ActivityCard(
                      activityName: "Cycle Count",
                      activityNameLogo: "cycle_count1.png",
                      isActive: snapshot.data?.isCycleCountActive == 'X',
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<dynamic> _onLogoutBackPress(BuildContext context) async {
    debugPrint('Back button press');
    return (await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Logout'),
            content: const Text('Do you want to logout?'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
