abstract class ShoploginState {}

class ShoploginInitialState extends ShoploginState {}

class ShoploginLoadingState extends ShoploginState {}

class ShoploginSuccessState extends ShoploginState {}

class ShoploginErrorState extends ShoploginState 
{
  final String error;
  
  ShoploginErrorState(this.error);
}

class ShopChangePasswordVisibalityState extends ShoploginState 
{
  
}

