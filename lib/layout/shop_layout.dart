// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/states.dart';
import 'package:test/modules/login/shop_login.dart';
import 'package:test/modules/search/search_screen.dart';
import 'package:test/shared/components/component.dart';
import 'package:test/shared/network/local/cachhelper.dart';

import '../cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Salla",
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search),
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled,),
                  label: "Home",

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps,),
                  label: "Categories",

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite,),
                  label: "Favorites",

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings,),
                  label: "Settings",

                ),
              ],
            )
          ,
        );
      }
    );
  }
}
