import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/widgets/button_grey_radius_20_icon.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

import '../../db/auth.dart';
import '../../utils/dimen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  Future<void> signOut(BuildContext context) async {
    await Auth().signOut(context: context);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () {
        signOut(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Konfirmasi"),
      content: const Text("Yakin anda ingin logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profil",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.CHANGE_PROFILE);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.all(18),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(180.0),
                        child: const Image(
                          image: AssetImage('assets/thumbnail.png'),
                        )),
                  ),
                ),
                SizedBox(
                  //ini manggil class dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.03,
                ),
                ButtonGreyIcon20(
                  onTap: () {
                    Get.toNamed(AppPages.CHANGE_PROFILE);
                  },
                  iconPrefix: "assets/user.svg",
                  text: "Ganti Profile",
                  iconSuffix: Icons.keyboard_arrow_right,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                ButtonGreyIcon20(
                  onTap: () {
                    Get.toNamed(AppPages.CHANGE_PASSWORD);
                  },
                  iconPrefix: "assets/lock.svg",
                  text: "Ganti Password",
                  iconSuffix: Icons.keyboard_arrow_right,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                ButtonGreyIcon20(
                  onTap: () {
                    ShowSnackbar.snackBarNormal("Riwayat");
                  },
                  iconPrefix: "assets/history.svg",
                  text: "Riwayat",
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                ButtonGreyIcon20(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  iconPrefix: "assets/exit.svg",
                  text: "Logout",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
