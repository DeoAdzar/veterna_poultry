import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/navigation/home_page.dart';
import 'package:veterna_poultry/utils/my_colors.dart';
import 'package:veterna_poultry/widget_tree.dart';

//class ini buat nampilin splashscreen page diawal aja habis itu dia pindah ke class widget tree

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    super.initState();
    //ini fungsi biar dia ke fungsi widget tree
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WidgetTree())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyColors.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("VETERNA\nPOULTRY",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
