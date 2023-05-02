import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterna_poultry/pages/model/product_model.dart';

CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");

class DatabaseMethod {
  Future addUserInfoToDB(String? user, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserFromDB(String? user) async {
    return userCollection.doc(user).get();
  }

  Stream<List<Product>> getAllProduct() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
