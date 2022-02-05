import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/model/my_order.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/view/checkout.dart';
import 'package:zyo_version_1/view/no_internet.dart';

class CartController extends GetxController{
  // Rx<Order> order=Order(lineItems: <OrderLineItem>[]).obs;
  Rx<String> total="0.00".obs,sub_total="0.00".obs,shipping="10.00".obs,coupon="0.0".obs;
  var my_order = <MyOrder>[].obs;
  var rate = <MyOrder>[].obs;
  var loading = false.obs;
  TextEditingController code = TextEditingController();


  Apply_code(BuildContext context,String code){
    Api.check_internet().then((net) {
      if(net){
        loading.value=true;
        Api.Apply_dis_code(code).then((value) {
          loading.value=false;
          get_total();
          if(value==0){
            App.error_msg(context, "error_code");
          }else{
            App.sucss_msg(context, "succ_code");
          }
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          Apply_code(context,code);
        });
      }
    });

  }

  add_to_cart(Product product , int count){
    if(product.availability>0){
      for(int i=0;i<my_order.length;i++){
        if(my_order[i].product.value.id==product.id&&my_order[i].product.value.cart_details==product.cart_details){
          my_order[i].quantity.value = my_order[i].quantity.value + count;
          double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
          my_order[i].price.value = x.toString();
          get_total();
          return ;
        }
      }
      double x = (count * double.parse(product.price.toString())) as double;
      Product new_product = Product(bodtHtml: product.bodtHtml, id: product.id, subCategoryId: product.subCategoryId, title: product.title, subTitle: product.subTitle, description: product.description, image: product.image, search: product.search, availability: product.availability, price: product.price, ratingCount: product.ratingCount, rate: product.rate, commingSoon: product.commingSoon, likes: product.likes);
      new_product.cart_details=product.cart_details;
      MyOrder myOrder = MyOrder(product:new_product.obs,quantity:count.obs,price:x.toString().obs);
      my_order.add(myOrder);
      get_total();
    }

  }

  add_to_rate(Product product , int count){
    for(int i=0;i<rate.length;i++){
      if(rate[i].product.value.id==product.id){
        rate[i].quantity.value = rate[i].quantity.value + count;
        // double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
        rate[i].price.value = "0.0";
        get_total();
        return ;
      }
    }
    // double x = (count * double.parse(product.price.toString())) as double;
    MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:"0.0".obs);
    rate.add(myOrder);
  }

  clear_cart(){
    my_order.clear();
    get_total();
  }

  increase(MyOrder myOrder,index){
    // if(myOrder.product.value.availability>my_order[index].quantity.value){
      my_order[index].quantity.value++;
      double x =  (my_order[index].quantity.value * double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    // }

  }

  decrease(MyOrder myOrder,index){
    if(my_order[index].quantity.value>1){
      my_order[index].quantity.value--;
      double x =  (my_order[index].quantity.value *double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    }else{
      remove_from_cart(myOrder);
    }

  }
  remove_from_cart(MyOrder myOrder){
    my_order.removeAt(my_order.indexOf(myOrder));
    get_total();
  }

  get_total(){
    double x=0,y=0;
    for (var elm in my_order) {
      x += double.parse(elm.price.value);
      // y += double.parse(elm.shipping.value);
    }
    y = (x*(Global.dis_code))/100;
    coupon.value=y.toString();
    sub_total.value=x.toString();
    total.value = (x+double.parse(shipping.value.toString())-double.parse(coupon.value.toString())).toString();
    Store.save_order(my_order.value);
  }
}
