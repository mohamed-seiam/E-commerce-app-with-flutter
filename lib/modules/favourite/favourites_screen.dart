// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Favourites Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
