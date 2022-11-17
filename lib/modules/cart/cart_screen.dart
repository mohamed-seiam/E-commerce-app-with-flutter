// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/get_cart_model.dart';
import 'package:test/modules/Payment_Screen/payment_screen.dart';
import 'package:test/shared/components/component.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessAddOrderState) {
          ShopCubit.get(context).getCartsData();
          ShopCubit.get(context).getHomeData();
        }
      },
      builder: (context, states) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).cartModel != null,
          builder: (context) => ConditionalBuilder(
            condition:
                ShopCubit.get(context).cartModel!.data!.cartItems!.isNotEmpty,
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image:AssetImage('assets/img/addtocart.png'),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    "you Don\'t have add any Products To your Cart yet!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            ),
            builder: (context) => SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CartItemBuilder(
                          ShopCubit.get(context)
                              .cartModel!
                              .data!
                              .cartItems![index]
                              .product!,
                          context),
                      separatorBuilder: (context, index) => mydivider(),
                      itemCount: ShopCubit.get(context)
                          .cartModel!
                          .data!
                          .cartItems!
                          .length,
                    ),
                    mydivider(),
                    SizedBox(
                      height: 30.0,
                    ),
                    defultButton(
                        function: () {},
                        text:
                        ('TotalPrice = ${ShopCubit.get(context).cartModel!.data!.total} LE'),
                        height: 50,
                        radius: 30.0,
                        width: 300.0,
                        isUpperCase: true,
                        background: Colors.blue),
                    SizedBox(height: 20.0,),
                    defultButton(
                      function: () {
                        ShopCubit.get(context).UpdateOrders();
                        navigateTo(context, PaymentScreen());
                      },
                      text: ('Check Now'),
                      height: 50,
                      radius: 30.0,
                      width: 300.0,
                      isUpperCase: true,
                      background: Colors.green,
                    ),
                    SizedBox(height: 5.0,),
                  ]),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget CartItemBuilder(ProductModel model, context) => Padding(
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
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                      if (model.discount != 0)
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
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
                            Column(
                              children: [
                                Text(
                                  '${model.price} LE',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height:5.0 ,),
                                if (model.discount != 0)
                                  Text(
                                    '${model.oldPrice} LE',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[700],
                                        decoration: TextDecoration.lineThrough),
                                  ),
                              ],
                            ),
                            SizedBox(
                              width: 3.0,
                            ),

                             Spacer(),
                            IconButton(
                                icon: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor:
                                      ShopCubit.get(context).carts[model.id]!
                                          ? Colors.redAccent
                                          : Colors.grey,
                                  // backgroundColor: Colors.greenAccent,
                                  child: Icon(
                                    Icons.remove_shopping_cart,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  ShopCubit.get(context).changeCarts(model.id!);
                                  // print(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.id;
                                }),
                                    SizedBox(width: 3.0,),
                            IconButton(
                              onPressed:(){
                                ShopCubit.get(context).MinusCounter(model);
                              },
                              icon:Icon(Icons.remove),
                            ),
                                 SizedBox(width: 5.0,),
                                    Text(
                                      "${model.quantity}",
                                   ),

                            IconButton(
                                onPressed:(){
                                  ShopCubit.get(context).PlusCounter(model);
                                },
                                icon:Icon(Icons.add),
                            )
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
