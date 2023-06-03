import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title;
  final int price;
  final String imgPath;

  const Product({
    required this.title,
    required this.price,
    required this.imgPath,
  });

  static Product fromSnapshot(QueryDocumentSnapshot snap) {
    Product product = Product(
      title: snap['title'],
      price: snap['price'],
      imgPath: snap['img_path'],
    );

    return product;
  }
}
