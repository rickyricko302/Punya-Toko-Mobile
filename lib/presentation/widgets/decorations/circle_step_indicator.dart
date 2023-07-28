import 'package:flutter/material.dart';

import '../../../data/constants/assets_color.dart';

class CircleStepIndicator extends StatelessWidget {
  const CircleStepIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
          color: AssetsColor.lightGrey,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
