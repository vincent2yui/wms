import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wms/core/color_style.dart';

import '../../main.dart';

class PickingMainPage extends StatelessWidget {
  const PickingMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerPage(
      child: Scaffold(
        appBar: AppBar(
          title: OnReactive(() => Text('${username.state.username} - Picking')),
        ),
        body: ListView.separated(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 20),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Batch $index'),
                  subtitle: Text('Quantity $index'),
                  leading: const FaIcon(
                    FontAwesomeIcons.exclamationCircle,
                    size: 30,
                    color: ColorStyle.disableMainColor,
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: 30,
                    color: ColorStyle.disableMainColor,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
