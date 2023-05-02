import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';

import '../../db/auth.dart';
import '../../db/database_methods.dart';
import '../../utils/dimen.dart';
import '../../utils/pages.dart';
import '../../widgets/button_grey_radius_20_icon.dart';
import '../../widgets/input_text.dart';
import '../../widgets/show_snackbar.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({Key? key}) : super(key: key);

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  late String tempName, tempPhone, tempAddress;

  final User? user = Auth().currentUser;

  Widget getDataUser() {
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseMethod().getUserFromDB(user?.uid),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return ShowSnackbar.snackBarError("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return ShowSnackbar.snackBarError("User not found");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          tempName = data['name'];
          tempPhone = data['phone'];
          tempAddress = data['address'];
          return Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Lengkap",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerName,
                  text: data['name'],
                  textInputType: TextInputType.name,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  "No. Handphone",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerPhone,
                  text: data['phone'],
                  textInputType: TextInputType.phone,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  "Alamat",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerAddress,
                  text: data['address'],
                  textInputType: TextInputType.streetAddress,
                  height: 100,
                  verticalCenter: true,
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: Text(
          "Ganti Profil",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.normal),
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
                  onTap: () {},
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
                  height: Dimen(context).height * 0.05,
                ),
                getDataUser(),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.06,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: ButtonBlueRadius25(text: "Simpan", onTap: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
