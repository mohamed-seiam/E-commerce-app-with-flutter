

import 'package:flutter/material.dart';

class HomeModel
{
   bool? status;
   HomeDataModel? data;
  HomeModel.fromjson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']) ;
  }
}


class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromjson(Map<String,dynamic>json)
  {
      json['banners'].forEach((element)
      {
        banners.add(BannerModel.fromjson(element));
      });

      json['products'].forEach((element)
      {
        products.add(ProductsModel.fromjson(element));
      });
  }
}

class BannerModel
{
    dynamic id;
    String? image;
    BannerModel.fromjson(Map<String,dynamic>json)
    {
        id = json['id'];
        image = json['image'];
    }
}

class ProductsModel
{
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  int ? quantity=0;
  ProductsModel.fromjson(Map<String,dynamic>json)
  {
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      inFavorites = json['in_favorites'];
      inCart = json['in_cart'];
      name = json['name'];
      image = json['image'];
      description=json['description'];
  }
}