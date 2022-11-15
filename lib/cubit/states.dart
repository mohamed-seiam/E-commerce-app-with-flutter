import 'package:test/models/Addorder_model.dart';
import 'package:test/models/change_cart_model.dart';
import 'package:test/models/change_favourites_model.dart';
import 'package:test/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState  extends ShopStates{}

class ShopSuccessHomeDataState  extends ShopStates{}

class ShopErrorHomeDataState  extends ShopStates{}

class ShopSuccessCategoriesState  extends ShopStates{}

class ShopErrorCategoriesState  extends ShopStates{}

class ShopSuccessChangeFavoritesState  extends ShopStates{
  final ChangeFavoritesModel model;


  ShopSuccessChangeFavoritesState(this.model);}

class ShopChangeFavoritesState  extends ShopStates{}

class ShopErrorChangeFavoritesState  extends ShopStates{}

class ShopLoadingGetFavState  extends ShopStates{}

class ShopSuccessGetFavState  extends ShopStates{}

class ShopErrorGetFavState  extends ShopStates{}

class ShopLoadingGetUserDataState  extends ShopStates{}

class ShopSuccessGetUserDataState  extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState  extends ShopStates{}

class ShopLoadingUpdateUserDataState  extends ShopStates{}

class ShopSuccessUpdateUserDataState  extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState  extends ShopStates{}

class ShopSuccessChangeCartsState  extends ShopStates{
  final ChangeCartModel model;


  ShopSuccessChangeCartsState(this.model);}

class ShopChangeCartsState  extends ShopStates{}

class ShopErrorChangeCartsState  extends ShopStates{}

class ShopLoadingGetCartState  extends ShopStates{}

class ShopSuccessGetCartState  extends ShopStates{}

class ShopErrorGetCartState  extends ShopStates{}

class ShopLoadingGetOrderState  extends ShopStates{}

class ShopSuccessGetOrderState  extends ShopStates{}

class ShopErrorGetOrderState  extends ShopStates{}

class ShopLoadingAddOrderState  extends ShopStates{}

class ShopSuccessAddOrderState  extends ShopStates{
  final AddOrderModel model;
  ShopSuccessAddOrderState(this.model);
}

class ShopErrorAddOrderState  extends ShopStates{}