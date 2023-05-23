import 'package:flutter/cupertino.dart';

// class ini buat ambil dimensi layar hp biar layout nya responsive ke semua hp, jadi class ini dipanggil di semua layout
class Dimen {
  BuildContext context;

  Dimen(this.context);

  //bagian ini yang dipanggil nanti
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  Size get size => MediaQuery.of(context).size;
}
