// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/layout/shop_layout.dart';
import 'package:test/modules/login/login_cubit/cubit.dart';
import 'package:test/modules/login/shop_login.dart';
import 'package:test/modules/reagister_screen/register_cubit/cubit.dart';
import 'package:test/modules/reagister_screen/register_cubit/states.dart';
import 'package:test/shared/components/component.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/local/cachhelper.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
   var EmailController = TextEditingController();
   var PasswordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
   // ShopRegisterCubit cubit = new ShopRegisterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopregisterState>(
        listener: (context,state){
          if (state is ShopregisterSuccessState) {
            //check on statues not statue code
            //if login success
            if (state.loginModel.status!) {
              //usable component for toast
              showToast(
                  text: state.loginModel.message!, state: Toaststate.SUCCESS);
              cacheHelper
                  .saveData(key: "token", value: state.loginModel.data?.token)
                  .then((value){
                token = state.loginModel.data?.token;
                navigateAndFinish(
                  context,
                  ShopLogin(),
                );});
            } else {
              //if login failed
              showToast(
                text: state.loginModel.message!,
                state: Toaststate.ERROR,
              );
            }
          }
        },
         builder: (context,state) {
         return  Scaffold(
             appBar: AppBar(),
             body: Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "REGISTER",
                           style: Theme
                               .of(context)
                               .textTheme
                               .headline4!
                               .copyWith(color: Colors.black),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           "Register now to browse our hot offers",
                           style:
                           Theme
                               .of(context)
                               .textTheme
                               .bodyText1
                               ?.copyWith(
                             color: Colors.grey,
                           ),
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         defultFormField(
                           controller: nameController,
                           type: TextInputType.name,
                           validate: (String? value) {
                             if (value!.isEmpty) {
                               return "please entre your name";
                             }
                           },
                           label: "User Name",
                           prefix: Icons.person,
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         defultFormField(
                           controller: EmailController,
                           type: TextInputType.emailAddress,
                           validate: (String? value) {
                             if (value!.isEmpty) {
                               return "please entre your Email";
                             }
                           },
                           label: "Email Address",
                           prefix: Icons.email_outlined,
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         defultFormField(
                           controller: PasswordController,
                           type: TextInputType.visiblePassword,
                           ispassword: ShopRegisterCubit
                               .get(context)
                               .isPassword,
                           suffix: ShopRegisterCubit
                               .get(context)
                               .isPassword ? Icons.visibility_outlined : Icons
                               .visibility_off_outlined,
                           suffixpress: () =>
                           {
                             ShopRegisterCubit.get(context)
                                 .ChangePassowrdVisibality(),
                           },
                           onSubmit: (value) {

                           },
                           validate: (String? value) {
                             if (value!.isEmpty) {
                               return "password is too short ";
                             }
                           },
                           label: "Password",
                           prefix: Icons.lock_outline,
                         ),
                         SizedBox(
                           height: 30.0,
                         ),
                         defultFormField(
                           controller: phoneController,
                           type: TextInputType.phone,
                           validate: (String? value) {
                             if (value!.isEmpty) {
                               return "please entre your Phone Number";
                             }
                           },
                           label: "Phone Number",
                           prefix: Icons.phone,
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         ConditionalBuilder(
                           condition: state is! ShopregisterLoadingState,
                           builder: (context) =>
                               defultButton(
                                   function: () {
                                     if (formKey.currentState!.validate()) {
                                       ShopRegisterCubit.get(context).userregister(
                                            name: nameController.text,
                                           email: EmailController.text,
                                           password: PasswordController.text,
                                            phone: phoneController.text,
                                       );
                                     }
                                   },
                                   text: 'Register',
                                   isUpperCase: true),
                           fallback: (context) =>
                               Center(child: CircularProgressIndicator()),
                         ),
                         SizedBox(
                           height: 15.0,
                         ),

                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         }
         ),
      );
  }
}