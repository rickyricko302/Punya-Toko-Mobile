import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);
  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AssetsColor.lightGrey)),
            backgroundColor: AssetsColor.white,
          ),
          onPressed: callback,
          child: PoppinsText(
            text: text,
            fontSize: 15.sp,
            color: AssetsColor.black,
          )),
    );
  }
}
