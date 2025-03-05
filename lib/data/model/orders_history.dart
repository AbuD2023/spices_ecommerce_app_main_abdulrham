import 'package:spices_ecommerce_app_main_abdulrham/data/model/order.dart';

class OrdersHistory {
  bool? success;
  String? message;
  OrdersHistoryData? data;

  OrdersHistory({this.success, this.message, this.data});

  OrdersHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? OrdersHistoryData.fromJson(json['data']) : null;
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

class OrdersHistoryData {
  late List<Order> orders;

  OrdersHistoryData({required this.orders});

  OrdersHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      final List<dynamic> data = json['orders'];
      orders = data.map((order) => Order.fromJson(order)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders.isNotEmpty) {
      data['orders'] = orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
