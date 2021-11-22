import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms/core/color_style.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    required this.padding,
    required this.isObscureText,
    required this.hintText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final bool isObscureText;
  final String hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: isObscureText,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]'))
        ],
        decoration: InputDecoration(
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
          hintText: hintText,
          errorText: errorText,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
