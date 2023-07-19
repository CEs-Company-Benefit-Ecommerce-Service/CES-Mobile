class AccountPayloadModel {
  String? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? imageUrl;
  int? role;
  int? companyId;

  AccountPayloadModel(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.imageUrl,
      this.role,
      this.companyId});

  AccountPayloadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['imageUrl'] = this.imageUrl;
    data['role'] = this.role;
    data['companyId'] = this.companyId;
    return data;
  }
}
