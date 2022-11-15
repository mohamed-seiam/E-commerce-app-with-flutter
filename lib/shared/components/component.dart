// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, sort_child_properties_last, constant_identifier_names, dead_code, unused_local_variable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/models/get_favourites_model.dart';
import 'package:test/shared/style/colors.dart';

//  component to go name widget screen and back
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

// component to go name widget screen and not back
void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) {
        return false;
      },
    );
// reuable component to textFormField
// 2-TextFormField
Widget defultFormField({
  required TextEditingController controller,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChanged,
  required String? Function(String?)? validate,
  required TextInputType type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixpress,
  bool ispassword = false,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpress,
                icon: Icon(Icons.remove_red_eye),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

// defaultButton
Widget defultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required void Function()? function, // Good
  required String text,
  double height = 50.0,
  bool isUpperCase = true,
  double radius = 5.0,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
//TEXT BUTTON
//
Widget defultTextButton({
  required Function()? function,
  required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

// flutter toast msg

void showToast({
  required String text,
  required Toaststate state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastcolor(state),
      textColor: Colors.white,
      fontSize: 20.0,
    );

//  enum>> to swap color
enum Toaststate { SUCCESS, ERROR, WARNING }

// method change color
Color? chooseToastcolor(Toaststate state) {
  Color color;
  switch (state) {
    case Toaststate.SUCCESS:
      color = Colors.green;
      break;
    case Toaststate.ERROR:
      color = Colors.red;
      break;
    case Toaststate.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget mydivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[500],
      ),
    );

Widget BuildListProduct( model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image.toString()),
              width: 120,
              height: 120,
            ),
            if(model!.discount != 0 && isOldPrice )
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
        SizedBox(width: 20.0,),
        Expanded(
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
              Spacer(),
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
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      "${model.oldPrice}",
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  if ( ShopCubit.get(context).favorites[model.id]!=null)
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).ChangeFavorites(model.id!);
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
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

