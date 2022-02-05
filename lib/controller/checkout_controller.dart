import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/model/address.dart';
import 'package:zyo_version_1/view/order_confirmed.dart';

class CheckoutController extends GetxController {

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  String country="United Arab Emirates";
  String country_code="+971";
  String phone_init= "AE";
  String phone_code="+971";
  var validate = false.obs;
  var isSwitched = false.obs;


  @override
  void onInit() {
    if(Global.address!=null){
      phone.text=Global.address!.phone;
      state.text=Global.address!.state;
      city.text=Global.address!.city;
      address1.text=Global.address!.address1;
      address2.text=Global.address!.address2;
      country=Global.address!.country;
      country_code=Global.address!.country_code;
      phone_init=Global.address!.phone_init;
      phone_code=Global.address!.phone_code;
    }
    super.onInit();
  }

  save(BuildContext context) {
    Store.save_address(Address(city: city.text, state: state.text, address1: address1.text, address2: address2.text, country: country, phone: phone.text,country_code: country_code,phone_code: phone_code,phone_init: phone_init));
    App.sucss_msg(context, App_Localization.of(context)!.translate("address_saved"));
    Get.back();
    Get.back();
  }

}