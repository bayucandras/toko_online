import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;
  EditProduct({required this.product});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        Uri.parse(
            "https://semedhi.my.id/api/products/" + product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageUrlController.text
        });
    print(response.body);

    return json.decode(json.encode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController..text = product['name'],
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController
                    ..text = product['description'],
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Description";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController..text = product['price'],
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController..text = product['image_url'],
                  decoration: const InputDecoration(labelText: "Image URL"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Image";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('update success')));
                        });
                      } else {}
                    },
                    child: const Text("Update"))
              ],
            )));
  }
}
