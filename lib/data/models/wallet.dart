class Wallet {
    int? id;
    String? userIdTo;
    String? userIdFrom;
    String? userName;
    double? amount;
    String? desc;
    String? createAt;

    Wallet({this.id, this.userIdTo, this.userIdFrom, this.userName, this.amount, this.desc, this.createAt}); 

    Wallet.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        userIdTo = json['userIdTo'];
        userIdFrom = json['userIdFrom'];
        userName = json['userName'];
        amount = json['amount'].toDouble();
        desc = json['desc'];
        createAt = json['createAt'];
    }

}