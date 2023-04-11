import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/verification_otp_page.dart';
import 'package:veterna_poultry/widgets/input_text.dart';

import '../utils/dimen.dart';
import '../widgets/button_blue_radius_25.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({Key? key}) : super(key: key);
  final TextEditingController _controllerEmail = TextEditingController();

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
                height: dimen(context).height * 0.1,
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
                height: dimen(context).height * 0.06,
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
                height: dimen(context).height * 0.07,
              ),
              InputText(
                controller: _controllerEmail,
                text: "Email",
                textInputType: TextInputType.emailAddress,
                height: 55,
                verticalCenter: false,
              ),
              SizedBox(
                height: dimen(context).height * 0.1,
              ),
              ButtonBlueRadius25(
                text: "Kirim",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificationPage())),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
