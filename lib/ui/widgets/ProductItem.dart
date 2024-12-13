import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_list/ui/screens/update_product_screen.dart';
import '../../models/productmodels.dart';

class ProductWid extends StatelessWidget {
  const ProductWid ({super.key, required this.product, required this.onDelete });
  final ProductItem product;

  final dynamic onDelete;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Image.network(product.image ?? '' ,width: 30,),
      title:Text(product.productName ?? 'Nothing' , style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code : ${product.productCode ?? 'Nothing'}',
            style: TextStyle(
              fontSize: 16.0, // Font size
              fontWeight: FontWeight.bold, // Font weight
              color: Colors.blue, // Text color
            ),
          ),
          Text(
            'Quantity : ${product.quantity ?? 'Nothing'}',
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic, // Italic text
              color: Colors.green,
            ),
          ),
          Text(
            'Price : ${product.unitPrice ?? 'Nothing'}',
            style: TextStyle(
              fontSize: 16.0,
              decoration: TextDecoration.underline, // Underlined text
              color: Colors.orange,
            ),
          ),
          Text(
            'Total Price : ${product.totalPrice ?? 'nothing'}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600, // Semi-bold text
              color: Colors.red,
            ),
          ),
        ],

      ),
      trailing: Wrap(
        children: [

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2)
                )
              ]
            ),
            child: IconButton(onPressed: () {
              Navigator.pushNamed(context, UpdateProductScreen.name,arguments: product);
            }, icon: Icon(Icons.edit) , color: Colors.blueAccent,),
          ),
          IconButton(onPressed: () {
           _deleteProduct(context);
          }, icon: Icon(Icons.delete), color: Colors.red,),
        ],
      ),
    );
  }
  Future<void> _deleteProduct(BuildContext context) async {
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${product.id}');
    Response response =  await get(uri);

    print(response.statusCode);
    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Done'),));
       onDelete();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed')));
    }
  }
}
