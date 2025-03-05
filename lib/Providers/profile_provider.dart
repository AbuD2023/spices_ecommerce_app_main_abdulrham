import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spices_ecommerce_app_main_abdulrham/core/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:spices_ecommerce_app_main_abdulrham/linkapi.dart';

import '../data/model/user.dart';

class ProfileProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _errorMessage = '';
  User? _user;

  //Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  User? get user => _user;

  Future<void> fetchDriverProfile() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      final token = await _authService.getToken();
      if (token == null) {
        _errorMessage = 'الرجاء تسجيل الدخول لعرض الطلبات.';
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(AppLink.profile),
        headers: _buildHeaders(token),
      );

      print('fetchprofile: Response status code: ${response.statusCode}');
      print('fetchprofile: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        log(jsonData['data'].toString(), name: 'data');
        final dynamic data = jsonData['data']['driver'];
        log(data.toString(), name: 'profile');
        if (data != null) {
          _user = User.fromJson(data);

          print('fetchprofile: Orders fetched successfully profile');
        } else {
          _user = User();
          print('fetchprofile: No profile found.');
        }
      } else {
        _errorMessage = 'Failed to load profile';
        print('fetchProfile: Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      final data = await _authService.getUserData();
      if (data != null) {
        _user = User.fromJson(data);
      }
      print('fetchProfile: Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, String> _buildHeaders(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
