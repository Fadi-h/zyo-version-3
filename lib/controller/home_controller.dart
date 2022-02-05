import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/controller/introduction_controller.dart';
import 'package:zyo_version_1/controller/wishlist_controller.dart';
import 'package:zyo_version_1/model/4th_sub_category.dart';
import 'package:zyo_version_1/model/home_page.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/model/sub_categories.dart';
import 'package:zyo_version_1/view/no_internet.dart';
import 'package:zyo_version_1/view/product.dart';
import 'package:zyo_version_1/view/sub_category.dart';

class HomeController extends GetxController {


  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  CarouselController controller = CarouselController();
  IntroController introController = Get.find();
  WishListController wishlistController = Get.find();
  RxList<SubCategory> subCategory = <SubCategory>[].obs;
  RxList<Product> products = <Product>[].obs;
  List<FourthSubCategory> forthSubCategory = <FourthSubCategory>[];
  HomePage homePage=HomePage( category: <Category>[], slider: <MySlider>[], comingSoon: <ComingSoon>[],flashSale: <FlashSale>[],home_page_products: <Product>[],new_products: <Product>[]);
  var select_nav_bar = 0.obs;
  var last_select_nav_bar = 0.obs;
  var loading = false.obs;
  Rx<int> select_category = 0.obs;
  Rx<int> select_sub_category = 0.obs;
  Rx<int> slider_value = 0.obs;
  var sub_category_value = 0.0.obs;
  var wishlistIcon = true.obs;
  int Selected = 0;
  var selectedFourthSubCategory = 0.obs;
  @override
  Future<void> onInit() async {
    get_data();
    super.onInit();

  }

  get_data(){
    homePage=introController.homePage;
    subCategory.value=introController.subCategory;
    products.value=introController.products;
    get_fourth(introController.subCategory);
  }

  get_fourth(List<SubCategory> list){
    forthSubCategory.clear();
    if(list.isNotEmpty)
    for(int i=0;i<list.length+3;i+=4){
      SubCategory? first=null;
      SubCategory? second=null;
      SubCategory? third=null;
      SubCategory? fourth=null;
      if(list.length>i){
        first=list[i];
      }
      if(list.length>i+1){
        second=list[i+1];
      }
      if(list.length>i+2){
        third=list[i+2];
      }
      if(list.length>i+3){
        fourth=list[i+3];
      }
      if(first!=null)
      forthSubCategory.add(FourthSubCategory(first, second, third, fourth));
    }
    loading.value=false;
  }

  get_sub_category(int index){
    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.get_sub_category(homePage.category[index].id).then((value) {
          subCategory.value=value.subCategory;
          get_fourth(value.subCategory);

        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category(index);
        });
      }
    });

  }

  get_sub_category_and_product(int index){

    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.get_sub_category(homePage.category[index].id).then((value) {
          subCategory.value=value.subCategory;
          if(value.subCategory.isNotEmpty){
            Api.getProducts(wishlistController.wishlist, subCategory.value.first.id).then((value) {
              products.value=value;
              loading.value=false;
            });
          }else{
            products.value.clear();
            loading.value=false;
          }
          // get_fourth(value.subCategory);

        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category_and_product(index);
        });
      }
    });


  }

  get_product_by_sub_category(int index){
    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.getProducts(wishlistController.wishlist,subCategory.value[index].id).then((value) {
          products.value=value;
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_product_by_sub_category(index);
        });
      }
    });

  }

  go_to_product_page(int id){
    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.get_product_info(id).then((value) {
          Get.to(()=>ProductInfo(value!));
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          go_to_product_page(id);
        });
      }
    });

  }

  go_to_sub_category_page(SubCategory subCategory){
    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.getProducts(wishlistController.wishlist,subCategory.id).then((value) {
          Get.to(()=>SubCategoryView(subCategory.title,value.obs));
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          go_to_sub_category_page(subCategory);
        });
      }
    });

  }
  go_to_search_page(String query){
    Api.check_internet().then((net) {
      if(net){
        //loading.value=true;
        Api.getProductsSearch(wishlistController.wishlist,query).then((value) {
          Get.to(()=>SubCategoryView(query,value.obs));
          // loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          go_to_search_page(query);
        });
      }
    });

  }
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Double tap to exit");
      // select_nav_bar.value=last_select_nav_bar.value;
      return Future.value(false);
    }
    return Future.value(true);
  }

  go_to_search_page_with_loading(String query){

    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.getProductsSearch(wishlistController.wishlist,query).then((value) {
          Get.to(()=>SubCategoryView(query,value.obs));
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          go_to_search_page_with_loading(query);
        });
      }
    });


  }

  set_index(int selected){
    selectedFourthSubCategory.value=selected;
  }

  set_nav_bar(int select) {
    select_nav_bar.value=select;
  }


}