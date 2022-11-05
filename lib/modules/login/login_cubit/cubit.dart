// ignore_for_file: unnecessary_import, avoid_print, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/modules/login/login_cubit/states.dart';
import 'package:test/shared/network/endpoint.dart';
import 'package:test/shared/network/remote/diohelper.dart';

class ShopLoginCubit extends Cubit<ShoploginState> {
  ShopLoginCubit() : super(ShoploginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userloin({
    required String email,
    required String password,
  }) {
    emit(ShoploginLoadingState());
    DioHelper.postData(
      url: login,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      emit(ShoploginSuccessState());
    }).catchError((error) {
      emit(ShoploginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void ChangePassowrdVisibality() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined: Icons.visibility_off_outlined;
        
    emit(ShopChangePasswordVisibalityState());
  }
}
