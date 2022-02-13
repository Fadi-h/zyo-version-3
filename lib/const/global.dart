import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:zyo_version_1/main.dart';
import 'package:zyo_version_1/model/customer.dart';
import 'package:zyo_version_1/model/address.dart';

class Global {

  static String language_code = "en";
  static List<String> suggestion_list = [];
  static MyCustomer? customer;
  static Address? address;
  static int dis_code=0;

  static String currency_code="AED";
  static double currency_covert=1.0;

  static Future<String> load_language() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lang=prefs.getString("language")??'def';
      if(lang!="def") {
        Global.language_code=lang;
      }
      else {
        Global.language_code="en";
      }
      Get.updateLocale(Locale(language_code));
      return Global.language_code;
    }
    catch(e) {
      return "en";
    }
  }
  static set_language(BuildContext context,String lang) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("language", lang);
      //print(lang);
      Global.language_code=lang;
      MyApp.set_locale(context, Locale(lang));
      Get.updateLocale(Locale(lang));
    });
  }

}