import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';

class ReceivingBottomSheetContent extends StatelessWidget {
  const ReceivingBottomSheetContent({Key? key}) : super(key: key);

  final String _activityName = 'Receiving';
  final String _hintText = 'ASN Number';
  final String _buttonName = 'ENTER';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 15),
            Text(
              _activityName,
              style: const TextStyle(
                fontSize: 18,
                color: ColorStyle.primaryColor,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 18.0),
              child: TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15.0),
                  suffix: GestureDetector(
                    onTap: () {
                      _controller.clear();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: ColorStyle.primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white12,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorStyle.primaryColor,
                      width: 2.0,
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
                  hintText: _hintText,
                ),
              ),
            ),
            ListTile(
              tileColor: ColorStyle.primaryColor,
              title: Center(
                child: Text(
                  _buttonName,
                  style: const TextStyle(color: ColorStyle.mainWhiteColor),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                debugPrint(_activityName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
