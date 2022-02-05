import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/controller/cart_controller.dart';
import 'package:zyo_version_1/controller/wishlist_controller.dart';
import 'package:zyo_version_1/model/home_page.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/model/sub_categories.dart';
import 'package:zyo_version_1/view/home.dart';
import 'package:zyo_version_1/view/no_internet.dart';
import 'package:zyo_version_1/view/registation.dart';
import 'package:zyo_version_1/view/verification_code.dart';

class IntroController extends GetxController {
  HomePage homePage=HomePage( category: <Category>[], slider: <MySlider>[], comingSoon: <ComingSoon>[],flashSale: <FlashSale>[],home_page_products: <Product>[],new_products: <Product>[]);
  WishListController wishlistController = Get.put(WishListController());
  CartController cartController = Get.put(CartController());
  List<SubCategory> subCategory = <SubCategory>[];
  List<Product> products = <Product>[];
  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
  }

  get_data(){
    Store.load_dic_code();
    Store.load_currency();

    Api.check_internet().then((internet) {
      if(internet){
        Store.load_order().then((value) {
          cartController.my_order.value=value;
          cartController.get_total();
        });
        Store.load_address();
        if(Global.currency_code!="AED"){
          Api.get_dollar().then((value) {
            Global.currency_covert=value;
            print('Global.currency_covert');
            print(Global.currency_covert);
          });
        }

        Store.load_wishlist().then((wishlist) {
          wishlistController.wishlist.value=wishlist;
          Api.get_home_page().then((homePageResult) {
            homePage=homePageResult;
            Api.get_sub_category(homePage.category.first.id).then((sub_c) {
              subCategory=sub_c.subCategory;
              // print(subCategory.length);
              Api.getProducts(wishlist,subCategory.first.id).then((value) {
                products=value;
                Future.delayed(Duration(milliseconds: 2500)).then((value) {
                  get_page();
                });

              });

            });

          });

        });

      }else{
            Get.to(NoInternet())!.then((value) {
              get_data();
            });
      }
    });

  }

  get_page(){
    Store.loadLogInInfo().then((info) {
      if(info.email=="non"){
        Get.offAll(()=>Registration());
      }else{
        Store.load_verificat().then((verify){
          if(verify){
            Api.check_internet().then((internet) {
              if(internet){
                Api.login(info.email,info.pass).then((value) {
                  print(value.message);
                  if(value.state==200){
                    Get.offAll(()=>Home());
                  }else{
                    Get.offAll(()=>Registration());
                  }

                });

              }else{
                Get.to(()=>NoInternet())!.then((value) {
                  get_page();
                });
              }
            });

          }else{
            Get.offAll(VerificatioCode());
          }
        });
      }
    });
  }




}