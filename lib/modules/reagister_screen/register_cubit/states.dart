import 'package:test/models/login_model.dart';

abstract class ShopregisterState {}

class ShopregisterInitialState extends ShopregisterState {}

class ShopregisterLoadingState extends ShopregisterState {}

class ShopregisterSuccessState extends ShopregisterState {
  final ShopLoginModel loginModel;

  ShopregisterSuccessState(this.loginModel);
  
}

class ShopregisterErrorState extends ShopregisterState {
  final String error;

  ShopregisterErrorState(this.error);
}

class ShopRegisterPasswordVisibalityState extends ShopregisterState {}
