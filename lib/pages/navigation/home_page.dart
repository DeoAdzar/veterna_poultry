import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/dimen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ini buat ambil data user yang udah login
  final List<String> _carouselImage = [];

  fetchCarouselImage() async {
    QuerySnapshot contentCollection =
        await FirebaseFirestore.instance.collection("content").get();
    if (mounted) {
      setState(() {
        for (var i = 0; i < contentCollection.docs.length; i++) {
          _carouselImage.add(contentCollection.docs[i]["path"]);
        }
      });
    }

    return contentCollection.docs;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    fetchCarouselImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  //ini manggil class dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.05,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Selamat Datang",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: const Image(
                        image: AssetImage('assets/thumbnail.png'),
                      )),
                ),
                SizedBox(
                  //ini manggil class Dimen biar jaraknya responsive
                  height: Dimen(context).height * 0.01,
                ),
                AspectRatio(
                  aspectRatio: 10 / 5,
                  child: CarouselSlider(
                      items: _carouselImage
                          .map((item) => Container(
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(
                                          item,
                                          fit: BoxFit.contain,
                                          width: Dimen(context).width,
                                        ),
                                      ],
                                    )),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
