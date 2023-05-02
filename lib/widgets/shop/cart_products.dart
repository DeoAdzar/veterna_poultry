import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/controller/product_controller.dart';
import 'package:veterna_poultry/pages/model/product_model.dart';

import '../../utils/dimen.dart';

class CartProducts extends StatelessWidget {
  final ProductController controller = Get.find();
  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 600,
          child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
              );
            },
          ),
        ));
  }
}

class CartProductCard extends StatelessWidget {
  final ProductController controller;
  final Product product;
  final int quantity;
  final int index;
  const CartProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);

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
                  image: NetworkImage(product.img_path),
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
                  product.title,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  '${product.price}',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              controller.removeProduct(product);
              controller.decQuantity();
            },
            icon: Icon(Icons.remove_circle),
          ),
          Text(
            '$quantity',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              controller.addProduct(product);
              controller.incQuantity();
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}
