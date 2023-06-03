import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/utils/my_colors.dart';

//class ini fungsinya buat inputText text yang biasa, jadi bisa digunain buat email, nama, nohp, dsb
//ada parameternya controller, text, textinputtype, height, vertical center

class InputTextFill extends StatelessWidget {
  const InputTextFill(
      {Key? key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.height,
      required this.verticalCenter,
      this.validator})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  final double height;
  final bool verticalCenter;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;

  TextAlignVertical textVertical() {
    return verticalCenter ? TextAlignVertical.center : TextAlignVertical.top;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //parameternya nnti di masukin ke fungsi" nya
      height: height,
      padding: const EdgeInsets.only(top: 3, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: MyColors.mainColor.withOpacity(0.2), blurRadius: 7)
          ]),
      child: TextFormField(
        validator: validator,
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: textVertical(),
        keyboardType: textInputType,
        style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: MyColors.textColor),
        decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(height: 1)),
      ),
    );
  }
}
