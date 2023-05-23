import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//class ini buat bikin button biru yang punya rounded, ada parameter nya buat fungsi onTap sama ngasih nama button nya

class ButtonWhiteRadius25 extends StatelessWidget {
  const ButtonWhiteRadius25({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      child: InkWell(
        //fungsi on tap nya di parsing dari parameter
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 55,
          decoration: BoxDecoration(
              //ini buat custom warnanya sama rounded nya button
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ]),
          child: Text(
            //ini buat naruh text dari parameter
            text,
            style: GoogleFonts.inter(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
