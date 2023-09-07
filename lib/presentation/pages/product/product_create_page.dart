import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/repositories/category_repository.dart';
import 'package:punyatoko/domain/usecases/create_category_usecase.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/textforms/text_form.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/bottomsheet.dart';

import '../../../data/constants/assets_color.dart';
import '../../widgets/textforms/rupiah_form.dart';
import '../../widgets/textforms/select_form.dart';

class ProductCreatePage extends StatelessWidget {
  const ProductCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateProductBloc(
          loaderButtonCubit: context.read<LoaderButtonCubit>(),
          createCategoryUseCase: CreateCategoryUseCase(
              categoryRepositoryImp: CategoryRepositoryImp())),
      child: const ProductCreateBody(),
    );
  }
}

class ProductCreateBody extends StatefulWidget {
  const ProductCreateBody({Key? key}) : super(key: key);

  @override
  _ProductCreateBodyState createState() => _ProductCreateBodyState();
}

class _ProductCreateBodyState extends State<ProductCreateBody> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productAmountroller = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController productStockController = TextEditingController();

  @override
  Widget build(BuildContext contexts) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AssetsColor.youngGreen.withOpacity(20 / 100),
        title: PoppinsText(text: "Tambah Produk", fontSize: 20.sp),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  formController: productNameController,
                  hint: "Masukan nama produk",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next),
              const SizedBox(
                height: 30,
              ),
              PoppinsText(
                text: "Harga Produk",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AssetsColor.grey,
              ),
              RupiahForm(
                  formController: productAmountroller,
                  hint: "Masukan harga produk",
                  textInputAction: TextInputAction.next),
              const SizedBox(
                height: 30,
              ),
              PoppinsText(
                text: "Kategori Produk",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AssetsColor.grey,
              ),
              SelectForm(
                formController: productCategoryController,
                hint: "Pilih kategori produk",
                onClick: () => BottomSheetHelper.showSelectCategory(
                    context: contexts,
                    bloc: context.read<CreateProductBloc>(),
                    textController: productCategoryController),
              ),
              const SizedBox(
                height: 30,
              ),
              PoppinsText(
                text: "Stok Produk",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AssetsColor.grey,
              ),
              TextForm(
                  formController: productStockController,
                  hint: "Masukan stok produk ",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GreenButton(
                    text: "Simpan",
                    callback: () {
                      contexts.read<LoaderButtonCubit>().setLoading(true);
                    }),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
