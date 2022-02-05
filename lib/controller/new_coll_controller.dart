import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/model/categories.dart';
import 'package:zyo_version_1/model/product.dart';

class NewCollectionController extends GetxController {

  TextEditingController search_controller = TextEditingController();
  var select_category = 0.obs;
  var wishlist = false.obs;

  List<Category> categories = [
    Category(id: 1, title: "WOMAN",image: ""),
    Category(id: 2, title: "MEN", image: ""),
    Category(id: 3, title: "BAGS & ACCESSORIES",image: ""),
    Category(id: 4, title: "BEAUTY ESSENTIALS",image: ""),
  ];

  List<Product> products = <Product>[];
}