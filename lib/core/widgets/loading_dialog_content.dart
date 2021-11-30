import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LoadingDialogContent extends StatelessWidget {
  const LoadingDialogContent({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CupertinoActivityIndicator(
          animating: true,
          radius: 20,
        ),
        const SizedBox(width: 20),
        Text(title),
      ],
    );
  }
}
