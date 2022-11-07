// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/home_model.dart';
import 'package:test/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
   ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel!=null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel!),
              fallback: (context) => Center(child: CircularProgressIndicator()),
          );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model.data?.banners.map((e) =>
            Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal
          ),
        ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Categories',
                   style: TextStyle(
                     fontSize: 24.0,
                     fontWeight: FontWeight.w800,
                   ),
                  ),
              SizedBox(height: 15,),
          Container(
               height: 100,
               child: ListView.separated(
                 physics: BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, index) => buildCategoryItem(),
                   separatorBuilder:(context, index)=>SizedBox(
                     width: 10.0,
                   ),
                   itemCount: 10,
               ),
              ),
              SizedBox(height: 20,),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.57,
            children: List.generate(model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index])),
          ),
        ),
      ],
    ),
  );

    Widget buildGridProduct(ProductsModel model) =>  Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image.toString()),
                width: double.infinity,
                height: 200,
              ),
              if(model.discount != 0 )
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.4
                  ),
                ),
                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Text(
                      "${model.price.round()}",
                      style: TextStyle(
                          fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(model.discount != 0 )
                      Text(
                      "${model.oldPrice.round()}",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                        onPressed: (){},
                        icon:Icon(Icons.favorite_border,
                          size: 14.0,
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget buildCategoryItem () => Container(
      height: 100.0,
      width: 100.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children:
        [
          Image(
            image: NetworkImage('https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.8,),
            width: double.infinity,
            child: Text(
              "Electronics",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
}
