// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/categories_models.dart';
import 'package:test/shared/components/component.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ListView.separated(
        itemBuilder: (context,index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]) ,
        separatorBuilder: (context,index) => mydivider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    ) ;
  }
}

Widget buildCatItem(DataModel model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image:NetworkImage(model.image.toString()),
        width:100.0 ,
        height:100.0,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width: 20.0,
      ),
      Text(
        model.name!,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      ),
    ],
  ),
);
