import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title;
  final int price;
  final String img_path;

  const Product({
    required this.title,
    required this.price,
    required this.img_path,
  });

  static Product fromSnapshot(QueryDocumentSnapshot snap) {
    Product product = Product(
      title: snap['title'],
      price: snap['price'],
      img_path: snap['img_path'],
    );

    return product;
  }
}
