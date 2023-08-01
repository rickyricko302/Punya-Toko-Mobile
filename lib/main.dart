import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/assets_key.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/data/repositories/register_repository.dart';
import 'package:punyatoko/domain/usecases/register_usecase.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/pages/on_boarding_page.dart';
import 'package:punyatoko/presentation/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'presentation/bloc/register/register_bloc.dart';

void main() {
  FlavorConfig(variables: {
    'base_url': "http://192.168.142.222:8000/api",
  });
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
                create: (context) => RegisterBloc(
                    registerUseCase: RegisterUseCase(
                        registerRepositoryImp:
                            RegisterRepositoryImp(client: http.Client()))),
              ),
            ],
            child: MaterialApp(
              title: 'Punya Toko',
              navigatorKey: AssetsKey.navigatorKey,
              builder: FToastBuilder(),
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
