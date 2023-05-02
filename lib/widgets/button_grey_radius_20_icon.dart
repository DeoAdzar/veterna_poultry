import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/my_colors.dart';

class ButtonGreyIcon20 extends StatelessWidget {
  const ButtonGreyIcon20({
    Key? key,
    required this.onTap,
    required this.iconPrefix,
    required this.text,
    this.iconSuffix,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String iconPrefix;
  final IconData? iconSuffix;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: 55,
      decoration: BoxDecoration(
        //ini buat custom warnanya sama rounded nya button
        color: MyColors.bottomNavColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
            leading: SvgPicture.asset(
              iconPrefix,
              width: 25,
              height: 25,
              allowDrawingOutsideViewBox: true,
            ),
            title: Text(
              //ini buat naruh text dari parameter
              text,
              style: GoogleFonts.inter(
                  color: MyColors.textSecondaryColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            trailing: Icon(
              iconSuffix,
              size: 30,
            )),
      ),
    );
  }
}
