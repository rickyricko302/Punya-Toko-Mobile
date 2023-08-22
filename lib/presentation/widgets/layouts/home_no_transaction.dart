import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets_color.dart';
import '../texts/poppins_text.dart';

class HomeNoTransaction extends StatelessWidget {
  const HomeNoTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_nodata.svg',
          height: 160.h,
        ),
        const SizedBox(
          height: 20,
        ),
        PoppinsText(
          text: "Belum ada catatan pembelian",
          fontSize: 18.sp,
          color: AssetsColor.grey,
        )
      ],
    )));
  }
}
