import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  static const String name = '/add_new_screen';

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}



class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController _nameEditController = TextEditingController();
  final TextEditingController _priceEditController = TextEditingController();
  final TextEditingController _totalPriceEditController = TextEditingController();
  final TextEditingController _quantityEditController = TextEditingController();
  final TextEditingController _imageEditController = TextEditingController();
  final TextEditingController _codeEditController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewProductProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16) ,
        child: _buildProductForm(),
        ),
      ),
    );
  }

  Widget _buildProductForm () {
    return Form(key: _formKey ,child: Column(
      children: [
        TextFormField(
          controller: _nameEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Name',
            labelText: 'Product Name',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Name';
            }
            return null ;
          },
        ),
        TextFormField(
          controller: _priceEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Price',
            labelText: 'Product Price',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Price';
            }
            return null ;
          },
        ),
        TextFormField(
          controller: _totalPriceEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Total Price',
            labelText: 'Product Total Price',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Total Price';
            }
            return null ;
          },
        ),
        TextFormField(
          controller: _quantityEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Quantity',
            labelText: 'Product Quantity',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Quantity';
            }
            return null ;
          },
        ),
        TextFormField(
          controller: _imageEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Image',
            labelText: 'Product Image',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Image';
            }
            return null ;
          },
        ),
        TextFormField(
          controller: _codeEditController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Code',
            labelText: 'Product Code',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Product Code';
            }
            return null ;
          },
        ),

        const SizedBox(height: 15,),
        Visibility(
          visible: _addNewProductProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              _addNewProduct();
              Navigator.pop(context , true);
            }
          }, child: const Text('ADD Now')),
        )
      ],
    ));
  }
  Future<void> _addNewProduct () async {

    _addNewProductProgress = true;
    
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');

    Map<String , dynamic > requestBody = {
      "Img": _imageEditController.text.trim(),
      "ProductCode":_codeEditController.text.trim(),
      "ProductName":_nameEditController.text.trim(),
      "Qty": _quantityEditController.text.trim(),
      "TotalPrice":_totalPriceEditController.text.trim(),
      "UnitPrice":_priceEditController.text.trim()
    };

    Response response = await post(uri,headers: {
      'Content-type' : 'application/json'
    }, body: jsonEncode(requestBody));

    print(response.statusCode);

    _addNewProductProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
 _clearTextFields();
 ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('New product added'))
 );
    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed'))
      );
    }
  }


  void _clearTextFields () {
    _priceEditController.clear();
    _nameEditController.clear();
    _totalPriceEditController.clear();
    _codeEditController.clear();
    _imageEditController.clear();
    _priceEditController.clear();
  }










  @override
  void dispose () {
    super.dispose();
    _nameEditController.dispose();
    _priceEditController.dispose();
    _totalPriceEditController.dispose();
    _codeEditController.dispose();
    _imageEditController.dispose();
    _quantityEditController.dispose();
  }
}
