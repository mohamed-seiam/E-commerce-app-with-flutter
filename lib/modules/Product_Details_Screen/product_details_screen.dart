// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/get_cart_model.dart';
import 'package:test/models/home_model.dart';
import 'package:test/shared/style/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductsModel productsModel;

  ProductDetailsScreen(this.index, {required this.productsModel});

  int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          //   if (ShopCubit.get(context).ChangeFavorites(productsModel.id)!=null)
          //   {
          //     ShopCubit.get(context).getFavoritesData();
        },
        builder: (context, state) {
          // ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       ShopCubit.get(context).ChangeFavorites(productsModel.id);
                //     },
                //     icon: CircleAvatar(
                //       radius: 15.0,
                //       backgroundColor:
                //           ShopCubit.get(context).favorites[productsModel.id!]!
                //               ? defaultColor
                //               : Colors.grey,
                //       child: Icon(
                //         Icons.favorite_border,
                //         size: 14.0,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ],
                title: Text(productsModel.name!),
              ),
              body: productsModel != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(children: [
                                  Image(
                                    image:
                                        NetworkImage('${productsModel.image}'),
                                    width: double.infinity,
                                    height: 200,
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                    //fit: BoxFit.cover,
                                  ),
                                  productsModel.discount > 0
                                      ? Container(
                                          color:
                                              Colors.redAccent.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                            ),
                                            child: Text(
                                              'DISCOUNT',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ]),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  '${productsModel.name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${productsModel.price.toString()} LE',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        productsModel.discount > 0
                                            ? Text(
                                                '${productsModel.oldPrice.toString()} LE',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('${productsModel.description}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
