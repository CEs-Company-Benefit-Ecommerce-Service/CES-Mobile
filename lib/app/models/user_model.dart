class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? imageUrl;
  int? role;
  int? status;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  String? isReceived;
  List<Wallets>? wallets;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.address,
      this.imageUrl,
      this.role,
      this.status,
      this.companyId,
      this.createdAt,
      this.updatedAt,
      this.isReceived,
      this.wallets});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    status = json['status'];
    companyId = json['companyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isReceived = json['isReceived'];
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['address'] = this.address;
    data['imageUrl'] = this.imageUrl;
    data['role'] = this.role;
    data['status'] = this.status;
    data['companyId'] = this.companyId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isReceived'] = this.isReceived;
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallets {
  String? id;
  String? name;
  int? status;
  int? balance;
  int? used;
  int? limits;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  Wallets(
      {this.id,
      this.name,
      this.status,
      this.balance,
      this.used,
      this.limits,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    balance = json['balance'];
    used = json['used'];
    limits = json['limits'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['balance'] = this.balance;
    data['used'] = this.used;
    data['limits'] = this.limits;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
