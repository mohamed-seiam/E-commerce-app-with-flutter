// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/layout/shop_layout.dart';
import 'package:test/modules/login/shop_login.dart';
import 'package:test/shared/blokobserved.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/local/cachhelper.dart';
import 'package:test/shared/network/remote/diohelper.dart';
import 'package:test/shared/style/colors.dart';

import 'cubit/cubit.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await cacheHelper.init();
  // ignore: unused_local_variable
  Widget widget;

  bool ?onBoarding = cacheHelper.getData(key: "onBoarding");
  String ? token = cacheHelper.getData(key: "token");
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()..getCartsData()..GetOrders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          // ignore: prefer_const_constructors
          appBarTheme: AppBarTheme(
            titleSpacing: 20.0,
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0.0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )
          ),
          primarySwatch: defaultColor,
        ),
        home: startWidget,
      ),
    );
  }
}
