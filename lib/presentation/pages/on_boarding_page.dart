import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/datasources/local_storage.dart';
import 'package:punyatoko/presentation/widgets/buttons/green_button.dart';
import 'package:punyatoko/presentation/widgets/buttons/white_button.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/message.dart';

import '../../data/constants/routes_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool isHasToken = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (LocalStorage.getToken() != null) {
        Message.showSuccessToast(msg: "Selamat datang kembali");
        Navigator.pushReplacementNamed(context, RoutesPage.homePage);
      } else {
        setState(() {
          isHasToken = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !isHasToken
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                          child: PoppinsText(
                        text: "Selamat Datang",
                        color: AssetsColor.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      )),
                      const SizedBox(
                        height: 8,
                      ),
                      PoppinsText(
                        text: "Silahkan masuk atau buat akun baru",
                        fontSize: 12.sp,
                        color: AssetsColor.lightGrey,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Image.asset(
                        "assets/images/shop.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      GreenButton(
                          text: "Pergi Masuk",
                          callback: () async {
                            Navigator.pushNamed(context, RoutesPage.loginPage);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      WhiteButton(
                          text: "Belum punya akun? Daftar",
                          callback: () {
                            Navigator.pushNamed(
                                context, RoutesPage.registerPage);
                          })
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
