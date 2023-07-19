class WalletTransactionModel {
  String? id;
  int? total;
  String? description;
  int? type;
  String? createdAt;
  String? senderId;
  String? recieveId;
  String? orderId;
  String? walletId;
  int? companyId;
  String? paymentProviderId;
  String? invoiceId;
  int? status;

  WalletTransactionModel(
      {this.id,
      this.total,
      this.description,
      this.type,
      this.createdAt,
      this.senderId,
      this.recieveId,
      this.orderId,
      this.walletId,
      this.companyId,
      this.paymentProviderId,
      this.invoiceId,
      this.status});

  WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    description = json['description'];
    type = json['type'];
    createdAt = json['createdAt'];
    senderId = json['senderId'];
    recieveId = json['recieveId'];
    orderId = json['orderId'];
    walletId = json['walletId'];
    companyId = json['companyId'];
    paymentProviderId = json['paymentProviderId'];
    invoiceId = json['invoiceId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['description'] = this.description;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['senderId'] = this.senderId;
    data['recieveId'] = this.recieveId;
    data['orderId'] = this.orderId;
    data['walletId'] = this.walletId;
    data['companyId'] = this.companyId;
    data['paymentProviderId'] = this.paymentProviderId;
    data['invoiceId'] = this.invoiceId;
    data['status'] = this.status;
    return data;
  }
}
