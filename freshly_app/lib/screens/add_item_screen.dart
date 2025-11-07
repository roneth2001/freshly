import 'package:flutter/material.dart';
import 'package:freshly_app/services/notification_service.dart';
import '../db/database_helper.dart';
import '../models/item_model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _purchaseDate;
  DateTime? _expiryDate;

  final dbHelper = DatabaseHelper();

  get _purchaseDateController => _purchaseDate;

  get _expireDateController => _expiryDate;

  Future<void> _selectDate(bool isPurchase) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7CB342),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isPurchase) {
          _purchaseDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate() &&
        _purchaseDate != null &&
        _expiryDate != null) {
      final newItem = Item(
        name: _nameController.text.trim(),
        purchaseDate: _purchaseDate!.toIso8601String(),
        expiryDate: _expiryDate!.toIso8601String(),
        quantity: int.parse(_quantityController.text),
      );

      final itemId = await dbHelper.insertItem(newItem.toMap());
      
      // Schedule notification
      await NotificationService().scheduleItemNotification(
        itemId,
        newItem.name,
        _expiryDate!,
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Add Item"),
        backgroundColor: const Color(0xFF7CB342),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Item Name",
                          labelStyle: const TextStyle(color: Color(0xFF689F38)),
                          prefixIcon: const Icon(Icons.shopping_bag, color: Color(0xFF7CB342)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF7CB342), width: 2),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter item name" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: "Quantity",
                          labelStyle: const TextStyle(color: Color(0xFF689F38)),
                          prefixIcon: const Icon(Icons.numbers, color: Color(0xFF7CB342)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF7CB342), width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter quantity" : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Color(0xFF7CB342)),
                      title: Text(
                        _purchaseDate == null
                            ? "Select Purchase Date"
                            : "Purchase Date",
                        style: TextStyle(
                          color: _purchaseDate == null ? Colors.grey[600] : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: _purchaseDate != null
                          ? Text(
                              "${_purchaseDate!.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                color: Color(0xFF689F38),
                                fontSize: 16,
                              ),
                            )
                          : null,
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CCC65),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit_calendar, color: Colors.white),
                          onPressed: () => _selectDate(true),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.event_available, color: Color(0xFF7CB342)),
                      title: Text(
                        _expiryDate == null
                            ? "Select Expiry Date"
                            : "Expiry Date",
                        style: TextStyle(
                          color: _expiryDate == null ? Colors.grey[600] : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: _expiryDate != null
                          ? Text(
                              "${_expiryDate!.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                color: Color(0xFF689F38),
                                fontSize: 16,
                              ),
                            )
                          : null,
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CCC65),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit_calendar, color: Colors.white),
                          onPressed: () => _selectDate(false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _saveItem(); // Save the item

                  // Clear all text fields
                  _nameController.clear();
                  _purchaseDateController.clear();
                  _expireDateController.clear();
                  _quantityController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CB342),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Save Item",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}