import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/models/post/login_model.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/textforms/password_form.dart';
import 'package:punyatoko/util/message.dart';

import '../../data/constants/assets_color.dart';
import '../../data/constants/assets_key.dart';
import '../bloc/login/login_bloc.dart';
import '../widgets/icons/icon_with_press.dart';
import '../widgets/textforms/text_form.dart';
import '../widgets/texts/poppins_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetsColor.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Form(
                      key: AssetsKey.formKeyLogin,
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
                              text: "Masuk untuk\nMelanjutkan",
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.black,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            PoppinsText(
                              text: "Alamat Email",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AssetsColor.grey,
                            ),
                            TextForm(
                                formController: _emailController,
                                hint: "Masukan alamat email Anda",
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next),
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
                                formController: _passwordController,
                                hint: "Masukan password Anda",
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: GreenButton(
                                  text: "Masuk",
                                  callback: () {
                                    FocusScope.of(context).unfocus();
                                    bool? isValid = AssetsKey
                                        .formKeyLogin.currentState
                                        ?.validate();
                                    if (isValid ?? false) {
                                      context.read<LoginBloc>().add(LoginEvent(
                                          model: LoginModel(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)));
                                    }
                                  }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            BlocListener<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  Message.showSuccessToast(
                                      msg: "Anda berhasil masuk");
                                } else if (state is LoginFailed) {
                                  Message.showErrorToast(msg: state.msgError);
                                }
                              },
                              child: const SizedBox(),
                            )
                          ]))))),
    );
  }
}
