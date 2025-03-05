import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/Providers/order_provider.dart';
import 'package:spices_ecommerce_app_main_abdulrham/core/components/app_bar.dart';
import 'package:spices_ecommerce_app_main_abdulrham/core/routes/app_routes.dart';
import 'package:spices_ecommerce_app_main_abdulrham/data/model/order.dart';

class OrderCurrentPage extends StatelessWidget {
  const OrderCurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? selectedOrderId;
    bool isSelected = false;

    // OrderProvider orderCurrentProvider =
    //     Provider.of<OrderProvider>(context, listen: true);
    return Scaffold(
      appBar: buildAppBar(context, 'الطلبات',
          showBackButton: true,
          showSearchButton: false,
          backgroundColor: const Color.fromARGB(255, 2, 191, 128)),
      backgroundColor: Colors.grey[100],
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder<bool>(
              future: orderProvider.hasToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.teal));
                } else if (snapshot.data == false) {
                  // orderProvider.fetchCurrentOrders();
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('الرجاء تسجيل الدخول لعرض الطلبات.',
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            AppRoutes.generateRoute(
                                const RouteSettings(name: AppRoutes.login)),
                            (route) => false,
                          ),
                          child: const Text('تسجيل الدخول'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Consumer<OrderProvider>(
                      builder: (context, odrProv, child) {
                    if (orderProvider.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.teal));
                    } else if (orderProvider.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text(orderProvider.errorMessage,
                              style: const TextStyle(color: Colors.red)));
                    } else if (orderProvider.currentOrderData.order == null) {
                      return const Center(
                          child: Text('لا يوجد طلبات حاليه',
                              style: TextStyle(fontSize: 18)));
                    } else {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final order = orderProvider.currentOrderData.order!;
                          //  isSelected = false;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: isSelected ? 8.0 : 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () async {
                                      if (isSelected) {
                                        selectedOrderId = null;
                                        orderProvider.isselectedOrderDetails();
                                        isSelected = false;
                                        log('message');
                                        log(isSelected.toString(),
                                            name: 'isSelected');
                                        log(
                                            (orderProvider.selectedOrderDetails)
                                                .toString(),
                                            name:
                                                'orderCurrentProvider.selectedOrderDetails');
                                        // setState(() {});
                                      } else {
                                        // isSelected = true;
                                        selectedOrderId = order.id;
                                        orderProvider.isselectedOrderDetails();
                                        log(isSelected.toString(),
                                            name: 'isSelected');
                                        log(
                                            (orderProvider.selectedOrderDetails)
                                                .toString(),
                                            name:
                                                'orderCurrentProvider.selectedOrderDetails');
                                        // setState(() {});
                                        // await orderControl
                                        //     .fetchOrderDetails(order.id);
                                        log(order.status.toString(),
                                            name: 'order.status');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('طلب #${order.id}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.teal)),
                                              // if (order.status?.toLowerCase() ==
                                              //     'shipped') // شرط هنا
                                              //   IconButton.filled(
                                              //     icon: const Icon(Icons.cancel,
                                              //         color: Colors.green),
                                              //     onPressed: () => orderProvider
                                              //         .orderUpdateStatus(
                                              //             orderId: order.id!,
                                              //             status: 'on_way'),
                                              //   ),
                                              // if (order.status?.toLowerCase() ==
                                              //     'on_way') // شرط هنا
                                              //   IconButton(
                                              //     icon: const Icon(Icons.cancel,
                                              //         color: Colors.yellow),
                                              //     onPressed: () => orderProvider
                                              //         .orderUpdateStatus(
                                              //             orderId: order.id!,
                                              //             status: 'delivered'),
                                              //   ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          _buildInfoRow('الحالة', order.status!,
                                              _getStatusColor(order.status)),
                                          _buildInfoRow(
                                              'المبلغ الإجمالي',
                                              '${order.totalAmount} ريال',
                                              Colors.teal),
                                          _buildInfoRow(
                                              'طريقة الدفع',
                                              order.paymentMethod!,
                                              Colors.black87),
                                          _buildInfoRow(
                                              'تاريخ الطلب',
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(DateTime.parse(
                                                      order.createdAt!)),
                                              Colors.black87),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (Provider.of<OrderProvider>(context,
                                            listen: true)
                                        .selectedOrderDetails ==
                                    true)
                                  _buildOrderDetails(order, context),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusArabic(String? status) {
    switch (status?.toLowerCase()) {
      case 'on_way':
        return 'قيد التوصيل';
      case 'delivered':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      default:
        return 'غير معروف';
    }
  }

  Widget _buildInfoRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
              title == 'الحالة'
                  ? _getStatusArabic(value)
                  : value, // تحويل الحالة للعربية
              style: TextStyle(
                  color: color,
                  fontWeight: color == Colors.teal
                      ? FontWeight.bold
                      : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(Order order, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تفاصيل الطلب',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal)),
          SizedBox(height: 15),
          _buildDetailRow('معرف الطلب', order.id.toString()),
          _buildDetailRow('المبلغ الفرعي', order.subtotal.toString()),
          _buildDetailRow('مبلغ الخصم', order.discountAmount.toString()),
          _buildDetailRow('مبلغ التوصيل', order.deliveryAmount.toString()),
          _buildDetailRow('المبلغ الإجمالي', order.totalAmount.toString()),
          _buildDetailRow('عنوان الشحن', order.shippingAddress ?? 'غير محدد'),
          _buildDetailRow('طريقة الدفع', order.paymentMethod ?? 'غير محدد'),
          SizedBox(height: 15),
          if (order.status?.toLowerCase() == 'shipped') // شرط هنا
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'بداء التوصيل',
                      style: TextStyle(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.cancel, color: Colors.green),
                    ),
                  ],
                ),
                onPressed: () => Provider.of<OrderProvider>(context,
                        listen: false)
                    .orderUpdateStatus(orderId: order.id!, status: 'on_way'),
              ),
            ),
          if (order.status?.toLowerCase() == 'on_way') // شرط هنا
            Center(
              child: ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('تم التوصيل'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.cancel, color: Colors.yellow),
                    ),
                  ],
                ),
                onPressed: () => Provider.of<OrderProvider>(context,
                        listen: false)
                    .orderUpdateStatus(orderId: order.id!, status: 'delivered'),
              ),
            ),
          // if (order. != null)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('معلومات المستخدم',
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 20,
          //               color: Colors.teal)),
          //       SizedBox(height: 10),
          //       _buildDetailRow('اسم المستخدم', order.user!.name ?? 'غير محدد'),
          //       _buildDetailRow(
          //           'البريد الإلكتروني', order.user!.email ?? 'غير محدد'),
          //     ],
          //   ),
          // SizedBox(height: 15),
          // if (order.items != null && order.items!.isNotEmpty)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('العناصر',
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 20,
          //               color: Colors.teal)),
          //       SizedBox(height: 10),
          //       ListView.separated(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemCount: order.items!.length,
          //         itemBuilder: (context, index) {
          //           final item = order.items![index];
          //           return ListTile(
          //             leading: Image.network(item.image!,
          //                 width: 50, height: 50, fit: BoxFit.cover),
          //             title: Text(item.productName!),
          //             subtitle: Text(
          //                 'الكمية: ${item.quantity}, السعر: ${item.productPrice}'),
          //           );
          //         },
          //         separatorBuilder: (context, index) => Divider(),
          //       ),
          //     ],
          //   ),
          // SizedBox(height: 20),
          // if (order.status?.toLowerCase() ==
          //     'cancelled') // شرط لإظهار زر إعادة الطلب
          //   ElevatedButton(
          //     onPressed: () {
          //       // إضافة منطق إعادة الطلب هنا
          //       _reorder(order);
          //     },
          //     child: Text('إعادة الطلب', style: TextStyle(fontSize: 18)),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.teal,
          //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8)),
          //     ),
          //   ),
        ],
      ),
    );
  }

  // void _reorder(Order order) {
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
