class Item {
  final int? id;
  final String name;
  final String purchaseDate;
  final String expiryDate;
  final int quantity;

  Item({
    this.id,
    required this.name,
    required this.purchaseDate,
    required this.expiryDate,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'purchaseDate': purchaseDate,
      'expiryDate': expiryDate,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      purchaseDate: map['purchaseDate'],
      expiryDate: map['expiryDate'],
      quantity: map['quantity'],
    );
  }
}
