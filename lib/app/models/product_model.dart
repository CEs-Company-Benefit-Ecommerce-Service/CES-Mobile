class ProductModel {
  String? id;
  String? name;
  int? price;
  int? quantity;
  int? unitPrice;
  int? preDiscount;
  String? description;
  String? imageUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? supplierId;
  Category? category;
  Supplier? supplier;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.unitPrice,
      this.preDiscount,
      this.description,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.supplierId,
      this.category,
      this.supplier});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    preDiscount = json['preDiscount'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryId = json['categoryId'];
    supplierId = json['supplierId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['preDiscount'] = this.preDiscount;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['categoryId'] = this.categoryId;
    data['supplierId'] = this.supplierId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Supplier {
  String? id;
  String? companyId;
  String? accountId;
  String? supplierName;
  String? supplierAddress;
  int? status;
  String? createdAt;
  String? updatedAt;
  Account? account;

  Supplier(
      {this.id,
      this.companyId,
      this.accountId,
      this.supplierName,
      this.supplierAddress,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.account});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    accountId = json['accountId'];
    supplierName = json['supplierName'];
    supplierAddress = json['supplierAddress'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['accountId'] = this.accountId;
    data['supplierName'] = this.supplierName;
    data['supplierAddress'] = this.supplierAddress;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Account {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? imageUrl;
  int? role;
  int? status;
  String? companyId;
  String? expiredDate;
  String? createdAt;
  String? updatedAt;
  bool? isReceived;
  List<Suppliers>? suppliers;

  Account(
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
      this.expiredDate,
      this.createdAt,
      this.updatedAt,
      this.isReceived,
      this.suppliers});

  Account.fromJson(Map<String, dynamic> json) {
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
    expiredDate = json['expiredDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isReceived = json['isReceived'];
    if (json['suppliers'] != null) {
      suppliers = <Suppliers>[];
      json['suppliers'].forEach((v) {
        suppliers!.add(new Suppliers.fromJson(v));
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
    data['expiredDate'] = this.expiredDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isReceived'] = this.isReceived;
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suppliers {
  String? id;
  String? companyId;
  String? accountId;
  String? supplierName;
  String? supplierAddress;
  int? status;
  String? createdAt;
  String? updatedAt;

  Suppliers(
      {this.id,
      this.companyId,
      this.accountId,
      this.supplierName,
      this.supplierAddress,
      this.status,
      this.createdAt,
      this.updatedAt});

  Suppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    accountId = json['accountId'];
    supplierName = json['supplierName'];
    supplierAddress = json['supplierAddress'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['accountId'] = this.accountId;
    data['supplierName'] = this.supplierName;
    data['supplierAddress'] = this.supplierAddress;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
