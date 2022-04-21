


class Transaction {
  int ?id;
  String ?created;
  String ?amount;
  String ?vendoramount;
  String ?useramount;
  String ? category;
  String ?createdtime;


  Transaction(
      {this.created,
        this.id,
        this.amount,
        this.createdtime,
        this.vendoramount,
        this.useramount,
        this.category,
      });

  Map<String, dynamic> toJson() {
    return {
      "created": created,
      'id': id,
      "amount": amount,
      "vendoramount": vendoramount,
      "useramount":useramount,
      "category": category,
      'createdtime': createdtime,
    };
  }

  factory Transaction.fromJson(jsonData) => Transaction(
    created: jsonData["created"],
    amount: jsonData["amount"],
    createdtime: jsonData['createdtime'],
    id: jsonData['id'],
    vendoramount: jsonData["vendoramount"],
    useramount: jsonData['useramount'],
    category: jsonData['category'],
  );

}
