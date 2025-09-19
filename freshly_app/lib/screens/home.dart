import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List to store food items (empty initially as shown in design)
  List<FoodItem> foodItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Green gradient background matching the design
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB8E6B8), // Light green at top
              Color(0xFF7CB342), // Darker green at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App header with logo
              _buildHeader(),
              // Main content area
              Expanded(
                child: _currentIndex == 0 
                  ? _buildListScreen() 
                  : _buildAddScreen(),
              ),
            ],
          ),
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Header widget with Freshly logo and apple icon
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          // Apple icon with heart shape (simplified representation)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Apple shape (simplified as red circle with green leaves)
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 35,
                ),
                // Green leaves at top
                Positioned(
                  top: 8,
                  child: Container(
                    width: 20,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // App name
          const Text(
            'Freshly',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // List screen (empty state as shown in design)
  Widget _buildListScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty box icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // Box outline
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // Box lid lines
                Positioned(
                  top: 15,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 25,
                  right: 25,
                  child: Container(
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Empty list text
          const Text(
            'Empty List',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Add screen placeholder
  Widget _buildAddScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 80,
            color: Colors.black54,
          ),
          SizedBox(height: 24),
          Text(
            'Add New Food Item',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Track expiry dates and reduce food waste',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar matching the design
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // List tab
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _currentIndex = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_list_bulleted,
                      color: _currentIndex == 0 
                        ? Colors.black87 
                        : Colors.black54,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _currentIndex == 0 
                          ? Colors.black87 
                          : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Add tab
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _currentIndex = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: _currentIndex == 1 
                        ? Colors.black87 
                        : Colors.black54,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _currentIndex == 1 
                          ? Colors.black87 
                          : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data model for food items
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

// Additional screens that can be implemented:

// Add Food Screen
class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Item'),
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB8E6B8),
              Color(0xFF7CB342),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Form fields would go here
                // This is a placeholder for the add food form
                const Text(
                  'Add food form will be implemented here',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}

// Food List Item Widget (for when list is populated)
class FoodListItem extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback? onTap;

  const FoodListItem({
    Key? key,
    required this.foodItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green;
    String statusText = 'Fresh';

    if (foodItem.isExpired) {
      statusColor = Colors.red;
      statusText = 'Expired';
    } else if (foodItem.isExpiringSoon) {
      statusColor = Colors.orange;
      statusText = 'Expiring Soon';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(
            Icons.food_bank,
            color: statusColor,
          ),
        ),
        title: Text(
          foodItem.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(foodItem.category),
            Text(
              'Expires: ${foodItem.expiryDate.day}/${foodItem.expiryDate.month}/${foodItem.expiryDate.year}',
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withOpacity(0.3)),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}