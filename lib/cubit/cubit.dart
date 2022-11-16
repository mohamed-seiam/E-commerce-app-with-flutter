// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/Addorder_model.dart';
import 'package:test/models/Getorder_model.dart';
import 'package:test/models/categories_models.dart';
import 'package:test/models/change_cart_model.dart';
import 'package:test/models/get_cart_model.dart';
import 'package:test/models/get_favourites_model.dart';
import 'package:test/models/home_model.dart';
import 'package:test/models/login_model.dart';
import 'package:test/modules/cart/cart_screen.dart';
import 'package:test/modules/cateogries/cateogries_screen.dart';
import 'package:test/modules/favourite/favourites_screen.dart';
import 'package:test/modules/products_screen/products_screen.dart';
import 'package:test/modules/settings/settings_screen.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/endpoint.dart';
import 'package:test/shared/network/remote/diohelper.dart';

import '../models/change_favourites_model.dart';

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
    CartScreen(),
    SettingsScreen(),

  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

    HomeModel? homeModel;

  Map<int ,bool> favorites = {};
  Map<int ,bool> carts = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home,token: token ).then((value)
    {
      homeModel = HomeModel.fromjson(value.data);

     homeModel!.data!.products.forEach((element)
     {
       favorites.addAll({
         element.id : element.inFavorites!
       });
       carts.addAll({
         element.id : element.inCart!
       });

     });

      // print(favorites.toString());
      // print(carts.toString());
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);
      // print(homeModel!.data!.products[0].image);

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      // print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel ? categoriesModel;

  FavoritesModel ? favoritesModel;

  CartModel ? cartModel;


  void getCategoriesData()
  {
    // emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: GET_CATEGEORIES,token: token ).then((value)
    {
      categoriesModel = CategoriesModel.fromjson(value.data);
      // print(categoriesModel!.data!.currentpage);

      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel ? changeFavoritesModel;
  void ChangeFavorites(int productId)
  {
    favorites[productId]  = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
      DioHelper.postData(
          url: Favorites,
          data:
          {
            'product_id':productId,
          },
          token: token,
      )
          .then((value) => {

        changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data),

         // print(value.data),

        if(!changeFavoritesModel!.status!)
        {
          favorites[productId]  = !favorites[productId]!,

      }else
      {
        getFavoritesData()
      },

            emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!))
      })
          .catchError((error){
              favorites[productId]  = !favorites[productId]!;
            emit(ShopErrorChangeFavoritesState());
      });
  }

  void getFavoritesData()
  {
     emit(ShopLoadingGetFavState());
    DioHelper.getData(url: Favorites,token: token ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(categoriesModel!.data!.currentpage);

      emit(ShopSuccessGetFavState());
    }).catchError((error)
    {
      emit(ShopErrorGetFavState());
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCarts (dynamic productId)
  {
    carts[productId]  = !carts[productId]!;
    emit(ShopChangeCartsState());
    DioHelper.postData(
      url: CARTS,
      data:
      {
        'product_id':productId,
      },
      token: token,
    )
        .then((value) {

      changeCartModel = ChangeCartModel.fromjson(value.data);

      // print(value.data),

      if(!changeCartModel!.status!)
        {
          carts[productId]  = !carts[productId]!;

        }else
        {
          getCartsData();
        }

      emit(ShopSuccessChangeCartsState(changeCartModel!));
    })
        .catchError((error){
      carts[productId]  = !carts[productId]!;
      emit(ShopErrorChangeCartsState());
    });
  }

  void getCartsData()
  {
        emit(ShopLoadingGetCartState());
        DioHelper.getData(url:CARTS,token: token).then((value)
        {
          cartModel = CartModel.fromJson(value.data);
              // print(value.data);
          emit(ShopSuccessGetCartState());
        }).catchError((error)
        {
          emit(ShopErrorGetCartState());
        });
  }

  ShopLoginModel ? userModel;

  void getUserData()
  {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: Profile,token: token ).then((value)
    {
      userModel  = ShopLoginModel.fromJson(value.data);
       // print(userModel!.data!.name);

      emit(ShopSuccessGetUserDataState(userModel!));
    })
        .catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    })
    ;
  }

  void UpdateUserData({
  required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATEUSER,token: token,
        data: {
            'name':name,
          'email':email,
          'phone':phone,
        } ).then((value)
    {
      userModel  = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error)
    {
      emit(ShopErrorUpdateUserDataState());
    });
  }
      AddOrderModel? addOrderModel;
  void UpdateOrders()
  {
    emit(ShopLoadingGetOrderState());
    DioHelper.postData(
        url: ORDERS,
        data: {
          'address_id': 35,
          'payment_method':'1',
            'use_points': false,
        },
      token: token,
    ).
    then((value)
    {
        addOrderModel = AddOrderModel.fromJson(value.data);
        print(value.data.toString());
        emit(ShopSuccessAddOrderState(addOrderModel!));
    }).
    catchError((error)
    {
      print(error.toString());
      emit(ShopErrorAddOrderState());
    });
  }

    GetOrderModel? getOrderModel;
    void GetOrders()
      {
        emit(ShopLoadingGetOrderState());
        DioHelper.getData(
            url: ORDERS,
            token: token
        )
            .then((value)
        {
            getOrderModel= GetOrderModel.fromJson(value.data);
            print(value.data);
            print('marina');
            emit(ShopSuccessGetOrderState());
        }).
        catchError((error)
        {
          print(error.toString());
            emit(ShopErrorGetOrderState());
        });
      }

      double ? total=0;
    void PlusCounter(ProductModel product)
    {
       product.quantity += 1;
       emit(ShopChangeCounterState());
    }
}