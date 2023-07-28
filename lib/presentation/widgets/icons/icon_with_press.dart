import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithPress extends StatelessWidget {
  const IconWithPress(
      {Key? key,
      required this.callback,
      required this.icon,
      this.width,
      this.height})
      : super(key: key);
  final VoidCallback callback;
  final String icon;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback,
        child: SvgPicture.asset(
          "assets/icons/$icon",
          width: width,
          height: height,
        ));
  }
}
