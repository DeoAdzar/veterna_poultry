import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:veterna_poultry/db/auth.dart';

import '../../db/database_methods.dart';
import '../../utils/dimen.dart';
import '../../utils/my_colors.dart';

class OrderPending extends StatelessWidget {
  const OrderPending({super.key});
  String readTimestamp(Timestamp timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm');
    var date = DateTime.parse(timestamp.toDate().toString());
    var diff = now.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} day ago';
      } else {
        time = '${diff.inDays} days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} week ago';
      } else {
        time = '${(diff.inDays / 7).floor()} weeks ago';
      }
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: DatabaseMethod()
              .firestore
              .collection('order')
              .where("customer", isEqualTo: Auth().currentUser!.uid)
              .where("status", isEqualTo: "pending")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return item(snapshot.data!.docs[index].id, map, context);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget item(String id, Map<String, dynamic> map, BuildContext context) {
    List data = map['listProduct'];
    return InkWell(
      onTap: () {},
      child: Container(
        width: Dimen(context).width,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            //ini buat custom warnanya sama rounded nya button
            color: MyColors.cardHomeMessage,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 2)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(data[0]['productImage']),
                  )),
            ),
            SizedBox(
              width: Dimen(context).width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data[0]['productTitle']}',
                    maxLines: 2,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: data.length > 1
                        ? Text(
                            "dan ${data.length - 1} lainnya ..",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal),
                          )
                        : Text(
                            "",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal),
                          ),
                  ),
                  SizedBox(
                    height: Dimen(context).height * 0.02,
                  ),
                  Text(
                    map['time'] != null ? readTimestamp(map['time']) : "",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '#${map['transactionCode']}',
                  style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: Dimen(context).height * 0.08,
                ),
                Text(
                  'menunggu konfirmasi',
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
