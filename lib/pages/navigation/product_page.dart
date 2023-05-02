import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:veterna_poultry/utils/pages.dart';

import '../../widgets/shop/catalog_products.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CatalogProducts(),
            ElevatedButton(
                onPressed: () => Get.toNamed(AppPages.CART_PRODUCTS),
                child: Text("Keranjang"))
          ],
        ),
      ),
    );
  }
}
