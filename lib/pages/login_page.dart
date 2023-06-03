import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../db/auth.dart';
import 'package:veterna_poultry/utils/dimen.dart';
import 'package:veterna_poultry/utils/my_colors.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/utils/validation_input.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';
import 'package:veterna_poultry/widgets/input_text.dart';
import 'package:veterna_poultry/widgets/input_text_password.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //ini buat bikin controller text nya
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  //ini buat manggil class yang ada di auth.dart buat login

  Future<void> signInWithEmailAndPassword() async {
    await Auth().signInWithEmailAndPassword(
        context: context,
        email: _controllerEmail.text,
        password: _controllerPassword.text);
  }

  bool validation(String email, String password) {
    return ValidationInput.validationInputNotEmpty(_controllerEmail.text) &&
        ValidationInput.validationInputNotEmpty(_controllerPassword.text) &&
        ValidationInput.isEmailValid(_controllerEmail.text);
  }

  void showErrorSnackbar(String email, String password) {
    if (email.isEmpty) {
      ShowSnackbar.snackBarError('Email is required');
    } else if (!ValidationInput.isEmailValid(email)) {
      ShowSnackbar.snackBarError('Must be a valid email address');
    } else if (password.isEmpty) {
      ShowSnackbar.snackBarError('Password is required');
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  //ini manggil class dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("VETERNA\nPOULTRY",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: MyColors.mainColor,
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.12,
                ),
                //ini class dari input_text.dart terus diisi parameternya
                InputText(
                  controller: _controllerEmail,
                  text: "Masukan Email",
                  textInputType: TextInputType.emailAddress,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                //ini class dari input_text_password.dart terus diisi parameternya
                InputTextPassword(
                  controller: _controllerPassword,
                  text: "Masukan Password",
                ),
                SizedBox(
                  height: Dimen(context).height * 0.07,
                ),
                //ini class dari button rounded
                ButtonBlueRadius25(
                  text: "Login",
                  onTap: () {
                    Get.closeCurrentSnackbar();
                    if (validation(
                        _controllerEmail.text, _controllerPassword.text)) {
                      //ini buat manggil class yang diatas tadi buat login
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
                      signInWithEmailAndPassword();
                    } else {
                      showErrorSnackbar(
                          _controllerEmail.text, _controllerPassword.text);
                    }
                    //on tap nya aku isi nampilin loading pake showDialog
                  },
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.FORGOT_PASSWORD);
                    },
                    child: Text(
                      'Lupa Password?',
                      style: GoogleFonts.inter(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum Punya Akun? ',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.REGISTER);
                      },
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
