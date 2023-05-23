import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/utils/dimen.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                      "Jika ada keluhan pada hewan ternak anda, anda dapat konsultasikan kepada Dr. Sulthan dengan menekan Mulai konsultasi dibawah ini",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal)),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.07,
                ),
                ButtonBlueRadius25(
                  text: "Mulai Konsultasi",
                  onTap: () {
                    Get.toNamed(AppPages.CHAT_ROOM);
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
