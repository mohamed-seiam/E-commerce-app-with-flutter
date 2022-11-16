// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/home_model.dart';

class ProductDetailsScreen extends StatelessWidget {
   ProductDetailsScreen(this.index);
  int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ShopCubit.get(context).homeModel != null
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
                            image: NetworkImage(
                                '${cubit.homeModel!.data!.products[index].image}'),
                            width: double.infinity,
                            height: 200,
                            //fit: BoxFit.cover,
                          ),
                          cubit.homeModel!.data!.products[index]
                              .discount >
                              0
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
                          '${cubit.homeModel!.data!.products[index].name}',
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
                                  '${cubit.homeModel!.data!.products[index].price.toString()} LE',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                cubit.homeModel!.data!.products[index]
                                    .discount >
                                    0
                                    ? Text(
                                  '${cubit.homeModel!.data!.products[index].oldPrice.toString()} LE',
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
                        Text(
                            '${cubit.homeModel!.data!.products[index].description}')
                      ],
                    ),
                  ),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator())
          );
        },

      ),
    );
  }
}
