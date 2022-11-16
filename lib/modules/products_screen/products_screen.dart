// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';
import 'package:test/models/categories_models.dart';
import 'package:test/models/home_model.dart';
import 'package:test/modules/Product_Details_Screen/product_details_screen.dart';
import 'package:test/shared/components/component.dart';
import 'package:test/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
   ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if (state is ShopSuccessChangeFavoritesState)
        {
          if (!state.model.status!)
          {
            showToast(text: state.model.message!, state:Toaststate.ERROR);
          }
        }
      },
      builder: (context,state)
      {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
              fallback: (context) => Center(child: CircularProgressIndicator()),
          );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel CatModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model.data?.banners.map((e) =>
            Image(
              image: NetworkImage('${e.image}',),
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
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
                 itemBuilder: (context, index) => buildCategoryItem(CatModel.data!.data[index],context),
                   separatorBuilder:(context, index)=>SizedBox(
                     width: 10.0,
                   ),
                   itemCount: CatModel.data!.data.length,
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
                    (index) =>buildGridProduct(model.data!.products[index],context,index)),
          ),
        ),
      ],
    ),
  );

    Widget buildGridProduct(ProductsModel model,context,index) =>  Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              navigateTo(context, ProductDetailsScreen(index));
            },
            child: Stack(
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
                        onPressed: ()
                        {
                          ShopCubit.get(context).ChangeFavorites(model.id);
                        },
                        icon:CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          child: Icon(Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                    ),
                    SizedBox(width: 10.0,),
                    if(ShopCubit.get(context).carts[model.id!]!=null)
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeCarts(model.id);
                      },

                      icon:CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).carts[model.id!]! ? defaultColor : Colors.grey,
                        child: Icon(Icons.shopping_cart_sharp,
                          size: 14.0,
                          color: Colors.white,
                        ),
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

    Widget buildCategoryItem (DataModel model,context) => Container(
      height: 100.0,
      width: 100.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children:
        [
          Image(
            image: NetworkImage(model.image.toString()),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.8,),
            width: double.infinity,
            child: Text(
              model.name!,
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
