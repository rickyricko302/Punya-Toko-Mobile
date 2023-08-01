import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/assets_key.dart';
import 'package:punyatoko/data/models/post/register_model.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/decorations/circle_step_indicator.dart';
import 'package:punyatoko/presentation/widgets/decorations/step_indicator.dart';
import 'package:punyatoko/presentation/widgets/icons/icon_with_press.dart';
import 'package:punyatoko/presentation/widgets/radios/radio_with_text.dart';
import 'package:punyatoko/presentation/widgets/textforms/password_form.dart';
import 'package:punyatoko/presentation/widgets/textforms/text_form.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/message.dart';

import '../bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameFormController = TextEditingController();
  final TextEditingController _passwordFormController = TextEditingController();
  final TextEditingController _passwordConfirmationFormController =
      TextEditingController();
  final TextEditingController _emailFormController = TextEditingController();
  final TextEditingController _ageFormController = TextEditingController();
  late RegisterBloc _registerBloc;
  late LoaderButtonCubit _loaderButtonCubit;

  @override
  Widget build(BuildContext context) {
    _registerBloc = context.read<RegisterBloc>();
    _loaderButtonCubit = context.read<LoaderButtonCubit>();

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
                IconWithPress(
                    callback: () {
                      Navigator.pop(context);
                    },
                    icon: "ic_back.svg"),
                const SizedBox(
                  height: 40,
                ),
                PoppinsText(
                  text: "Buat Akun\nBaru",
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    StepIndicator(),
                    SizedBox(
                      width: 5,
                    ),
                    CircleStepIndicator()
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                PoppinsText(
                  text: "Nama Lengkap",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                TextForm(
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    formController: _fullNameFormController,
                    hint: "Masukan nama Anda"),
                const SizedBox(
                  height: 30,
                ),
                PoppinsText(
                  text: "Alamat Email",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                TextForm(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    formController: _emailFormController,
                    hint: "Masukan alamat email Anda"),
                const SizedBox(
                  height: 30,
                ),
                PoppinsText(
                  text: "Password",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                PasswordForm(
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    formController: _passwordFormController,
                    hint: "Masukan password Anda"),
                const SizedBox(
                  height: 30,
                ),
                PoppinsText(
                  text: "Konfirmasi Password",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                PasswordForm(
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    formController: _passwordConfirmationFormController,
                    hint: "Masukan ulang password Anda"),
                const SizedBox(
                  height: 30,
                ),
                PoppinsText(
                  text: "Umur",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                TextForm(
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                    formController: _ageFormController,
                    hint: "Masukan umur Anda"),
                const SizedBox(
                  height: 30,
                ),
                PoppinsText(
                  text: "Jenis Kelamin",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AssetsColor.grey,
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        RadioWithText(
                            text: "Laki-laki",
                            callback: () => _registerBloc.add(
                                const RegisterChangeGenderEvent(
                                    gender: "Laki-laki")),
                            radioTap: (value) => _registerBloc.add(
                                RegisterChangeGenderEvent(gender: value ?? "")),
                            state: state.gender),
                        const SizedBox(
                          width: 6,
                        ),
                        RadioWithText(
                            text: "Perempuan",
                            callback: () => _registerBloc.add(
                                const RegisterChangeGenderEvent(
                                    gender: "Perempuan")),
                            radioTap: (value) => _registerBloc.add(
                                RegisterChangeGenderEvent(gender: value ?? "")),
                            state: state.gender)
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GreenButton(
                      text: "Daftarkan Akun",
                      callback: () async {
                        bool isValidate =
                            AssetsKey.formKeyRegister.currentState!.validate();
                        if (isValidate) {
                          if (_registerBloc.state.gender == '') {
                            Message.showErrorToast(
                                msg: "Anda belum memilih jenis kelamin");
                          } else {
                            _registerBloc.add(RegisterAccountEvent(
                                loaderButtonCubit: _loaderButtonCubit,
                                model: RegisterModel(
                                    name: _fullNameFormController.text,
                                    email: _emailFormController.text,
                                    password: _passwordFormController.text,
                                    passwordConfirmation:
                                        _passwordConfirmationFormController
                                            .text,
                                    age:
                                        int.tryParse(_ageFormController.text) ??
                                            0,
                                    gender: _registerBloc.state.gender)));
                          }
                        }
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterFailed) {
                      Message.showErrorToast(msg: state.msgError);
                    } else if (state is RegisterSuccess) {
                      Message.showSuccessToast(
                          msg: "Akun Anda Berhasil didaftarkan");
                    }
                  },
                  child: const SizedBox(),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
