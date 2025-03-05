import 'package:spices_ecommerce_app_main_abdulrham/data/model/order.dart';

class CurrentOrder {
  bool? success;
  String? message;
  CurrentOrderData? data;

  CurrentOrder({this.success, this.message, this.data});

  CurrentOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? CurrentOrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CurrentOrderData {
  Order? order;

  CurrentOrderData({this.order});

  CurrentOrderData.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}
