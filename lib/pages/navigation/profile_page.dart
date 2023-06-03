import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/widgets/button_grey_radius_20_icon.dart';

import '../../db/auth.dart';
import '../../db/database_methods.dart';
import '../../db/notification_methods.dart';
import '../../utils/dimen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? name, img, phone, address;

  Future<void> signOut(BuildContext context) async {
    await NotificationsMethod.setFirebaseMessagingToken("");
    // ignore: use_build_context_synchronously
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

  Future<void> _getUserName() async {
    await DatabaseMethod()
        .firestore
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        name = value['name'];
        img = value['img_path'] ?? '';
        phone = value['phone'] ?? '';
        address = value['address'] ?? '';
      });
    });
  }

  @override
  void initState() {
    _getUserName();
    super.initState();
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
              child: FutureBuilder(
                  future:
                      DatabaseMethod().getUserFromDB(Auth().currentUser!.uid),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppPages.CHANGE_PROFILE, arguments: {
                                "profileName": snapshot.data?['name'],
                                "profileAddress": snapshot.data?['address'],
                                "profileImage":
                                    snapshot.data?['img_path'] ?? "",
                                "profilePhone": snapshot.data?['phone'],
                              });
                            },
                            child: Container(
                              height: 125,
                              width: 125,
                              margin: const EdgeInsets.all(18),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(180.0),
                                  child: snapshot.data?['img_path'] == null ||
                                          snapshot.data?['img_path'] == ''
                                      ? const Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/thumbnail.png'),
                                        )
                                      : Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              snapshot.data?['img_path']))),
                            ),
                          ),
                          SizedBox(
                            //ini manggil class dimen biar jaraknya responsive
                            height: Dimen(context).height * 0.03,
                          ),
                          ButtonGreyIcon20(
                            onTap: () {
                              Get.toNamed(AppPages.CHANGE_PROFILE, arguments: {
                                "profileName": snapshot.data?['name'],
                                "profileAddress": snapshot.data?['address'],
                                "profileImage": snapshot.data?['img_path'],
                                "profilePhone": snapshot.data?['phone'],
                              });
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
                              Get.toNamed(AppPages.ORDER);
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
                      );
                    } else {
                      return Container();
                    }
                  })),
        ),
      ),
    );
  }
}
