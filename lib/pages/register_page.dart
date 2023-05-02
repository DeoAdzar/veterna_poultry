import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/widgets/input_text.dart';

import '../db/auth.dart';
import '../utils/dimen.dart';
import '../utils/validation_input.dart';
import '../widgets/button_blue_radius_25.dart';
import '../widgets/input_text_password.dart';
import '../widgets/show_snackbar.dart';

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
    await Auth().createUserWithEmailAndPassword(
      context: context,
      address: _controllerAddress.text,
      phone: _controllerPhone.text,
      email: _controllerEmail.text,
      password: _controllerConfirmPassword.text,
      name: _controllerName.text,
    );
  }

  bool validation() {
    return ValidationInput.validationInputNotEmpty(_controllerEmail.text) &&
        ValidationInput.validationInputNotEmpty(_controllerPassword.text) &&
        ValidationInput.validationInputNotEmpty(
            _controllerConfirmPassword.text) &&
        ValidationInput.validationInputNotEmpty(_controllerAddress.text) &&
        ValidationInput.validationInputNotEmpty(_controllerName.text) &&
        ValidationInput.validationInputNotEmpty(_controllerPhone.text) &&
        ValidationInput.isConfirmPasswordMatch(
            _controllerPassword.text, _controllerConfirmPassword.text) &&
        ValidationInput.isPhoneValid(_controllerPhone.text) &&
        ValidationInput.isEmailValid(_controllerEmail.text);
  }

  void showErrorSnackbar() {
    if (_controllerName.text.isEmpty) {
      ShowSnackbar.snackBarError('Name is required');
    } else if (_controllerEmail.text.isEmpty) {
      ShowSnackbar.snackBarError('Email is required');
    } else if (!ValidationInput.isEmailValid(_controllerEmail.text)) {
      ShowSnackbar.snackBarError('Must be a valid email address');
    } else if (_controllerPhone.text.isEmpty) {
      ShowSnackbar.snackBarError('Phone is required');
    } else if (!ValidationInput.isPhoneValid(_controllerPhone.text)) {
      ShowSnackbar.snackBarError('Please enter valid mobile number');
    } else if (_controllerPassword.text.isEmpty) {
      ShowSnackbar.snackBarError('Password is required');
    } else if (_controllerConfirmPassword.text.isEmpty) {
      ShowSnackbar.snackBarError('Confirm Password is required');
    } else if (_controllerAddress.text.isEmpty) {
      ShowSnackbar.snackBarError('Address is required');
    } else if (!ValidationInput.isConfirmPasswordMatch(
        _controllerPassword.text, _controllerConfirmPassword.text)) {
      ShowSnackbar.snackBarError('Confirm Password doesn\'t match');
    }
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
                  height: Dimen(context).height * 0.05,
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
                  height: Dimen(context).height * 0.05,
                ),
                InputText(
                  controller: _controllerName,
                  text: "Nama Lengkap",
                  textInputType: TextInputType.name,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerEmail,
                  text: "Email",
                  textInputType: TextInputType.emailAddress,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerPhone,
                  text: "No Hp",
                  textInputType: TextInputType.phone,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                InputTextPassword(
                  controller: _controllerPassword,
                  text: "Buat Password",
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                InputTextPassword(
                  controller: _controllerConfirmPassword,
                  text: "Ulangi Password",
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                InputText(
                  controller: _controllerAddress,
                  text: "Alamat",
                  textInputType: TextInputType.streetAddress,
                  height: 100,
                  verticalCenter: true,
                ),
                SizedBox(
                  height: Dimen(context).height * 0.04,
                ),
                ButtonBlueRadius25(
                  text: "Daftar",
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (validation()) {
                      //ini buat manggil class yang diatas tadi buat login
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              // The background colordire
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                      createUserWithEmailAndPassword();
                    } else {
                      showErrorSnackbar();
                    }
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
