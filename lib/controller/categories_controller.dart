import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/model/categories.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/model/sub_categories.dart';

class CategoriesController extends GetxController {

  TextEditingController search_controller = TextEditingController();
  CarouselController controller = CarouselController();
  var select_category = 0.obs;
  var select_sub_category = 0.obs;


  List<SubCategory> sub_categories = [];

  List<Category> categories = [
    Category(id: 1, title: "WOMAN",image: ""),
    Category(id: 2, title: "MEN", image: ""),
    Category(id: 3, title: "BAGS & ACCESSORIES",image: ""),
    Category(id: 4, title: "BEAUTY ESSENTIALS",image: ""),
  ];

  List<Product> products = <Product>[];
}