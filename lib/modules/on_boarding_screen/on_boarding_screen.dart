// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_import, empty_statements

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test/modules/login/shop_login.dart';
import 'package:test/shared/components/component.dart';

import '../../shared/style/colors.dart';

//module class for list for boardingScreen
class BoardingModel {
  final String image;
  final String Title;
  final String Body;

  BoardingModel({
    required this.image,
    required this.Title,
    required this.Body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //declare variable to assign to it PageController
  var BoardController = PageController();
//list of object from class BoardingModel
  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/img/shopping.png",
      Title: "On Board1 Title",
      Body: "On Board1 body",
    ),
    BoardingModel(
      image: "assets/img/shopping.png",
      Title: "On Board2 Title",
      Body: "On Board2 body",
    ),
    BoardingModel(
      image: "assets/img/shopping.png",
      Title: "On Board3 Title",
      Body: "On Board3 body",
    ),
  ];

  bool IsLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                navigateAndFinish(context, ShopLogin());
              },
              child: Text("SKIP"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: BoardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      IsLast = true;
                    });
                  } else {
                    setState(() {
                      IsLast = false;
                    });
                  }
                  ;
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    bulidBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (IsLast) {
                      navigateAndFinish(context, ShopLogin());
                    } else {
                      BoardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                    ;
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//widget bulidBoardItem to give it to PageView.builder
Widget bulidBoardItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage("${model.image}")),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${model.Title}",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${model.Body}",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
