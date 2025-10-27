import 'package:flutter/material.dart';
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

  Future<void> _selectDate(bool isPurchase) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
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

      await dbHelper.insertItem(newItem.toMap());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Item Name"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter item name" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Please enter quantity" : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(_purchaseDate == null
                        ? "Select Purchase Date"
                        : "Purchase: ${_purchaseDate!.toLocal()}".split(' ')[0]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(true),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(_expiryDate == null
                        ? "Select Expiry Date"
                        : "Expiry: ${_expiryDate!.toLocal()}".split(' ')[0]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(false),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text("Save Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
