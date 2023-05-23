import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/utils/my_colors.dart';

import '../../pages/controller/product_controller.dart';
import '../../utils/pages.dart';

class CartBadges extends StatelessWidget {
  final ProductController controller = Get.find();
  CartBadges({Key? key}) : super(key: key);

  bool _showCartBadge() {
    if (controller.quantity.toString() == "0") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => Get.toNamed(AppPages.CART_PRODUCTS),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: -12),
            badgeAnimation: const badges.BadgeAnimation.slide(),
            showBadge: _showCartBadge(),
            badgeContent: Text(
              "${controller.quantity}",
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: MyColors.mainColor,
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
