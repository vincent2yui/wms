import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    required this.activityName,
    required this.activityNameLogo,
    this.isActive = false,
    required this.bottomSheetContent,
  }) : super(key: key);

  final String activityName;
  final String activityNameLogo;
  final bool isActive;
  final Widget bottomSheetContent;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: isActive
          ? Theme.of(context).primaryColor
          : ColorStyle.disableSecondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () {
          buildActivityShowActionBottomSheet(context);
        },
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
      ),
    );
  }

  Future<dynamic> buildActivityShowActionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return bottomSheetContent;
      },
    );
  }
}
