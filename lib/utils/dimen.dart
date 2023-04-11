import 'package:flutter/cupertino.dart';

// class ini buat ambil dimensi layar hp biar layout nya responsive ke semua hp, jadi class ini dipanggil di semua layout
class dimen {
  BuildContext context;

  dimen(this.context) : assert(context != null);

  //bagian ini yang dipanggil nanti
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
