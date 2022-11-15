// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/modules/search/cubit/cubit.dart';
import 'package:test/modules/search/cubit/states.dart';
import 'package:test/shared/components/component.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
      var formkey = GlobalKey<FormState>();
      var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    SizedBox(height: 20.0,),
                    defultFormField(
                        controller:searchController,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'entre Text to Search';
                          }
                          return null;
                        },
                          onSubmit: (String? text)
                          {
                            SearchCubit.get(context).search(text!);
                          },
                        type:TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search_rounded,
                    ),
                    SizedBox(height: 20.0,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 15.0,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => BuildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false) ,
                        separatorBuilder: (context,index) => mydivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
