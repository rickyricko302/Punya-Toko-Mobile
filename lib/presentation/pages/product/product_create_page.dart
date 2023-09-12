import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_key.dart';
import 'package:punyatoko/data/models/post/create_product_model.dart';
import 'package:punyatoko/data/repositories/category_repository.dart';
import 'package:punyatoko/domain/usecases/create_category_usecase.dart';
import 'package:punyatoko/domain/usecases/get_category_usecase.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/textforms/date_form.dart';
import 'package:punyatoko/presentation/widgets/textforms/text_form.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/bottomsheet_helper.dart';

import '../../../data/constants/assets_color.dart';
import '../../../data/constants/routes_page.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../domain/usecases/create_product_usecase.dart';
import '../../../util/message.dart';
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
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          getCategoryUseCase: GetCategoryUseCase(
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          createProductUseCase: CreateProductUseCase(
              productRepositoryImp:
                  RepositoryProvider.of<ProductRepositoryImp>(context)))
        ..add(const GetCategoryEvent()),
      child: const ProductCreateBody(),
    );
  }
}

class ProductCreateBody extends StatefulWidget {
  const ProductCreateBody({Key? key}) : super(key: key);

  @override
  State<ProductCreateBody> createState() => _ProductCreateBodyState();
}

class _ProductCreateBodyState extends State<ProductCreateBody> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productAmountroller = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController productStockController = TextEditingController();
  final TextEditingController productDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AssetsColor.youngGreen.withOpacity(20 / 100),
        title: PoppinsText(text: "Tambah Produk", fontSize: 20.sp),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: AssetsKey.formCreateProduct,
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
                BlocBuilder<CreateProductBloc, CreateProductState>(
                  buildWhen: (previous, current) =>
                      (previous.indexCategory != current.indexCategory) ||
                      (previous.categoryEntity != current.categoryEntity),
                  builder: (context, state) {
                    return SelectForm(
                        formController: productCategoryController,
                        hint: "Pilih kategori produk",
                        onRefresh: () => context
                            .read<CreateProductBloc>()
                            .add(const GetCategoryEvent()),
                        onClick: () => state is! GetCategoryFailed
                            ? BottomSheetHelper.showSelectCategory(
                                context: context,
                                bloc: context.read<CreateProductBloc>(),
                                textController: productCategoryController,
                                entities: state.categoryEntity)
                            : null,
                        status: context
                            .read<CreateProductBloc>()
                            .getStatusCategory());
                  },
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
                  height: 30,
                ),
                PoppinsText(
                  text: "Tanggal",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                DateForm(
                    formController: productDateController,
                    hint: "Pilih tanggal dibuat"),
                BlocBuilder<CreateProductBloc, CreateProductState>(
                    buildWhen: (previous, current) =>
                        previous.isExpense != current.isExpense,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Checkbox(
                              visualDensity: VisualDensity.compact,
                              value: state.isExpense,
                              onChanged: (value) {
                                context.read<CreateProductBloc>().add(
                                    CheckboxExpenseEvent(
                                        value: value ?? false));
                              }),
                          GestureDetector(
                            onTap: () {
                              context.read<CreateProductBloc>().add(
                                  CheckboxExpenseEvent(
                                      value: !state.isExpense));
                            },
                            child: PoppinsText(
                                text: "Tambahkan sebagai pengeluaran",
                                fontSize: 15.sp),
                          )
                        ],
                      );
                    }),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: GreenButton(
                      text: "Simpan",
                      callback: () {
                        final isValid = AssetsKey.formCreateProduct.currentState
                                ?.validate() ??
                            false;
                        if (isValid) {
                          context.read<CreateProductBloc>().add(
                              SaveProductEvent(
                                  model: CreateProductModel(
                                      name: productNameController.text,
                                      price: productAmountroller.text
                                          .replaceAll(".", ""),
                                      categoryId: (context
                                                  .read<CreateProductBloc>()
                                                  .state
                                                  .categoryEntity[context
                                                      .read<CreateProductBloc>()
                                                      .state
                                                      .indexCategory]
                                                  .id ??
                                              0)
                                          .toString(),
                                      stock: productStockController.text,
                                      created: productDateController.text)));
                        }
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocListener<CreateProductBloc, CreateProductState>(
                  listener: (context, state) async {
                    if (state is CreateCategorySuccess) {
                      Message.showSuccessToast(
                          msg: "Berhasil membuat kategori");
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == RoutesPage.createProduct);
                      context
                          .read<CreateProductBloc>()
                          .add(const GetCategoryEvent(selectLast: true));
                    } else if (state is CreateCategoryFailed) {
                      Message.showErrorToast(msg: "Gagal membuat kategori");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (state is GetCategorySuccess) {
                      if (state.indexCategory >= 0) {
                        productCategoryController.value = TextEditingValue(
                            text: state
                                    .categoryEntity[state.indexCategory].name ??
                                "");
                      }
                    } else if (state is CreateProductSuccess) {
                      Message.showSuccessToast(msg: "Berhasil membuat produk");
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == RoutesPage.listProduct);
                    } else if (state is CreateProductFailed) {
                      Message.showErrorToast(
                          msg: "Gagal membuat produk ${state.msgError}");
                    }
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
