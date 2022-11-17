// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, avoid_print, unused_import

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/layout/shop_layout.dart';
import 'package:test/modules/login/login_cubit/cubit.dart';
import 'package:test/modules/login/login_cubit/states.dart';
import 'package:test/modules/reagister_screen/shopreagister_screen.dart';
import 'package:test/shared/components/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/local/cachhelper.dart';

class ShopLogin extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ShopLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShoploginState>(
        //listen on validation of login
        listener: (BuildContext context, state) {
          if (state is ShoploginSuccessState) {
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
                        ShopLayout(),
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
        //block builder
        builder: (BuildContext context, state) {
          return Scaffold(
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
                        Image(
                            image: 
                            AssetImage('assets/img/login.png'),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defultFormField(
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "please entre your email address";
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
                          ispassword: ShopLoginCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          suffixpress: () => {
                            ShopLoginCubit.get(context)
                                .ChangePassowrdVisibality(),
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userloin(
                                  email: EmailController.text,
                                  password: PasswordController.text);
                            }
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
                        ConditionalBuilder(
                          condition: state is! ShoploginLoadingState,
                          builder: (context) => defultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userloin(
                                      email: EmailController.text,
                                      password: PasswordController.text);
                                }
                              },
                              text: 'Login',
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don\'t have an account?",
                            ),
                            defultTextButton(
                              function: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'register',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
