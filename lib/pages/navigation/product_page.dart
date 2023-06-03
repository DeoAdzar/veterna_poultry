import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/widgets/shop/cart_badges.dart';

import '../../widgets/shop/catalog_products.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Toko",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
        actions: [
          CartBadges(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CatalogProducts(),
          ],
        ),
      ),
    );
  }
}
