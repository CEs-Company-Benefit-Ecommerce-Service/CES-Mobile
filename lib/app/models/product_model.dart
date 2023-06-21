class ProductModel {
  String? id;
  int? price;
  int? quantity;
  String? name;
  int? status;
  String? description;
  String? serviceDuration;
  int? type;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  int? categoryId;
  Category? category;

  ProductModel(
      {this.id,
      this.price,
      this.quantity,
      this.name,
      this.status,
      this.description,
      this.serviceDuration,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.categoryId,
      this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    serviceDuration = json['serviceDuration'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imageUrl = json['imageUrl'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['status'] = this.status;
    data['description'] = this.description;
    data['serviceDuration'] = this.serviceDuration;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['imageUrl'] = this.imageUrl;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? status;
  List? products;

  Category(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        // products!.add(new List.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
