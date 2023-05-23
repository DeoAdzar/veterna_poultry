import 'package:flutter/material.dart';
import '../widgets/shop/cart_products.dart';
import '../widgets/shop/cart_total.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CartProducts(),
            ),
            CartTotalPage()
          ],
        ),
      ),
    );
  }
}
