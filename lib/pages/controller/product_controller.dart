import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veterna_poultry/db/database_methods.dart';
import 'package:veterna_poultry/pages/model/product_model.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

import 'cart_controller.dart';

class ProductController extends GetxController {
  final _products = {}.obs;
  var _quantity = 0.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
  }

  get products => _products;

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get quantity => _quantity;

  get productSubTotal => _products.entries
      .map((product) => product.key.price * (product.value))
      .toList();

  get total {
    int total = productSubTotal.fold(
        0, (previousValue, element) => previousValue + element);
    return total;
  }

  void incQuantity() {
    _quantity += 1;
  }

  void decQuantity() {
    if (_quantity > 0) {
      _quantity -= 1;
    }
  }
}
