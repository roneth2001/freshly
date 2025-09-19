class FoodItem {
  final String name;
  final String category;
  final DateTime expiryDate;
  final String? imagePath;

  FoodItem({
    required this.name,
    required this.category,
    required this.expiryDate,
    this.imagePath,
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