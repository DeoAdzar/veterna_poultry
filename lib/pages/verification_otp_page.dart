import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:veterna_poultry/pages/change_password_page.dart';
import 'package:veterna_poultry/pages/login_page.dart';
import 'package:veterna_poultry/utils/dimen.dart';

import '../widgets/button_blue_radius_25.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
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
                height: dimen(context).height * 0.20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text("OTP Verifikasi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: dimen(context).height * 0.07,
              ),
              Container(
                alignment: Alignment.center,
                child: Flexible(
                  child: Text(
                      "Masukkan kode verifikasi yang baru saja kami kirimkan ke alamat email anda",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: dimen(context).height * 0.07,
              ),
              SizedBox(
                width: dimen(context).height,
                child: Pinput(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  length: 3,
                  defaultPinTheme: PinTheme(
                    width: 50.0,
                    height: 50.0,
                    textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.5), width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: dimen(context).height * 0.08,
              ),
              ButtonBlueRadius25(
                text: "Verifikasi",
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage())),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
