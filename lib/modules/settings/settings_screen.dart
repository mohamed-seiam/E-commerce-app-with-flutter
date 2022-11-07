// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Settings Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
