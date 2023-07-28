import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/pages/on_boarding_page.dart';
import 'package:punyatoko/presentation/pages/register_page.dart';

import 'presentation/bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoaderButtonCubit(),
              ),
              BlocProvider(
                create: (context) => RegisterBloc(),
              ),
            ],
            child: MaterialApp(
              title: 'Punya Toko',
              theme: ThemeData(
                  useMaterial3: true, colorSchemeSeed: AssetsColor.green),
              home: const OnBoardingPage(),
              initialRoute: RoutesPage.onBoardingPage,
              routes: {
                RoutesPage.onBoardingPage: (context) => const OnBoardingPage(),
                RoutesPage.registerPage: (context) => const RegisterPage()
              },
            ),
          );
        });
  }
}
