import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../texts/poppins_text.dart';

class RadioWithText extends StatelessWidget {
  const RadioWithText(
      {Key? key,
      required this.text,
      required this.callback,
      required this.radioTap,
      required this.state})
      : super(key: key);
  final VoidCallback callback;
  final Function(String?) radioTap;
  final String state;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: text,
            groupValue: state,
            onChanged: radioTap,
          ),
          PoppinsText(text: "$text    ", fontSize: 15.sp)
        ],
      ),
    );
  }
}
