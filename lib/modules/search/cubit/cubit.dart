import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/search_model.dart';
import 'package:test/modules/search/cubit/states.dart';
import 'package:test/shared/components/constance.dart';
import 'package:test/shared/network/endpoint.dart';
import 'package:test/shared/network/remote/diohelper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

    SearchModel? model;

      void search(String text)
      {
        emit(SearchLoadingState());
         DioHelper.postData(
             url:SEARCH,
             token: token,
             data:
             {
               'text':text,
             })
             .then((value)
           {
             model = SearchModel.fromJson(value.data);
              emit(SearchSuccessState());
           })
             .catchError((error)
         {
           print(error.toString());
           emit(SearchErrorState());
         }
         );
      }

}