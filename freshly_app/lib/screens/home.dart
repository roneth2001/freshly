import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart'; 


class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  //get the box
  final box = Hive.box('productsBox');
  List products = [];

  @override
  void initState() {
    super.initState();
    products = box.get('products') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']),
            subtitle: Text('Category: ${product['category']} - Expiry: ${product['expiryDate']}'),
          );
        },
      ),
    );
  }
}