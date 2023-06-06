import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:veterna_poultry/db/database_methods.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

import '../../db/auth.dart';
import '../../utils/dimen.dart';
import '../../widgets/input_text.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({Key? key}) : super(key: key);

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  String tempName = Get.arguments['profileName'],
      tempPhone = Get.arguments['profilePhone'],
      tempAddress = Get.arguments['profileAddress'],
      tempImage = Get.arguments['profileImage'];
  late final TextEditingController _controllerName;
  late final TextEditingController _controllerPhone;
  late final TextEditingController _controllerAddress;
  final User? user = Auth().currentUser;
  File? imageFile;

  @override
  void initState() {
    _controllerName = TextEditingController(text: tempName);
    _controllerPhone = TextEditingController(text: tempPhone);
    _controllerAddress = TextEditingController(text: tempAddress);
    super.initState();
  }

  takePicture() async {
    ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.camera, imageQuality: 25).then(
      (xFile) {
        if (xFile != null) {
          setState(() {
            imageFile = File(xFile.path);
          });
        }
      },
    );
  }

  Widget showData() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              takePicture();
            },
            child: Container(
              height: 125,
              width: 125,
              margin: const EdgeInsets.all(18),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(180.0),
                  child: imageFile != null
                      ? Image(fit: BoxFit.cover, image: FileImage(imageFile!))
                      : tempImage == ""
                          ? const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/thumbnail.png'),
                            )
                          : Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(tempImage))),
            ),
          ),
          SizedBox(
            //ini manggil class dimen biar jaraknya responsive
            height: Dimen(context).height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Lengkap",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerName,
                  text: "Nama Lengkap",
                  textInputType: TextInputType.name,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  "No. Handphone",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerPhone,
                  text: "No. Handphone",
                  textInputType: TextInputType.phone,
                  height: 55,
                  verticalCenter: false,
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.02,
                ),
                Text(
                  "Alamat",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                InputText(
                  controller: _controllerAddress,
                  text: "Alamat",
                  textInputType: TextInputType.streetAddress,
                  height: 100,
                  verticalCenter: true,
                ),
              ],
            ),
          ),
          SizedBox(
            //ini manggil class Dimen biar jaraknya responsive
            height: Dimen(context).height * 0.03,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ButtonBlueRadius25(
                text: "Simpan",
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return const Dialog(
                          // The background colordire
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // The loading indicator
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 15,
                                ),
                                // Some text
                                Text('Loading...')
                              ],
                            ),
                          ),
                        );
                      });
                  sendToDB();
                }),
          )
        ],
      ),
    );
  }

  void sendToDB() async {
    String fileName = const Uuid().v1();
    String? imageUrl;
    Map<String, dynamic> userInfoMap;
    var ref =
        FirebaseStorage.instance.ref().child('profile').child("$fileName.jpg");
    if (imageFile != null) {
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      userInfoMap = {
        "name": _controllerName.text,
        "phone": _controllerPhone.text,
        "address": _controllerAddress.text,
        "img_path": imageUrl,
      };
    } else {
      userInfoMap = {
        "name": _controllerName.text,
        "phone": _controllerPhone.text,
        "address": _controllerAddress.text,
      };
    }
    await DatabaseMethod()
        .firestore
        .collection("users")
        .doc(Auth().currentUser!.uid)
        .update(userInfoMap);
    Get.offAllNamed(AppPages.HOME);
    ShowSnackbar.snackBarSuccess("Berhasil update data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: Text(
          "Ganti Profil",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: showData()),
      ),
    );
  }
}
