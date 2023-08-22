import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/assets_key.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/data/repositories/auth_repository.dart';
import 'package:punyatoko/domain/usecases/register_usecase.dart';
import 'package:punyatoko/presentation/bloc/loader/loader_button_cubit.dart';
import 'package:punyatoko/presentation/bloc/login/login_bloc.dart';
import 'package:punyatoko/presentation/pages/create_store_page.dart';
import 'package:punyatoko/presentation/pages/home_page.dart';
import 'package:punyatoko/presentation/pages/login_page.dart';
import 'package:punyatoko/presentation/pages/on_boarding_page.dart';
import 'package:punyatoko/presentation/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'domain/usecases/login_usecase.dart';
import 'presentation/bloc/register/register_bloc.dart';

void main() async {
  FlavorConfig(variables: {
    'base_url': "http://192.168.109.222:8000/api",
  });
  await GetStorage.init();
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
                            AuthRepositoryImp(client: http.Client()))),
              ),
              BlocProvider(
                  create: (context) => LoginBloc(
                        loaderButtonCubit: context.read<LoaderButtonCubit>(),
                        loginUseCase: LoginUseCase(
                            authRepositoryImp:
                                AuthRepositoryImp(client: http.Client())),
                      ))
            ],
            child: MaterialApp(
              title: 'Punya Toko',
              navigatorKey: AssetsKey.navigatorKey,
              builder: FToastBuilder(),
              theme: ThemeData(
                  useMaterial3: true, colorSchemeSeed: AssetsColor.green),
              initialRoute: RoutesPage.onBoardingPage,
              routes: {
                RoutesPage.onBoardingPage: (context) => const OnBoardingPage(),
                RoutesPage.registerPage: (context) => const RegisterPage(),
                RoutesPage.createStorePage: (context) =>
                    const CreateStorePages(),
                RoutesPage.loginPage: (context) => const LoginPage(),
                RoutesPage.homePage: (context) => const HomePage()
              },
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [Locale('in'), Locale('en')],
            ),
          );
        });
  }
}
