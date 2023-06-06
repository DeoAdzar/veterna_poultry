import 'package:get/get.dart';
import 'package:veterna_poultry/pages/model/product_model.dart';
import 'package:veterna_poultry/widgets/show_snackbar.dart';

class ProductController extends GetxController {
  final _products = {}.obs;
  var _quantity = 0.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      if (_products[product] <= 29) {
        _products[product] += 1;
        incQuantity();
      } else {
        ShowSnackbar.snackBarError("Item dalam maksimal pembelian");
      }
    } else {
      _products[product] = 1;
      incQuantity();
      ShowSnackbar.snackBarSuccess(
          "Berhasil menambahkan ${product.title} keranjang");
    }
  }

  get products => _products;

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
    decQuantity();
  }

  void removeAll() {
    _products.clear();
    _quantity = RxInt(0);
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
