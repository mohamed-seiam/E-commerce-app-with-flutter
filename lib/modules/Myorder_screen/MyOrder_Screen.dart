// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/cubit.dart';


class MyOrederScreen extends StatelessWidget {
   MyOrederScreen(ShopCubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('myorderscreen'),
    );
  }
}
