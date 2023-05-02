import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/controller/product_controller.dart';
import 'package:veterna_poultry/utils/dimen.dart';
import 'package:veterna_poultry/utils/my_colors.dart';
import 'package:veterna_poultry/widgets/button_white_radius_25.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

class CartTotalPage extends StatelessWidget {
  final ProductController controller = Get.find();
  CartTotalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Dimen(context).width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MyColors.mainColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            children: [
              Icon(
                Icons.maximize_rounded,
                color: Colors.grey,
                size: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jumlah Item",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${controller.quantity} Item",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: Dimen(context).height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Pesanan",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Rp.${controller.total}",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: Dimen(context).height * 0.02,
              ),
              ButtonWhiteRadius25(
                  text: "Pesan Sekarang",
                  onTap: () {
                    if (controller.quantity.toString() == "0") {
                      ShowSnackbar.snackBarError(
                          "Mohon tambahkan setidaknya 1 barang");
                    } else {
                      ShowSnackbar.snackBarSuccess("Goto Checkout");
                    }
                  })
            ],
          ),
        ));
  }
}
