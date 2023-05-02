import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:veterna_poultry/utils/routes.dart';
import 'package:veterna_poultry/utils/widget_tree.dart';

//di class ini ada fungsi buat initialize firebase sama widgetsflutter binding, klo misalkan initialize nya gagal dia bakalan nampilin crash berarti belum kehubung sama firebas

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      //ini buat ngarahin layout pertama yang ditampilin itu splashscreen
      home: const WidgetTree(),
    );
  }
}
