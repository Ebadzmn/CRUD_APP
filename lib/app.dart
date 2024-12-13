import 'package:flutter/material.dart';
import 'package:product_list/models/productmodels.dart';
import 'package:product_list/ui/screens/add_new_product.dart';
import 'package:product_list/ui/screens/product_list_screen.dart';
import 'package:product_list/ui/screens/update_product_screen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
       late Widget widget;

        if (settings.name == '/') {
          widget = const ProductListScreen();
        }
        else if (settings.name == AddNewProduct.name) {
          widget = const AddNewProduct();
        }

        else if (settings.name == UpdateProductScreen.name ) {
          final ProductItem product = settings.arguments as ProductItem;
          widget = UpdateProductScreen(product: product);
        }




        return MaterialPageRoute(builder: (context) {
          return widget;
        });
      },
    );
  }
}
