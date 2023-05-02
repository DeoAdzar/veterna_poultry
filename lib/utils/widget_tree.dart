import 'package:flutter/material.dart';
import 'package:veterna_poultry/pages/navigation/nav_bar.dart';
import '../db/auth.dart';
import '../pages/login_page.dart';

//class widget tree ini buat ngecheck klo user udah pernah login atau belum di device itu

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        //ini fungsi check nya, klo dia ada data nya dia langsung masuk ke navbar (main menu), klo kosong datanya dia masuknya ke login page
        if (snapshot.hasData) {
          return const NavBar();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
