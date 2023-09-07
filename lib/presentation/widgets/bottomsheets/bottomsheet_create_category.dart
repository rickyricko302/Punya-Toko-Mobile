import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/util/message.dart';

import '../../../data/constants/assets_color.dart';
import '../textforms/text_form.dart';
import '../texts/poppins_text.dart';

class BottomSheetCreateCategory extends StatelessWidget {
  const BottomSheetCreateCategory(
      {super.key, required this.bloc, required this.textController});
  final CreateProductBloc bloc;
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
                text: "Tambah Kategori",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PoppinsText(
              text: "Nama Produk",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AssetsColor.grey,
            ),
            TextForm(
                formController: textController,
                hint: "Masukan nama produk",
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
                      bloc.add(CreateCategoryEvent(name: textController.text));
                    } else {
                      Message.showErrorToast(msg: "Nama masih kosong!");
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocListener<CreateProductBloc, CreateProductState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is CreateProductSuccess) {
                  Message.showSuccessToast(msg: "Berhasil membuat produk");
                  Navigator.popUntil(
                      context,
                      (route) =>
                          route.settings.name == RoutesPage.createProduct);
                } else if (state is CreateProductFailed) {
                  Message.showErrorToast(msg: "Gagal membuat product");
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
