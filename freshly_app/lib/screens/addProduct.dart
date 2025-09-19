import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  DateTime? _purchaseDate;
  DateTime? _expireDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            _buildInputField(
                              label: 'Product name',
                              controller: _productNameController,
                            ),
                            const SizedBox(height: 32),
                            _buildDateField(
                              label: 'Purchaser date',
                              selectedDate: _purchaseDate,
                              onTap: () => _selectPurchaseDate(context),
                            ),
                            const SizedBox(height: 32),
                            _buildDateField(
                              label: 'Expire date',
                              selectedDate: _expireDate,
                              onTap: () => _selectExpireDate(context),
                            ),
                            const SizedBox(height: 48),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: _addProduct,
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Add Product',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4CAF50),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.format_list_bulleted,
                  color: Colors.black87,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
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
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 35,
                ),
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black87,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.only(bottom: 8, top: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null 
                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                    : '',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectPurchaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _purchaseDate) {
      setState(() {
        _purchaseDate = picked;
      });
    }
  }

  Future<void> _selectExpireDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expireDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && picked != _expireDate) {
      setState(() {
        _expireDate = picked;
      });
    }
  }

  void _addProduct() {
    if (_productNameController.text.isNotEmpty && 
        _purchaseDate != null && 
        _expireDate != null) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Product added successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      _productNameController.clear();
      setState(() {
        _purchaseDate = null;
        _expireDate = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }
}