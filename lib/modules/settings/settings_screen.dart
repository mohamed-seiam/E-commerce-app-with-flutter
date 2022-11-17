// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/cubit.dart';
import 'package:test/cubit/states.dart';

import 'package:test/shared/components/component.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/local/cachhelper.dart';

class SettingsScreen extends StatelessWidget
{
   SettingsScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emilController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
          if(model!=null && model.data!=null)
          {
            nameController.text =  model.data!.name!;
            emilController.text =  model.data!.email!;
            phoneController.text =  model.data!.phone!;
          }


        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context) => SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                      defultFormField(
                        controller:nameController,
                        validate: (String?value )
                        {
                          if(value!.isEmpty)
                          {
                            return 'Name must not be empty';
                          }
                          return null;
                        }
                        , type:TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(height: 40,),
                      defultFormField(
                        controller:emilController,
                        validate: (String?value )
                        {
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }
                          return null;
                        }
                        , type:TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(height: 40,),
                      defultFormField(
                        controller:phoneController,
                        validate: (String?value )
                        {
                          if(value!.isEmpty)
                          {
                            return 'Phone must not be empty';
                          }
                          return null;
                        }
                        , type:TextInputType.phone,
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      SizedBox(height: 40.0,),
                      defultButton(
                          function:() {
                            signOut(context);
                            },
                          text: "Log Out",
                      ),
                      SizedBox(height: 30.0,),
                      defultButton(
                        function:() {

                          if(formkey.currentState!.validate())
                          {
                            ShopCubit.get(context).UpdateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emilController.text,
                            );
                          }

                        },
                        text: "update",
                      ),
                      SizedBox(height: 30.0,),
                      // defultButton(
                      //     function:()
                      //     {
                      //       navigateTo(context, MyOrederScreen(ShopCubit.get(context).getOrderModel));
                      //     },
                      //     text: 'My Orders',
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback:(context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
