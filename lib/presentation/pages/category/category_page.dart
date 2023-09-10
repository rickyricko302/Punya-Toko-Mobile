import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/data/repositories/category_repository.dart';
import 'package:punyatoko/domain/usecases/create_category_usecase.dart';
import 'package:punyatoko/domain/usecases/delete_category_usecase.dart';
import 'package:punyatoko/domain/usecases/get_category_usecase.dart';
import 'package:punyatoko/domain/usecases/update_category_usecase.dart';
import 'package:punyatoko/presentation/bloc/category/category_bloc.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/buttons/white_button.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/bottomsheet_helper.dart';
import 'package:punyatoko/util/message.dart';

import '../../../data/constants/assets_color.dart';
import '../../../domain/entities/category_entity.dart';
import '../../widgets/separators/separator_dash.dart';

class CategoryListingPage extends StatefulWidget {
  const CategoryListingPage({Key? key}) : super(key: key);

  @override
  State<CategoryListingPage> createState() => _CategoryListingPageState();
}

class _CategoryListingPageState extends State<CategoryListingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(
          getCategoryUseCase: GetCategoryUseCase(
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          deleteCategoryUseCase: DeleteCategoryUseCase(
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          createCategoryUseCase: CreateCategoryUseCase(
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          updateCategoryUseCase: UpdateCategoryUseCase(
              categoryRepositoryImp:
                  RepositoryProvider.of<CategoryRepositoryImp>(context)),
          loaderButtonCubit: context.read<LoaderButtonCubit>())
        ..add(CategoryEventGetData()),
      child: const CategoryBody(),
    );
  }
}

class CategoryBody extends StatelessWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryBloc bloc = context.read<CategoryBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AssetsColor.youngGreen.withOpacity(20 / 100),
        title: PoppinsText(text: "Kelola Kategori", fontSize: 20.sp),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is ListingCategoryLoading) {
                  return const CategoryLoading();
                } else if (state is ListingCategorySuccess) {
                  if (state.model.isEmpty) {
                    return const CategoryEmpty();
                  } else {
                    return CategoryList(
                      model: state.model,
                      bloc: bloc,
                    );
                  }
                }
                return Container();
              },
            ),
          ),
          BlocListener<CategoryBloc, CategoryState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is DeleteCategorySuccess) {
                Message.showSuccessToast(msg: "Berhasil menghapus");
                bloc.add(CategoryEventGetData());
              } else if (state is DeleteCategoryFailed) {
                Message.showErrorToast(
                    msg: "Gagal menghapus ${state.msgError}");

                bloc.add(CategoryEventGetData());
              } else if (state is CreateCategorySuccess) {
                Message.showSuccessToast(msg: "Berhasil menambah kategori");
                Navigator.popUntil(context,
                    (route) => route.settings.name == RoutesPage.listCategory);
                bloc.add(CategoryEventGetData());
              } else if (state is CreateCategoryFailed) {
                Message.showErrorToast(msg: "Gagal menambah kategori");
              } else if (state is UpdateCategorySuccess) {
                Message.showSuccessToast(msg: "Berhasil mengubah kategori");
                Navigator.popUntil(context,
                    (route) => route.settings.name == RoutesPage.listCategory);
                bloc.add(CategoryEventGetData());
              } else if (state is UpdateCategoryFailed) {
                Message.showErrorToast(msg: "Gagal mengubah kategori");
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BottomSheetHelper.showCreateCategory(
              context: context,
              onClick: (name) {
                bloc.add(CategoryEventCreate(categoryName: name));
              },
              textController: TextEditingController());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CategoryEmpty extends StatelessWidget {
  const CategoryEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_noproduct.svg',
            height: 170.h,
          ),
          const SizedBox(
            height: 20,
          ),
          PoppinsText(
            text:
                "Anda belum mempunyai kategori, silahkan tekan tombol hijau dibawah untuk menambahkan.",
            fontSize: 15.sp,
            color: AssetsColor.grey,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key, required this.model, required this.bloc})
      : super(key: key);
  final List<CategoryEntity> model;
  final CategoryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(CategoryEventGetData());
      },
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(bottom: 70),
        itemCount: model.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 20, right: 8),
            title: PoppinsText(
              text: model[index].name ?? "-",
              fontSize: 17.sp,
              maxLines: 1,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        BottomSheetHelper.showUpdateCategory(
                            context: context,
                            onClick: (name) => bloc.add(CategoryEventUpdate(
                                  idCategory: model[index].id ?? 0,
                                  categroyName: name,
                                )),
                            category: model[index].name ?? "",
                            textController: TextEditingController()
                              ..value = TextEditingValue(
                                  text: model[index].name ?? "",
                                  selection: TextSelection.collapsed(
                                      offset:
                                          (model[index].name ?? "").length)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.edit,
                          color: AssetsColor.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: PoppinsText(
                                    text: "Konfirmasi Hapus!",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: PoppinsText(
                                  text:
                                      "Data akan dihapus secara permanen dari database, data yang sudah dihapus tidak dapat dikembalikan lagi. Apakah Anda yakin ingin menghapusnya?",
                                  fontSize: 15.sp,
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GreenButton(
                                            text: "Batalkan",
                                            callback: () {
                                              Navigator.pop(context);
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: WhiteButton(
                                            text: "Hapus",
                                            callback: () {
                                              Navigator.pop(context);
                                              bloc.add(CategoryEventDelete(
                                                  idCategory:
                                                      model[index].id ?? 0));
                                            }),
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.close,
                          color: AssetsColor.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MySeparator(
            color: AssetsColor.grey,
          );
        },
      ),
    );
  }
}
