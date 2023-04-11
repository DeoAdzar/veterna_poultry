import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/my_colors.dart';

//class ini buat bikin input text buat password aja, soalnya dia pake stateful yang bikin ada show hide passwordnya
//ada parameternya juga, text sama controller, controller fungsinya buat ngambil isi text nya nnti

class InputTextPassword extends StatefulWidget {
  const InputTextPassword(
      {Key? key, required this.controller, required this.text})
      : super(key: key);
  // ini buat ngasih parameter
  final TextEditingController controller;
  final String text;
  @override
  State<InputTextPassword> createState() =>
      _InputTextPasswordState(controller, text);
}

class _InputTextPasswordState extends State<InputTextPassword> {
  final TextEditingController controller;
  final String text;
  final textFieldFocusNode = FocusNode();

  _InputTextPasswordState(this.controller, this.text);
  bool _obscureText = true;
  //fungsi ini buat focus, jadi kalo input text nya di klik icon hide show nya ikut focus
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        padding: const EdgeInsets.only(top: 3, left: 15, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: MyColors.mainColor.withOpacity(0.2), blurRadius: 7)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              focusNode: textFieldFocusNode,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: MyColors.textColor),
              decoration: InputDecoration(
                  hintText: text,
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    // ini buat fungsi click hideshow nya password
                    child: GestureDetector(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                  hintStyle: TextStyle(height: 1)),
            ),
          ],
        ));
  }
}
