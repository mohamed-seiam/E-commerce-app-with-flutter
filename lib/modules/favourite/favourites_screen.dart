// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/get_favourites_model.dart';
import 'package:test/shared/components/component.dart';
import 'package:test/shared/style/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
          builder: (context)=>ConditionalBuilder(
            condition: state is! ShopLoadingGetFavState,
            builder: (context) => ListView.separated(
              itemBuilder: (context,index) => BuildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context) ,
              separatorBuilder: (context,index) => mydivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          fallback: (context)=>Center(
            child: Column(
              children: [
                Text(
                  "you Don\'t have add any Products To your Cart yet!",
                ),
                SizedBox(height: 30,),
                Icon(
                  Icons.heart_broken,
                  size: 40.0,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    ) ;
  }

}


