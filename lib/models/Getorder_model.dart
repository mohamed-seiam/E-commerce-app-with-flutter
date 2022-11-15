class GetOrderModel {
  bool? status;
  Null? message;
  Data? data;



  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {

  List<Data>? data;
  dynamic total;



  Data.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }

    total = json['total'];
  }


}

class Data2 {
  dynamic id;
  dynamic total;
  String? date;
  String? status;



  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }


}
