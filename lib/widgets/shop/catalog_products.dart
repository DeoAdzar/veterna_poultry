import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/controller/cart_controller.dart';
import 'package:veterna_poultry/pages/controller/product_controller.dart';
import 'package:veterna_poultry/utils/currency_format.dart';
import 'package:veterna_poultry/utils/dimen.dart';

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
              child: CachedNetworkImage(
                imageUrl: cartController.products[index].imgPath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180.0),
                      border:
                          Border.all(width: 2, color: Colors.grey.shade200)),
                  child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(child: CircularProgressIndicator())),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
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
                  CurrencyFormat.convertToIdr(
                      cartController.products[index].price),
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.closeCurrentSnackbar();
              productController.addProduct(cartController.products[index]);
            },
            icon: Icon(Icons.add_shopping_cart_outlined),
          )
        ],
      ),
    );
  }
}
