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

  // static const List<Product> products = [
  //   Product(
  //     title: 'barang 1',
  //     price: 20000,
  //     image_path: "https://picsum.photos/id/1/300/300",
  //   ),
  //   Product(
  //     title: 'barang 2',
  //     price: 12000,
  //     image_path: "https://picsum.photos/id/3/300/300",
  //   ),
  //   Product(
  //     title: 'barang 3',
  //     price: 10700,
  //     image_path: "https://picsum.photos/id/5/300/300",
  //   ),
  //   Product(
  //     title: 'barang 4',
  //     price: 14200,
  //     image_path: "https://picsum.photos/id/7/300/300",
  //   ),
  // ];
}
