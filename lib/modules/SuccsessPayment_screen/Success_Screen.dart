// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/layout/shop_layout.dart';
import 'package:test/shared/components/component.dart';


class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img/DONE.gif',),height: 400,width: 300,),
            Text('Your Payment Was Done Successfully',style: TextStyle(color: Colors.black54,fontSize: 20.0),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: defultButton(function: (){
                navigateAndFinish(context,ShopLayout());
              }, text: 'OK',
                radius: 30.0,
                background: Colors.blue,
                height: 40.0,

              ),
            ),
          ],
        ),
      ),
    );
  }
}