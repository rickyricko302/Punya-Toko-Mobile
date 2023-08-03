import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/models/post/create_store_model.dart';
import 'package:punyatoko/data/repositories/store_repository.dart';
import 'package:punyatoko/domain/usecases/create_store_usecase.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/textforms/rupiah_form.dart';
import 'package:punyatoko/util/message.dart';

import '../../data/constants/assets_color.dart';
import '../../data/constants/assets_key.dart';
import '../bloc/createStore/create_store_bloc.dart';
import '../widgets/decorations/circle_step_indicator.dart';
import '../widgets/decorations/step_indicator.dart';
import '../widgets/textforms/text_form.dart';
import '../widgets/texts/poppins_text.dart';
import 'package:http/http.dart' as http;

class CreateStorePages extends StatelessWidget {
  const CreateStorePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateStoreBloc>(
      create: (context) => CreateStoreBloc(
          createStoreUseCase: CreateStoreUseCase(
              storeRepositoryImp: StoreRepositoryImp(client: http.Client()))),
      child: const CreateStoreBody(),
    );
  }
}

class CreateStoreBody extends StatefulWidget {
  const CreateStoreBody({Key? key}) : super(key: key);

  @override
  State<CreateStoreBody> createState() => _CreateStoreBodyState();
}

class _CreateStoreBodyState extends State<CreateStoreBody> {
  final TextEditingController _nameStoreController = TextEditingController();
  final TextEditingController _addressStoreController = TextEditingController();
  final TextEditingController _incomeStoreController = TextEditingController();
  late CreateStoreBloc _createStoreBloc;
  @override
  Widget build(BuildContext context) {
    _createStoreBloc = context.read<CreateStoreBloc>();
    return Scaffold(
      backgroundColor: AssetsColor.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Form(
                      key: AssetsKey.formKeyRegister,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            PoppinsText(
                              text: "Langkah Terakhir,\nBuat Toko Anda",
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                CircleStepIndicator(),
                                SizedBox(
                                  width: 5,
                                ),
                                StepIndicator(),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            PoppinsText(
                              text: "Nama Toko",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.grey,
                            ),
                            TextForm(
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                formController: _nameStoreController,
                                hint: "Masukan nama toko Anda"),
                            const SizedBox(
                              height: 30,
                            ),
                            PoppinsText(
                              text: "Alamat Toko",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.grey,
                            ),
                            TextForm(
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                formController: _addressStoreController,
                                hint: "Masukan alamat toko Anda"),
                            const SizedBox(
                              height: 30,
                            ),
                            PoppinsText(
                              text: "Saldo saat ini",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.grey,
                            ),
                            RupiahForm(
                                textInputAction: TextInputAction.done,
                                formController: _incomeStoreController,
                                hint: "Masukan saldo saat ini toko Anda"),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: GreenButton(
                                  text: "Daftarkan Toko",
                                  callback: () {
                                    _createStoreBloc.add(CreateStorePressEvent(
                                        loaderButtonCubit:
                                            context.read<LoaderButtonCubit>(),
                                        model: CreateStoreModel(
                                            address:
                                                _addressStoreController.text,
                                            expense: 0,
                                            name: _nameStoreController.text,
                                            income: int.tryParse(
                                                    _incomeStoreController
                                                        .text) ??
                                                0)));
                                  }),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            BlocListener<CreateStoreBloc, CreateStoreState>(
                              listener: (context, state) {
                                if (state is CreateStoreSuccess) {
                                  Message.showSuccessToast(
                                      msg: "Berhasil membuat toko");
                                } else if (state is CreateStoreFailed) {
                                  Message.showErrorToast(msg: state.msgError);
                                }
                              },
                              child: const SizedBox(),
                            )
                          ]))))),
    );
  }
}
