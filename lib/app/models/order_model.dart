class OrderModel {
  String? id;
  int? total;
  String? notes;
  String? address;
  String? orderCode;
  int? status;
  int? debtStatus;
  String? createdAt;
  String? updatedAt;
  String? employeeId;
  int? companyId;
  List<OrderDetails>? orderDetails;
  Employee? employee;

  OrderModel(
      {this.id,
      this.total,
      this.notes,
      this.address,
      this.orderCode,
      this.status,
      this.debtStatus,
      this.createdAt,
      this.updatedAt,
      this.employeeId,
      this.companyId,
      this.orderDetails,
      this.employee});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    notes = json['notes'];
    address = json['address'];
    orderCode = json['orderCode'];
    status = json['status'];
    debtStatus = json['debtStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    employeeId = json['employeeId'];
    companyId = json['companyId'];
    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['notes'] = this.notes;
    data['address'] = this.address;
    data['orderCode'] = this.orderCode;
    data['status'] = this.status;
    data['debtStatus'] = this.debtStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['employeeId'] = this.employeeId;
    data['companyId'] = this.companyId;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String? id;
  int? price;
  int? quantity;
  String? notes;
  String? createdAt;
  Product? product;

  OrderDetails(
      {this.id,
      this.price,
      this.quantity,
      this.notes,
      this.createdAt,
      this.product});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    notes = json['notes'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['notes'] = this.notes;
    data['createdAt'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  int? price;
  int? quantity;
  String? description;
  String? imageUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? discountId;
  String? supplierId;
  Category? category;
  Supplier? supplier;

  Product(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.description,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.discountId,
      this.supplierId,
      this.category,
      this.supplier});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryId = json['categoryId'];
    discountId = json['discountId'];
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
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['categoryId'] = this.categoryId;
    data['discountId'] = this.discountId;
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

class Employee {
  String? id;
  int? companyId;
  String? accountId;
  String? supplierName;
  String? supplierAddress;
  int? status;
  String? createdAt;
  String? updatedAt;
  Account? account;

  Employee(
      {this.id,
      this.companyId,
      this.accountId,
      this.supplierName,
      this.supplierAddress,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.account});

  Employee.fromJson(Map<String, dynamic> json) {
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
  int? companyId;
  String? createdAt;
  String? updatedAt;
  String? isReceived;
  List<Wallets>? wallets;

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
      this.createdAt,
      this.updatedAt,
      this.isReceived,
      this.wallets});

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
