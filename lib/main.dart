// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/modules/layoutScreen/layout_screen.dart';
import 'package:parent_app/modules/login/login.dart';
import 'package:parent_app/modules/on_boarding/onBoardingScreen.dart';
import 'package:parent_app/network/local/cache_Helper.dart';
import 'package:parent_app/network/remote/dio_helper.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/blocObserver/blocObserver.dart';
import 'package:parent_app/shared/const.dart';
import 'package:parent_app/shared/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  Widget startWidget;
  bool isDark = false;
  token = CacheHelper.getData(key: 'token');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  if (CacheHelper.getData(key: 'isDark') != null) {
    isDark = CacheHelper.getData(key: 'isDark');
  } else {
    isDark = isDark;
  }
  if (onboarding != null) {
    if (token != null) {
      startWidget = const LayoutScreen();
    } else {
      startWidget = const LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({super.key, required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getStudentAbsenceData()
        ..getStudentDegreesData()
        ..getHomeData()
        ..getStudentTableData(
            day: DateFormat('EEEE').format(DateTime.now()) == 'Sunday'
                ? 1
                : DateFormat('EEEE').format(DateTime.now()) == 'Monday'
                    ? 2
                    : DateFormat('EEEE').format(DateTime.now()) == 'Tuesday'
                        ? 3
                        : DateFormat('EEEE').format(DateTime.now()) ==
                                'Wednesday'
                            ? 4
                            : 5),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', ''), // arabic, no country code
          ],
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          title: 'home',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          // home: TrainingScreen(),
          home: startWidget,
        ),
      ),
    );
  }
}
