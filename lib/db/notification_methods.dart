import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:veterna_poultry/db/auth.dart';
import 'package:veterna_poultry/db/database_methods.dart';

class NotificationsMethod {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> updateFirebaseMessagingToken() async {
    await firebaseMessaging.requestPermission();
    await firebaseMessaging.getToken().then((value) {
      if (value != null) {
        DatabaseMethod()
            .firestore
            .collection("users")
            .doc(Auth().currentUser!.uid)
            .update({"fcm_token": value});
      }
    });
  }

  static Future<String?> getFirebaseMessagingTokenFromUser(
      String userId) async {
    String? fcmToken;
    await DatabaseMethod()
        .firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      fcmToken = value['fcm_token'];
    });
    return fcmToken;
  }

  static Future<void> setFirebaseMessagingToken(String string) async {
    DatabaseMethod()
        .firestore
        .collection("users")
        .doc(Auth().currentUser!.uid)
        .update({"fcm_token": string});
  }

  static Future<void> sendPushNotificationText(
      String? token, String? nameSender, String message) async {
    try {
      if (token != "" || token!.isNotEmpty) {
        final body = {
          "to": token,
          "notification": {"title": nameSender, "body": message}
        };

        var res = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  'key=AAAAIlKGraI:APA91bGc5jzsiGW_K4pmA4OAiTMnTuwS0onKkMlbL28Q5rnmvKM5DmWbyMM9hpiOBBThr3wnY80n2tkhu3J2Vsbf1DlrnTAiVsX3vU3QEktMbJ9HyGyXqYr04jlf6cKNhPEEWZakZbpR'
            },
            body: jsonEncode(body));

        developer.log('response status : ${res.statusCode}');
        developer.log('response body : ${res.body}');
      } else {
        developer.log('token null');
      }
    } catch (e) {
      developer.log("sendNotification: $e");
    }
  }

  static Future<void> sendPushNotificationImage(
      String? token, String? nameSender, String imagePath) async {
    try {
      if (token != "" || token!.isNotEmpty) {
        final body = {
          "to": token,
          "notification": {"title": nameSender, "image": imagePath}
        };

        var res = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  'key=AAAAIlKGraI:APA91bGc5jzsiGW_K4pmA4OAiTMnTuwS0onKkMlbL28Q5rnmvKM5DmWbyMM9hpiOBBThr3wnY80n2tkhu3J2Vsbf1DlrnTAiVsX3vU3QEktMbJ9HyGyXqYr04jlf6cKNhPEEWZakZbpR'
            },
            body: jsonEncode(body));

        developer.log('response status : ${res.statusCode}');
        developer.log('response body : ${res.body}');
      } else {
        developer.log('token null');
      }
    } catch (e) {
      developer.log("sendNotification: $e");
    }
  }
}
