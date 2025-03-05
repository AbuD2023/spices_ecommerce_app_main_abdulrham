import 'package:spices_ecommerce_app_main_abdulrham/data/model/user.dart';

class LoginDriver {
  bool? success;
  String? message;
  LoginDriverData? data;

  LoginDriver({this.success, this.message, this.data});

  LoginDriver.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? LoginDriverData.fromJson(json['data']) : null;
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

class LoginDriverData {
  String? token;
  User? user;

  LoginDriverData({this.token, this.user});

  LoginDriverData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
