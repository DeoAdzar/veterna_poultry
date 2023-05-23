import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../db/auth.dart';
import '../db/database_methods.dart';
import '../utils/dimen.dart';
import '../utils/my_colors.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({Key? key}) : super(key: key);

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? conversationId;
  File? imageFile;
  late String? name, img;
  final String adminId = "dSlbzJm8fnQNyg07fLmSfHquuX83";
  int chatLength = 0;
  String chatRoomId(String user1) {
    return user1;
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();

    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future<void> _getUserName() async {
    DatabaseMethod()
        .firestore
        .collection('users')
        .doc(await Auth().currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        name = value['name'];
        img = value['img_path'] ?? '';
      });
    });
  }

  @override
  void initState() {
    _getUserName();
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      scrollMax();
    });
    super.initState();
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;

    await DatabaseMethod()
        .firestore
        .collection('chatroom')
        .doc(chatRoomId(Auth().currentUser!.uid))
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": Auth().currentUser!.uid,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref = FirebaseStorage.instance
        .ref()
        .child('chat/images')
        .child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await DatabaseMethod()
          .firestore
          .collection('chatroom')
          .doc(chatRoomId(Auth().currentUser!.uid))
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await DatabaseMethod()
          .firestore
          .collection('chatroom')
          .doc(chatRoomId(Auth().currentUser!.uid))
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": Auth().currentUser!.uid,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      if (conversationId != null) {
        Map<String, dynamic> update = {
          "lastMessage": _message.text,
          "time": FieldValue.serverTimestamp(),
        };
        updateConversation(update);
      } else {
        // getDataUser();
        Map<String, dynamic> add = {
          "lastMessage": _message.text,
          "senderId": Auth().currentUser!.uid,
          "receiverId": adminId,
          "senderName": name,
          "senderImage": img,
          "time": FieldValue.serverTimestamp(),
        };
        addConversation(add);
      }

      _message.clear();
      await DatabaseMethod()
          .firestore
          .collection('chatroom')
          .doc(chatRoomId(Auth().currentUser!.uid))
          .collection('chats')
          .add(messages);

      // scrollMax();
    }
  }

  void updateConversation(Map<String, dynamic> update) {
    DatabaseMethod()
        .firestore
        .collection("conversation")
        .doc(conversationId)
        .update(update);
  }

  void addConversation(Map<String, dynamic> add) {
    DatabaseMethod()
        .firestore
        .collection("conversation")
        .add(add)
        .then((value) => conversationId = value.id);
  }

  void checkConversationId(int lenght) {
    if (lenght != 0) {
      checkForConversationId(adminId, Auth().currentUser!.uid);
      checkForConversationId(Auth().currentUser!.uid, adminId);
    }
  }

  void checkForConversationId(String senderId, String receiverId) {
    DatabaseMethod()
        .firestore
        .collection("conversation")
        .where("senderId", isEqualTo: senderId)
        .where("receiverId", isEqualTo: receiverId)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        conversationId = value.docs[0].id;
      }
    });
  }

  void scrollMax() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (_scrollController.hasClients) {
        final position = _scrollController.position.maxScrollExtent;
        _scrollController.animateTo(
          position,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: Text(
          'Dr. Sulthan',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: StreamBuilder<QuerySnapshot>(
                  stream: DatabaseMethod()
                      .firestore
                      .collection('chatroom')
                      .doc(chatRoomId(Auth().currentUser!.uid))
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      checkConversationId(snapshot.data!.docs.length);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (chatLength != snapshot.data!.docs.length)
                            scrollMax();
                          chatLength = snapshot.data!.docs.length;
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return messages(Dimen(context).size, map, context);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 7,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimen(context).width * 0.03),
                          Expanded(
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              expands: true,
                              controller: _message,
                              decoration: const InputDecoration(
                                  hintText: "Message",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          IconButton(
                            onPressed: () => getImage(),
                            icon: const Icon(Icons.photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: Dimen(context).width * 0.03),
                  IconButton(
                      color: MyColors.mainColor,
                      icon: const Icon(Icons.send),
                      onPressed: onSendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == Auth().currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: map['sendby'] == Auth().currentUser!.uid
                    ? Colors.blue
                    : MyColors.greyColor,
              ),
              child: Column(
                crossAxisAlignment: map['sendby'] == Auth().currentUser!.uid
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  map['sendby'] == Auth().currentUser!.uid
                      ? Text(
                          map['message'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          map['message'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                  SizedBox(
                    height: Dimen(context).height * 0.004,
                  ),
                  map['sendby'] == Auth().currentUser!.uid
                      ? Text(
                          map['time'] != null ? readTimestamp(map['time']) : "",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          map['time'] != null ? readTimestamp(map['time']) : "",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
          )
        : Container(
            height: size.height * 0.45,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == Auth().currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: map['sendby'] == Auth().currentUser!.uid
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height / 2.5,
                    width: size.width / 2,
                    decoration: BoxDecoration(border: Border.all()),
                    alignment: map['message'] != "" ? null : Alignment.center,
                    child: map['message'] != ""
                        ? Image.network(
                            map['message'],
                            fit: BoxFit.cover,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: Dimen(context).height * 0.004,
                  ),
                  Text(
                    map['time'] != null ? readTimestamp(map['time']) : "",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MyColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Dimen(context).height,
        width: Dimen(context).width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
