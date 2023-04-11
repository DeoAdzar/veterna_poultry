import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veterna_poultry/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

//di class ini ada fungsi buat initialize firebase sama widgetsflutter binding, klo misalkan initialize nya gagal dia bakalan nampilin crash berarti belum kehubung sama firebas

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //ini buat ngarahin layout pertama yang ditampilin itu splashscreen
      home: SplahScreen(),
    );
  }
}
