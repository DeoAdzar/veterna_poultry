import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:veterna_poultry/db/auth.dart';
import 'package:veterna_poultry/db/database_methods.dart';
import 'package:veterna_poultry/db/notification_methods.dart';
import 'package:veterna_poultry/utils/dimen.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/widgets/button_blue_radius_25.dart';
import 'package:veterna_poultry/widgets/input_text.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

import '../utils/currency_format.dart';
import '../utils/my_colors.dart';
import '../utils/validation_input.dart';
import '../widgets/custom_radio_button.dart';
import 'controller/product_controller.dart';

class CheckoutPaymentPage extends StatefulWidget {
  const CheckoutPaymentPage({super.key});

  @override
  State<CheckoutPaymentPage> createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  final TextEditingController _controllerName = TextEditingController();

  final TextEditingController _controllerPhone = TextEditingController();

  final TextEditingController _controllerAddress = TextEditingController();
  final ProductController controller = Get.find();

  List data = Get.arguments['data'];
  final String adminId = "dSlbzJm8fnQNyg07fLmSfHquuX83";
  String? fcmToken;

  void getFcmToken() async {
    fcmToken =
        await NotificationsMethod.getFirebaseMessagingTokenFromUser(adminId);
  }

  var totalPrice = Get.arguments['totalPriceAll'];
  File? imageFile;
  String? paymentMethod;
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() {
          paymentMethod = value!;
        });
  }

  @override
  void initState() {
    getFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: Text("Pesanan",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimen(context).height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: InputText(
                      controller: _controllerName,
                      text: "Nama Lengkap *",
                      textInputType: TextInputType.name,
                      height: 55,
                      verticalCenter: false),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: InputText(
                      controller: _controllerPhone,
                      text: "Nomor Telepon *",
                      textInputType: TextInputType.phone,
                      height: 55,
                      verticalCenter: false),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: InputText(
                      controller: _controllerAddress,
                      text: "Alamat *",
                      textInputType: TextInputType.streetAddress,
                      height: 55,
                      verticalCenter: false),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.04,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Detail Pesanan",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return itemProduct(
                              context,
                              data[index]['productTitle'],
                              data[index]['productQuantity'],
                              data[index]['productTotalPrice'],
                            );
                          }),
                      SizedBox(
                        height: Dimen(context).height * 0.02,
                      ),
                      Divider(
                        height: 5,
                        thickness: 4,
                        color: Colors.grey.shade500,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              CurrencyFormat.convertToIdr(totalPrice),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.03,
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Metode Pembayaran",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: Dimen(context).height * 0.02,
                      ),
                      MyRadioOption<String>(
                        value: '0',
                        groupValue: paymentMethod,
                        onChanged: _valueChangedHandler(),
                        label: '0',
                        text: 'Bayar Ditempat',
                      ),
                      MyRadioOption<String>(
                        value: '1',
                        groupValue: paymentMethod,
                        onChanged: _valueChangedHandler(),
                        label: '1',
                        text: 'Transfer',
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: paymentMethod == "1"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image(
                                            image:
                                                AssetImage('assets/bank.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimen(context).height * 0.02,
                                        ),
                                        Text("124123123",
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimen(context).height * 0.02,
                                    ),
                                    Container(
                                        //show captured image
                                        child: imageFile == null
                                            ? InkWell(
                                                onTap: () => takePicture(),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    //ini buat custom warnanya sama rounded nya button
                                                    color:
                                                        MyColors.bottomNavColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Column(
                                                    children: [
                                                      Text(
                                                          "Upload Bukti Transfer"),
                                                      Icon(Icons.photo_camera)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  takePicture();
                                                },
                                                child: Image.file(
                                                  File(imageFile!.path),
                                                  height: 300,
                                                ),
                                              )

                                        //display captured image
                                        )
                                  ],
                                )
                              : Container()),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.03,
                ),
                Container(
                  child: paymentMethod == null
                      ? Container()
                      : ButtonBlueRadius25(
                          text: "Pesan Sekarang",
                          onTap: () {
                            paymentMethod == "0"
                                ? sendRequest()
                                : imageFile != null
                                    ? sendRequest()
                                    : ShowSnackbar.snackBarError(
                                        "Ambil foto bukti transfer terlebih dahulu");
                          }),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemProduct(context, name, qty, price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.01,
                ),
                Text(
                  '${qty}x',
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimen(context).width * 0.02,
          ),
          Text(
            CurrencyFormat.convertToIdr(price),
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  bool validation() {
    return ValidationInput.validationInputNotEmpty(_controllerAddress.text) &&
        ValidationInput.validationInputNotEmpty(_controllerName.text) &&
        ValidationInput.validationInputNotEmpty(_controllerPhone.text) &&
        ValidationInput.isPhoneValid(_controllerPhone.text);
  }

  void showErrorSnackbar() {
    if (_controllerName.text.isEmpty) {
      ShowSnackbar.snackBarError('Name is required');
    } else if (_controllerPhone.text.isEmpty) {
      ShowSnackbar.snackBarError('Phone is required');
    } else if (!ValidationInput.isPhoneValid(_controllerPhone.text)) {
      ShowSnackbar.snackBarError('Please enter valid mobile number');
    } else if (_controllerAddress.text.isEmpty) {
      ShowSnackbar.snackBarError('Address is required');
    }
  }

  sendRequest() {
    if (validation()) {
      //ini buat manggil class yang diatas tadi buat login
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
      Get.offNamed(AppPages.ORDER);
    } else {
      showErrorSnackbar();
    }
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

  void sendToDB() async {
    String fileName = const Uuid().v1();
    String? imageUrl;
    var ref = FirebaseStorage.instance
        .ref()
        .child('order/images')
        .child("$fileName.jpg");
    if (imageFile != null) {
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
    }
    var sendData = {
      "customer": Auth().currentUser!.uid,
      "name": _controllerName.text,
      "phone": _controllerPhone.text,
      "address": _controllerAddress.text,
      "listProduct": data,
      "paymentMethod": paymentMethod,
      "totalPrice": totalPrice,
      "transferImage": imageUrl ?? "",
      "status": "pending",
      "time": FieldValue.serverTimestamp()
    };
    await DatabaseMethod()
        .firestore
        .collection('order')
        .add(sendData)
        .then((value) {
      String codeTransaction = value.id;
      DatabaseMethod()
          .firestore
          .collection('order')
          .doc(value.id)
          .update({"transactionCode": value.id});

      NotificationsMethod.sendPushNotificationText(
          fcmToken,
          "Pesanan dari ${_controllerName.text}",
          "Pesanan baru diterima dengan kode pemesanan '$codeTransaction'");
      controller.removeAll();
    });
  }
}
