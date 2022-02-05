import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/model/address.dart';
import 'package:zyo_version_1/model/login_info.dart';
import 'package:zyo_version_1/model/my_order.dart';
import 'package:zyo_version_1/model/product.dart';


class Store{
  static save_order(List<MyOrder> myOrder){
    String myjson = json.encode(List<dynamic>.from(myOrder.map((x) => x.toMap())));
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("my_order", myjson);
    });
  }

  static Future<List<MyOrder>> load_order()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myjson = prefs.getString("my_order")??"non";
    if(myjson=="non"){
      return <MyOrder>[];
    }else{
      var jsonlist = jsonDecode(myjson) as List;
      print('******** My Order ********');
      print(myjson);
      List<MyOrder> list = <MyOrder>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyOrder.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static save_wishlist(List<Product> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toJson())));
      prefs.setString("wishlist", myjson);
      load_wishlist();
    });
  }

  // static save_recently(List<MyProduct> _products){
  //   SharedPreferences.getInstance().then((prefs) {
  //     String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
  //     prefs.setString("recently", myjson);
  //     load_wishlist();
  //   });
  // }

  static save_rate(List<Product> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toJson())));
      prefs.setString("rate", myjson);
      load_wishlist();
    });
  }
  // static save_remember(bool val){
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setBool("remember", val);
  //     Global.remember_pass=val;
  //   });
  // }

  // static Future<bool> load_remember()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool val = prefs.getBool("remember")??false;
  //   String pass = prefs.getString("remember_pass")??"non";
  //   Global.remember_password=pass;
  //   Global.remember_pass=val;
  //   return val;
  // }

  // static Future<List<MyProduct>> load_recently()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jsonString = prefs.getString("recently")??"non";
  //   if(jsonString=="non"){
  //     return <MyProduct>[];
  //   }else{
  //     var jsonlist = jsonDecode(jsonString) as List;
  //     List<MyProduct> list = <MyProduct>[];
  //     for(int i=0;i<jsonlist.length;i++){
  //       list.add(MyProduct.fromMap(jsonlist[i]));
  //     }
  //     return list;
  //   }
  // }

  static Future<List<Product>> load_rate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("rate")??"non";
    if(jsonString=="non"){
      return <Product>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<Product> list = <Product>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromJson(jsonlist[i]));
      }
      return list;
    }
  }



  static Future<List<Product>> load_wishlist()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("wishlist")??"non";
    if(jsonString=="non"){
      return <Product>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<Product> list = <Product>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromJson(jsonlist[i]));
      }
      return list;
    }
  }

  static save_dic_code(int value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("dic_code", value);
  }

  static load_dic_code()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Global.dis_code=prefs.getInt("dic_code")??0;
  }

  static save_currency(String value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("currency", value);
  }

  static load_currency()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Global.currency_code=prefs.getString("currency")??"AED";
  }

  static saveLoginInfo(String email,String pass){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("pass", pass);
      prefs.setString("remember_pass", pass);
    });
  }

  static logout(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("email");
      prefs.remove("pass");
      prefs.remove("verificat");
      Global.customer=null;
    });
  }

  static Future<LogInInfo> loadLogInInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email")??"non";
    String pass = prefs.getString("pass")??"non";
    return LogInInfo(email, pass);
  }
  static save_verificat(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("verificat", true);
    });
  }

  static Future<bool> load_verificat()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("verificat")??false;
    return val;
  }

  static save_address(Address address){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("addresses", address.toJson());
      Global.address=address;
    });
  }

  static load_address()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString("addresses")??null;
    if(val!=null){
      Global.address=Address.fromJson(val);
    }
  }

}