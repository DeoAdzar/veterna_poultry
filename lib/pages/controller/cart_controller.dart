import 'package:get/get.dart';
import 'package:veterna_poultry/db/database_methods.dart';
import 'package:veterna_poultry/pages/model/product_model.dart';

class CartController extends GetxController {
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(DatabaseMethod().getAllProduct());
    super.onInit();
  }
}
