class User {
  int? id;
  String? name;
  String? phone;
  String? password;
  String? salary;
  String? image;
  String? identityImage;
  String? identityNumber;
  String? iban;
  bool? hasOrder;
  String? address;
  String? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.phone,
      this.password,
      this.salary,
      this.image,
      this.identityImage,
      this.identityNumber,
      this.iban,
      this.hasOrder,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    salary = json['salary'];
    image = json['image'];
    identityImage = json['identity_image'];
    identityNumber = json['identity_number'];
    iban = json['iban'];
    hasOrder = json['has_order'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['salary'] = salary;
    data['image'] = image;
    data['identity_image'] = identityImage;
    data['identity_number'] = identityNumber;
    data['iban'] = iban;
    data['has_order'] = hasOrder;
    data['address'] = address;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
