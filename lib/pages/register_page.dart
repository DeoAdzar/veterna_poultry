import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/login_page.dart';
import 'package:veterna_poultry/pages/navigation/nav_bar.dart';
import 'package:veterna_poultry/widgets/input_text.dart';

import '../auth.dart';
import '../utils/dimen.dart';
import '../widgets/button_blue_radius_25.dart';
import '../widgets/input_text_password.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth()
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .then((value) {
        print("Created Account Success");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavBar()));
      }).onError((error, stackTrace) {
        print("error ${error.toString()}");
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Ups! ? $errorMessage');
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: dimen(context).height * 0.05,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Silahkan Daftar!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: dimen(context).height * 0.05,
                ),
                InputText(
                  controller: _controllerName,
                  text: "Nama Lengkap",
                  textInputType: TextInputType.name,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerEmail,
                  text: "Email",
                  textInputType: TextInputType.emailAddress,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerPhone,
                  text: "No Hp",
                  textInputType: TextInputType.phone,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                InputTextPassword(
                  controller: _controllerPassword,
                  text: "Buat Password",
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                InputTextPassword(
                  controller: _controllerConfirmPassword,
                  text: "Ulangi Password",
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerAddress,
                  text: "Alamat",
                  textInputType: TextInputType.streetAddress,
                  height: 100,
                  verticalCenter: true,
                ),
                SizedBox(
                  height: dimen(context).height * 0.04,
                ),
                ButtonBlueRadius25(
                  text: "Daftar",
                  onTap: () {
                    createUserWithEmailAndPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
