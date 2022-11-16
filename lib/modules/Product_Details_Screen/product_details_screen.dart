import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/home_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(ProductsModel model, index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Text('detilsScreen'),
        ),
      ),
    );
  }
}
