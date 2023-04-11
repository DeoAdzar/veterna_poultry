import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veterna_poultry/auth.dart';
import 'package:veterna_poultry/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ini buat ambil data user yang udah login
  final User? user = Auth().currentUser;

  // ini buat manggil fungsi logout dari auth
  Future<void> signOut() async {
    await Auth().signOut().then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  //ini nampilkan userid dari account yang login, bakalan dipanggil di bawah
  Widget _userUid() {
    return Text(user?.uid ?? 'User Id');
  }

  // ini buat bikin widget signout sama manggil fungsi signout tadi
  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //widget yang di atas dipanggil disini
            _userUid(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
