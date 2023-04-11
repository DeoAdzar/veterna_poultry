import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/auth.dart';
import 'package:veterna_poultry/pages/navigation/nav_bar.dart';
import 'package:veterna_poultry/pages/forget_password_page.dart';
import 'package:veterna_poultry/pages/register_page.dart';
import 'package:veterna_poultry/utils/dimen.dart';
import 'package:veterna_poultry/utils/my_colors.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';
import 'package:veterna_poultry/widgets/input_text.dart';
import 'package:veterna_poultry/widgets/input_text_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  //ini buat bikin controller text nya
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  //ini buat manggil class yang ada di auth.dart buat login
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .then((value) {
        //ini kondisi kalo login sukses, dia bakal pindah ke NavBar(main menu)
        print("Login Success");
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  //ini manggil class dimen biar jaraknya responsive
                  height: dimen(context).height * 0.12,
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
                  height: dimen(context).height * 0.12,
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
                  height: dimen(context).height * 0.02,
                ),
                //ini class dari input_text_password.dart terus diisi parameternya
                InputTextPassword(
                  controller: _controllerPassword,
                  text: "Masukan Password",
                ),
                SizedBox(
                  height: dimen(context).height * 0.07,
                ),
                //ini class dari button rounded
                ButtonBlueRadius25(
                  text: "Login",
                  onTap: () {
                    //on tap nya aku isi nampilin loading pake showDialog
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
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
                    //ini buat manggil class yang diatas tadi buat login
                    signInWithEmailAndPassword();
                  },
                ),
                SizedBox(
                  height: dimen(context).height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgotPage())),
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
                  height: dimen(context).height * 0.08,
                ),
                Container(
                  child: Row(
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
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage())),
                        child: Text(
                          'Daftar',
                          style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
