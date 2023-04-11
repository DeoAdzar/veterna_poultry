import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/navigation/nav_bar.dart';

import '../utils/dimen.dart';
import '../widgets/button_blue_radius_25.dart';
import '../widgets/input_text_password.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
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
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Buat password baru",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: dimen(context).height * 0.05,
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
              height: dimen(context).height * 0.06,
            ),
            ButtonBlueRadius25(
              text: "Simpan Password",
              onTap: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => NavBar())),
            ),
          ],
        ),
      ),
    );
  }
}
