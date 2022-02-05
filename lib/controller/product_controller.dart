import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  CarouselController controller = CarouselController();
  var activeIndex = 0.obs;
  var loading = false.obs;
  var ratingValue = 0.0.obs;
  GlobalKey<ScaffoldState> key =  GlobalKey<ScaffoldState>();
  var selected = 0.obs;
  var select_color = 0.obs;
  var select_size = 0.obs;
  var checked = true.obs;
  var ratingValue2 = 0.0.obs;
  var selected_sub_product = 0.obs;
  TextEditingController review_controller = TextEditingController();

  List<Color> colors = [
    Colors.blueGrey, Colors.red, Colors.blue, Colors.brown,].obs as List<Color>;

  List sizes = [
   "M","L","Xl","Xs"].obs ;

  List product_images = [
    "assets/home/flash_sale/1.png",
    "assets/home/flash_sale/1.png",
    "assets/home/flash_sale/1.png",
  ].obs;

  set_index(int selected){
    activeIndex.value=selected;
  }

}