import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);
  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderButtonCubit, bool>(
      builder: (context, state) {
        if (state) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  backgroundColor: AssetsColor.green,
                ),
                onPressed: callback,
                child: PoppinsText(
                  text: text,
                  fontSize: 15.sp,
                  color: AssetsColor.white,
                )));
      },
    );
  }
}
