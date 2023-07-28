import 'package:flutter/material.dart';

import '../../../data/constants/assets_color.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 5,
      decoration: BoxDecoration(
          color: AssetsColor.youngGreen,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
