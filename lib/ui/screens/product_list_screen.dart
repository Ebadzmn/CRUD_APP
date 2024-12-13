import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_list/models/productmodels.dart';
import 'package:product_list/ui/screens/update_product_screen.dart';
import 'package:product_list/ui/widgets/ProductItem.dart';

import 'add_new_product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {



  List<ProductItem> productList = [];
  bool _isLoading = false;
  @override

  @override
  void initState() {
    super.initState();
    _getProductList();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ProductList')),
        actions: [
          IconButton(onPressed: () {
            _getProductList();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getProductList();
        },
        child: Visibility(
          visible: _isLoading == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder( itemCount: productList.length , itemBuilder: (context,index) {
            return ProductWid(product: productList[index],
            onDelete: () {
              setState(() {
                productList.removeAt(index);
              });
            },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        // Navigator.pushNamed(context, AddNewProduct.name);
        final shouldRefresh = await Navigator.pushNamed(context, AddNewProduct.name);
        if (shouldRefresh == true) {
       _getProductList();
        }
      },
      child: const Icon(Icons.add),
      ),
    );
  }

  Future <void> _getProductList () async {
    productList.clear();
    _isLoading = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    print(response.statusCode);
    // print(response.body);
    if(response.statusCode ==200) {
      final decodedData = jsonDecode(response.body);
      print(decodedData['status']);
      for (Map<String,dynamic> p in decodedData['data']) {
        ProductItem product = ProductItem(
          id: p ['_id'],
          productName: p ['ProductName'],
          productCode: p ['ProductCode'],
          image: p ['Img'],
          quantity: p ['Qty'],
          unitPrice: p ['UnitPrice'],
          totalPrice: p ['TotalPrice'],
          createdDate: p ['CreatedDate'],
        );
        productList.add(product);
      };
      setState(() {});
    }
    _isLoading = false;
    setState(() {});
  }
}
