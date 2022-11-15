// ignore_for_file: non_constant_identifier_names
import '../../modules/login/shop_login.dart';
import 'component.dart';
import 'package:test/shared/network/local/cachhelper.dart';

void signOut(context)
{
  cacheHelper.removeData(key: "token")
      .then((value)
  {
    if (value)
    {
      navigateAndFinish(context, ShopLogin(),);
    }
  });
}

void printFullText(String text)
{
  final Pattern=RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? token=cacheHelper.getData(key:'token');