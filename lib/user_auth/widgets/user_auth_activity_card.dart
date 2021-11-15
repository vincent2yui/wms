import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    required this.activityName,
    required this.activityNameLogo,
    this.isActive = false,
  }) : super(key: key);

  final String activityName;
  final String activityNameLogo;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: isActive
          ? Theme.of(context).primaryColor
          : ColorStyle.disableSecondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/activity_logo/$activityNameLogo',
            color: isActive
                ? ColorStyle.mainWhiteColor
                : ColorStyle.disableMainColor,
            scale: 3.5,
          ),
          const SizedBox(height: 5),
          Text(
            activityName,
            style: TextStyle(
              color: isActive
                  ? ColorStyle.mainWhiteColor
                  : ColorStyle.disableMainColor,
              // fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
