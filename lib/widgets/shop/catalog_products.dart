import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/controller/cart_controller.dart';
import 'package:veterna_poultry/pages/controller/product_controller.dart';
import 'package:veterna_poultry/utils/dimen.dart';

import '../show_snackbar.dart';

class CatalogProducts extends StatelessWidget {
  final cartController = Get.put(CartController());
  CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Flexible(
          child: ListView.builder(
            itemCount: cartController.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(index: index);
            },
          ),
        ));
  }
}

class CatalogProductCard extends StatelessWidget {
  final productController = Get.put(ProductController());
  final CartController cartController = Get.find();
  final int index;
  CatalogProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(cartController.products[index].img_path),
                )),
          ),
          SizedBox(
            width: Dimen(context).width * 0.02,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartController.products[index].title,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  '${cartController.products[index].price}',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              productController.addProduct(cartController.products[index]);
              productController.incQuantity();
              ShowSnackbar.snackBarSuccess(
                  "Berhasil menambahkan ${cartController.products[index].title} ke keranjang");
            },
            icon: Icon(Icons.add_shopping_cart_outlined),
          )
        ],
      ),
    );
  }
}
