import 'package:get/get.dart';
import 'package:zyo_version_1/model/product.dart';

class SubCategoryController extends GetxController {

  int Selected = 0;
  var wishlist = true.obs;
  var select_color = 0.obs;

  List<Product> products = <Product>[];

}