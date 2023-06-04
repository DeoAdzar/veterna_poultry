import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/db/auth.dart';
import 'package:veterna_poultry/widgets/input_text_password.dart';

import '../../db/notification_methods.dart';
import '../../utils/dimen.dart';
import '../../widgets/button_blue_radius_25.dart';
import '../../widgets/show_snackbar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordOld = TextEditingController();
  final TextEditingController _passwordNew = TextEditingController();
  final TextEditingController _passwordRepeat = TextEditingController();

  validation(BuildContext context) async {
    if (_passwordOld.text.isEmpty) {
      ShowSnackbar.snackBarError('Old Password is required');
    } else if (_passwordNew.text.isEmpty) {
      ShowSnackbar.snackBarError('New Password is required');
    } else if (_passwordRepeat.text.isEmpty) {
      ShowSnackbar.snackBarError('Repeat Password is required');
    } else {
      try {
        final user = Auth().currentUser;
        final credential = EmailAuthProvider.credential(
            email: Auth().currentUser!.email.toString(),
            password: _passwordOld.text);
        await user!.reauthenticateWithCredential(credential);
        if (_passwordRepeat.text == _passwordNew.text) {
          try {
            await Auth().currentUser!.updatePassword(_passwordNew.text);
            await NotificationsMethod.setFirebaseMessagingToken("");
            // ignore: use_build_context_synchronously
            await Auth().signOut(
                context: context,
                message: 'Change Password Successfully, Please re-login');
          } on FirebaseAuthException catch (e) {
            ShowSnackbar.snackBarError(e.toString());
          }
        } else {
          Get.back();
          ShowSnackbar.snackBarError("New Password doesn\'t match");
        }
      } on FirebaseAuthException catch (e) {
        Get.back();
        _passwordOld.clear();
        ShowSnackbar.snackBarError(e.message.toString());
      }
    }
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
          "Ganti Kata Sandi",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kata Sandi Lama",
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      //ini manggil class Dimen biar jaraknya responsive
                      height: Dimen(context).height * 0.01,
                    ),
                    InputTextPassword(
                      controller: _passwordOld,
                      text: "Kata Sandi Lama",
                    ),
                    SizedBox(
                      //ini manggil class Dimen biar jaraknya responsive
                      height: Dimen(context).height * 0.02,
                    ),
                    Text(
                      "Kata Sandi Baru",
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      //ini manggil class Dimen biar jaraknya responsive
                      height: Dimen(context).height * 0.01,
                    ),
                    InputTextPassword(
                      controller: _passwordNew,
                      text: "Kata Sandi Baru",
                    ),
                    SizedBox(
                      //ini manggil class Dimen biar jaraknya responsive
                      height: Dimen(context).height * 0.02,
                    ),
                    Text(
                      "Ulangi Sandi Baru",
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      //ini manggil class Dimen biar jaraknya responsive
                      height: Dimen(context).height * 0.01,
                    ),
                    InputTextPassword(
                      controller: _passwordRepeat,
                      text: "Ulangi Sandi Baru",
                    ),
                  ],
                ),
              ),
              SizedBox(
                //ini manggil class Dimen biar jaraknya responsive
                height: Dimen(context).height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: ButtonBlueRadius25(
                    text: "Simpan",
                    onTap: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return const Dialog(
                              // The background colordire
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // The loading indicator
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Some text
                                    Text('Loading...')
                                  ],
                                ),
                              ),
                            );
                          });
                      validation(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
