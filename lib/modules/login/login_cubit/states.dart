import 'package:test/models/login_model.dart';

abstract class ShoploginState {}

class ShoploginInitialState extends ShoploginState {}

class ShoploginLoadingState extends ShoploginState {}

class ShoploginSuccessState extends ShoploginState {
  final ShopLoginModel loginModel;

  ShoploginSuccessState(this.loginModel);
  
}

class ShoploginErrorState extends ShoploginState {
  final String error;

  ShoploginErrorState(this.error);
}

class ShopChangePasswordVisibalityState extends ShoploginState {}
