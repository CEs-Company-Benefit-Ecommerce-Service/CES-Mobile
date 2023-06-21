class LoginModel {
  Account? account;
  Token? token;

  LoginModel({this.account, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class Account {
  String? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? updatedAt;
  String? createdAt;
  String? imageUrl;
  int? status;
  int? roleId;
  int? companyId;
  List<void>? wallets;

  Account(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.updatedAt,
      this.createdAt,
      this.imageUrl,
      this.status,
      this.roleId,
      this.companyId,
      this.wallets});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    roleId = json['roleId'];
    companyId = json['companyId'];
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        // wallets!.add(new Void.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['roleId'] = this.roleId;
    data['companyId'] = this.companyId;
    if (this.wallets != null) {
      data['wallets'] = this.wallets;
      // data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
