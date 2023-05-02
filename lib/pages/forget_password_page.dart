import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/widgets/input_text.dart';

import '../db/auth.dart';
import '../utils/dimen.dart';
import '../utils/validation_input.dart';
import '../widgets/button_blue_radius_25.dart';
import '../widgets/show_snackbar.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _controllerEmail = TextEditingController();

  Future<void> resetPassword({required BuildContext context}) async {
    await Auth().resetPassword(
      context: context,
      email: _controllerEmail.text,
    );
  }

  bool validation(String email) {
    return ValidationInput.validationInputNotEmpty(_controllerEmail.text) &&
        ValidationInput.isEmailValid(_controllerEmail.text);
  }

  void showErrorSnackbar(String email) {
    if (email.isEmpty) {
      ShowSnackbar.snackBarError('Email is required');
    } else if (!ValidationInput.isEmailValid(email)) {
      ShowSnackbar.snackBarError('Must be a valid email address');
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimen(context).height * 0.1,
              ),
              Container(
                alignment: Alignment.center,
                child: Text("Lupa Password?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: Dimen(context).height * 0.06,
              ),
              Container(
                alignment: Alignment.center,
                child: Flexible(
                  child: Text(
                      "Hai, anda lupa password? Silahkan ketik Email yang telah anda daftarkan dan kami akan mengirimkan password baru anda.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: Dimen(context).height * 0.07,
              ),
              InputText(
                controller: _controllerEmail,
                text: "Email",
                textInputType: TextInputType.emailAddress,
                height: 55,
                verticalCenter: false,
              ),
              SizedBox(
                height: Dimen(context).height * 0.1,
              ),
              ButtonBlueRadius25(
                text: "Kirim",
                onTap: () {
                  if (validation(_controllerEmail.text)) {
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
                                  Text('Loading...'),
                                ],
                              ),
                            ),
                          );
                        });
                    resetPassword(context: context);
                  } else {
                    showErrorSnackbar(_controllerEmail.text);
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
