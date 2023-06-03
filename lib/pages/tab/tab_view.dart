import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veterna_poultry/pages/tab/order_done.dart';
import 'package:veterna_poultry/pages/tab/order_pending.dart';
import 'package:veterna_poultry/pages/tab/order_process.dart';
import 'package:veterna_poultry/pages/tab/order_sent.dart';
import 'package:veterna_poultry/utils/pages.dart';

class TabViewPage extends StatelessWidget {
  const TabViewPage({super.key});
  Future<bool> onWillPop() {
    Get.offAllNamed(AppPages.HOME);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppPages.HOME),
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
        body: WillPopScope(
          onWillPop: () => onWillPop(),
          child: const Column(
            children: [
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 16),
                tabs: [
                  Tab(
                    text: "Permintaan",
                  ),
                  Tab(
                    text: "Diproses",
                  ),
                  Tab(
                    text: "Dikirim",
                  ),
                  Tab(
                    text: "Selesai",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OrderPending(),
                    OrderProcess(),
                    OrderSent(),
                    OrderDone()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
