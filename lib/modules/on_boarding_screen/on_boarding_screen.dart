// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_import, empty_statements

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test/modules/login/shop_login.dart';
import 'package:test/shared/components/component.dart';
import 'package:test/shared/network/local/cachhelper.dart';

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
      Title: "Let\'s Make a Short Shopping tour ",
      Body: "Why go shopping if you can shop from your home?",
    ),
    BoardingModel(
      image: "assets/img/webshopping.png",
      Title: "Shop safely",
      Body: "In light of the Corona virus, shopping outside is not safe",
    ),
    BoardingModel(
      image: "assets/img/packagearrived.png",
      Title: "Speed and ease are our goal",
      Body: "We will deliver your order to you as quickly as possible and with the best quality",
    ),
    BoardingModel(
      image: "assets/img/succsesful.png",
      Title: "We have all payment methods",
      Body: "Our goal is to make it easier for our customers in every possible way",
    ),
  ];

  bool IsLast = false;

  void submit() {
    cacheHelper
        .saveData(
          key: 'onBoarding',
          value: true,
        )
        .then((value) 
        {
          if(value!)
          {
            navigateAndFinish(context, ShopLogin());
          }
        }
        );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defultTextButton(
             function:submit,
              text: 'SKIP'
            ),
           
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
                     submit();
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
