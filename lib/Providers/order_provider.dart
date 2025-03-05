// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spices_ecommerce_app_main_abdulrham/data/model/current_order.dart';
import 'package:spices_ecommerce_app_main_abdulrham/data/model/orders_history.dart';
import 'package:spices_ecommerce_app_main_abdulrham/linkapi.dart';
import 'dart:convert';

import '../core/services/auth_service.dart';

class OrderProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _selectedOrderDetails = true;
  String _errorMessage = '';
  String _orderUpdateStatuserrorMessage = '';
  String _errorMessageOrderCurrent = '';
  CurrentOrderData _currentOrderData = CurrentOrderData();
  OrdersHistoryData _ordersHistoryData = OrdersHistoryData(orders: []);

  // Getters
  bool get isLoading => _isLoading;
  bool get selectedOrderDetails => _selectedOrderDetails;
  String get errorMessage => _errorMessage;
  String get errorMessageOrderCurrent => _errorMessageOrderCurrent;
  String get orderUpdateStatuserrorMessage => _orderUpdateStatuserrorMessage;
  CurrentOrderData get currentOrderData => _currentOrderData;
  OrdersHistoryData get ordersHistoryData => _ordersHistoryData;

  // OrderProvider() {
  //   fetchCurrentOrders();
  //   fetchHistoryOrders();
  // }
  void isselectedOrderDetails() {
    _selectedOrderDetails = !_selectedOrderDetails;
    notifyListeners();
  }

  Future<bool> hasToken() async {
    final token = await _authService.getToken();
    return token != null;
  }

  Future<void> fetchCurrentOrders() async {
    try {
      _isLoading = true;
      _errorMessageOrderCurrent = '';
      notifyListeners();
      final token = await _authService.getToken();
      if (token == null) {
        _errorMessageOrderCurrent = 'الرجاء تسجيل الدخول لعرض الطلبات.';
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(AppLink.currentOrdersFetch),
        headers: _buildHeaders(token),
      );

      print('fetchOrders: Response status code: ${response.statusCode}');
      print('fetchOrders: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];
        if (data != null) {
          _currentOrderData = CurrentOrderData.fromJson(data);
          // final orders = _currentOrderData.order;
          // notifyListeners();
          print('fetchOrders: Orders fetched successfully Current orders');
        } else {
          _currentOrderData = CurrentOrderData();
          print('fetchOrders: No orders found.');
        }
      } else {
        _errorMessageOrderCurrent = 'Failed to load orders';
        print('fetchOrders: Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessageOrderCurrent = 'Error: $e';
      print('fetchOrders: Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHistoryOrders() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      final token = await _authService.getToken();
      if (token == null) {
        _errorMessage = 'الرجاء تسجيل الدخول لعرض الطلبات السابقة.';
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(AppLink.historyOrdersFetch),
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];
        if (data != null) {
          _ordersHistoryData = OrdersHistoryData.fromJson(
              data); // data.map((item) => OrdersHistoryData.fromJson(item)).toList();
          print('fetchOrders: Orders fetched successfully: History orders');
        } else {
          _ordersHistoryData = OrdersHistoryData(orders: []);
          print('fetchOrders: No History orders found.');
        }
      } else {
        _errorMessage = 'Failed to load History orders';
        print(
            'fetchOrders: Failed to load History orders: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('fetchOrders: Error: $e');
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

  Future<void> orderUpdateStatus(
      {required int orderId, required String status}) async {
    try {
      _isLoading = true;
      _orderUpdateStatuserrorMessage = '';
      final token = await _authService.getToken();
      notifyListeners();
      if (token == null) throw Exception('No token found');

      final response = await http.put(
        // Change to http.put
        Uri.parse(AppLink.orderUpdateStatus),
        headers: _buildHeaders(token),
        body: json.encode({
          "order_id": orderId,
          "status": status,
        }),
      );

      print('UpdateStatusOrder: Response status code: ${response.statusCode}');
      print('UpdateStatusOrder: Response body: ${response.body}');

      if (response.statusCode == 200) {
        // await fetchCurrentOrders();
        Get.snackbar('نجاح', 'تم تحديث حالة الطلب بنجاح');
        print('cancelOrder: Order cancelled successfully: $orderId');
      } else {
        _orderUpdateStatuserrorMessage =
            json.decode(response.body)['message'] ?? 'فشل في تحديث حالة الطلب';
        Get.snackbar('خطأ', _orderUpdateStatuserrorMessage);
        print(
            'cancelOrder: Failed to Update status order: ${response.statusCode}');
      }
    } catch (e) {
      _orderUpdateStatuserrorMessage = 'خطأ: $e';
      Get.snackbar('خطأ', _orderUpdateStatuserrorMessage);
      print('UpdateStatusOrder: Error: $e');
    } finally {
      _isLoading = false;
      await fetchCurrentOrders();
      await fetchHistoryOrders();
      notifyListeners();
    }
  }
}
