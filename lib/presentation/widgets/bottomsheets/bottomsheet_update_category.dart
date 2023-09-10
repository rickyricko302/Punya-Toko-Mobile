import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/util/message.dart';

import '../../../data/constants/assets_color.dart';
import '../textforms/text_form.dart';
import '../texts/poppins_text.dart';

class BottomSheetUpdateCategory extends StatelessWidget {
  const BottomSheetUpdateCategory(
      {super.key, required this.onClick, required this.textController});
  final Function(String name) onClick;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: PoppinsText(
                text: "Ubah Kategori",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PoppinsText(
              text: "Nama Kategori",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AssetsColor.grey,
            ),
            TextForm(
                formController: textController,
                autoFocus: true,
                hint: "Masukan nama kategori",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GreenButton(
                  text: "Simpan",
                  callback: () {
                    FocusScope.of(context).unfocus();
                    if (textController.text.isNotEmpty) {
                      onClick(textController.text);
                    } else {
                      Message.showErrorToast(msg: "Nama masih kosong!");
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
