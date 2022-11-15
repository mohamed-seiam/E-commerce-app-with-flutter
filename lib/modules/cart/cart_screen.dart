// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/get_cart_model.dart';
import 'package:test/shared/components/component.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,states){},
        builder: (context,states)
        {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).cartModel!= null,
              builder: (context) => SingleChildScrollView(
                child: Column
                  (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    ListView.separated(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>CartItemBuilder(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!,context),
                        separatorBuilder:(context , index)=> mydivider(),
                        itemCount:ShopCubit.get(context).cartModel!.data!.cartItems!.length,
                    ),
                    mydivider(),
                    SizedBox(height: 20.0,),

                    ConditionalBuilder(
                      condition: ShopCubit.get(context).cartModel!.data!.cartItems!.isNotEmpty,
                      builder: (context)=> defultButton(function: (){},
                          text:('TotalPrice=${ShopCubit.get(context).cartModel!.data!.total} LE'),
                          height: 50,
                          radius: 30.0,
                          width: 300.0,
                          isUpperCase: true,
                          background: Colors.blue
                      ),
                      fallback: (context)=>Center(
                        child: Column(
                          children: [
                            Text(
                              "you Don\'t have add any Products To your Cart yet!",
                            ),
                            SizedBox(height: 30,),
                            Icon(
                                Icons.remove_shopping_cart_outlined,
                              size: 40.0,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),

                defultButton(function: (){
                  ShopCubit.get(context).UpdateOrders();
                  showToast(
                      text:ShopCubit.get(context).addOrderModel!.message!,
                      state:Toaststate.SUCCESS,
                  );
                },
                  text:('Check Now'),
                  height: 50,
                  radius: 30.0,
                  width: 300.0,
                  isUpperCase: true,
                  background: Colors.green,
                )
                  ]
                ),
              ),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

  Widget CartItemBuilder(Product model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image.toString()),
                    width: 120.0,
                    height: 120.0,

                  ),
                  if(model.discount!=0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 1.9,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [

                        Text(
                          '${model.price} LE',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),

                        ),
                        SizedBox(width: 3.0,),
                        if(model.discount!=0)
                          Text(
                            '${model.oldPrice} LE',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700],
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        Spacer(),
                        IconButton(
                            icon:CircleAvatar(
                              radius: 25.0,
                              backgroundColor: ShopCubit.get(context).carts[model.id]! ?Colors.redAccent :Colors.grey ,
                              // backgroundColor: Colors.greenAccent,
                              child: Icon(
                                Icons.add_shopping_cart,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              ShopCubit.get(context).changeCarts(model.id!);
                              // print(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.id;
                            }
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],

    ),

  );
}
