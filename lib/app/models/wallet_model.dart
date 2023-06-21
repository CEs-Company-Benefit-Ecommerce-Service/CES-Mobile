class WalletModel {
  String? id;
  String? name;
  int? type;
  int? balance;
  String? limit;
  String? accountId;

  WalletModel(
      {this.id,
      this.name,
      this.type,
      this.balance,
      this.limit,
      this.accountId});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    balance = json['balance'];
    limit = json['limit'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['balance'] = this.balance;
    data['limit'] = this.limit;
    data['accountId'] = this.accountId;
    return data;
  }
}
