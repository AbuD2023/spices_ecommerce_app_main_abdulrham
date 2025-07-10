class Order {
  int? id;
  dynamic subtotal;
  int? discountAmount;
  int? deliveryAmount;
  dynamic totalAmount;
  String? status;
  String? shippingAddress;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
      this.subtotal,
      this.discountAmount,
      this.deliveryAmount,
      this.totalAmount,
      this.status,
      this.shippingAddress,
      this.paymentMethod,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subtotal = json['subtotal'];
    discountAmount = json['discount_amount'] as int;
    deliveryAmount = json['delivery_amount'] as int;
    totalAmount = json['total_amount'];
    status = json['status'];
    shippingAddress = json['shipping_address'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subtotal'] = subtotal;
    data['discount_amount'] = discountAmount;
    data['delivery_amount'] = deliveryAmount;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['shipping_address'] = shippingAddress;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
