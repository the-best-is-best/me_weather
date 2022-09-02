import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/app/resources/routes_manager.dart';
import 'package:mit_x/mit_x.dart';
import '../presentation/error_view.dart';
import 'di.dart';
import 'localization/l10n/lang_controller.dart';
import 'resources/themes/light_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(480, 960),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return BlocProvider(
            create: (_) =>
                AppCubit(di(), di(), di(), di(), di())..loadDataCites(),
            child: MitXMaterialApp(
              debugShowCheckedModeBanner: false,
              fallbackLocale: const Locale('en'),
              locale: MitX.deviceLocale,
              initialRoute: '/',
              translations: LangController(),
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'EG'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: RoutesManager.getRoutes,
              onUnknownRoute: (settings) {
                return MaterialPageRoute(
                    builder: (context) => const ErrorView());
              },
              title: 'Flutter Demo',
              theme: LightTheme.getTheme,
            ),
          );
        });
  }
}
