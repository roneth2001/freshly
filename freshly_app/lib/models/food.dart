class FoodItem {
  final String id;
  final String name;
  final String category;
  final DateTime purchaserDate;
  final DateTime expiryDate;
  final int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.purchaserDate,
    required this.expiryDate,
    required this.quantity,
  });


  // Helper method to check if item is expiring soon
  bool get isExpiringSoon {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    return difference <= 3 && difference >= 0;
  }

  // Helper method to check if item is expired
  bool get isExpired {
    final now = DateTime.now();
    return expiryDate.isBefore(now);
  }
}