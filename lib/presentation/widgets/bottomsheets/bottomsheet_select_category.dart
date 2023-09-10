import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/util/bottomsheet_helper.dart';
import '../../../data/constants/assets_color.dart';
import '../texts/poppins_text.dart';

class BottomSheetSelectCategory extends StatelessWidget {
  const BottomSheetSelectCategory(
      {super.key, required this.bloc, required this.textController});
  final CreateProductBloc bloc;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PoppinsText(
            text: "Pilih Kategori",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.5.sh),
            child: ListView.builder(
                itemCount: 30,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      bloc.add(SelectCategoryEvent(index: index));
                      textController.value =
                          TextEditingValue(text: index.toString());
                      Navigator.pop(context);
                    },
                    title:
                        PoppinsText(text: "kategori $index", fontSize: 15.sp),
                    trailing: Checkbox(
                        fillColor: MaterialStatePropertyAll(AssetsColor.green),
                        shape: const CircleBorder(),
                        value: index == bloc.state.indexCategory,
                        onChanged: null),
                  );
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: GreenButton(
                    text: "Tambah Kategori",
                    callback: () {
                      BottomSheetHelper.showCreateCategory(
                          context: context,
                          onClick: (name) =>
                              bloc.add(CreateCategoryEvent(name: name)),
                          textController: TextEditingController());
                    })),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
