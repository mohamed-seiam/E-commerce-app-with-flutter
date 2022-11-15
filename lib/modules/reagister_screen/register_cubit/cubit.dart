// ignore_for_file: unnecessary_import, avoid_print, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/login_model.dart';
import 'package:test/modules/login/login_cubit/states.dart';
import 'package:test/modules/reagister_screen/register_cubit/states.dart';
import 'package:test/shared/network/endpoint.dart';
import 'package:test/shared/network/remote/diohelper.dart';

class ShopRegisterCubit extends Cubit<ShopregisterState> {
  ShopRegisterCubit() : super(ShopregisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userregister({
    required String ?email,
    required String ?password,
    required String ?name,
    required String ?phone,
  }) {
    emit(ShopregisterLoadingState());
    DioHelper.postData(
      url: Register,
      data: {
        'name':name,
        "email": email,
        "password": password,
        'phone':phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopregisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(ShopregisterErrorState(error.toString()));
    });
  }

  // IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePassowrdVisibality() {
    isPassword = !isPassword;
    // suffix =
    //     isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterPasswordVisibalityState());
  }
}
