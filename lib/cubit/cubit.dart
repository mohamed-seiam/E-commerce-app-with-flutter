// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/home_model.dart';
import 'package:test/modules/cateogries/cateogries_screen.dart';
import 'package:test/modules/favourite/favourites_screen.dart';
import 'package:test/modules/products_screen/products_screen.dart';
import 'package:test/modules/settings/settings_screen.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/endpoint.dart';
import 'package:test/shared/network/remote/diohelper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex  = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),

  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

    HomeModel? homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home,token: token ).then((value)
    {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.data!.banners[0].image);
      print(homeModel!.status);
      print(homeModel!.data!.products[0].image);

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}