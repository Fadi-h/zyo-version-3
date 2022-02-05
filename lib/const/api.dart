import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/model/customer.dart';
import 'package:zyo_version_1/model/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:zyo_version_1/model/login_info.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/model/sub_categories.dart';

class Api {

  // static String url = "http://10.0.2.2:3000/";
  static String url = "http://phpstack-548447-2420659.cloudwaysapps.com/";

   static Future<HomePage> get_home_page()async{
    var request = http.Request('GET', Uri.parse(url+'api/home_page'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return HomePage.fromJson(json.decode(jsonString));
    }
    else {
      return HomePage( category: <Category>[], slider: <MySlider>[], comingSoon: <ComingSoon>[],flashSale: <FlashSale>[],home_page_products: <Product>[],new_products: <Product>[]);
    }
  }
  static add_review(int customer_id,int product_id,String text)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/review'));
    request.body = json.encode({
      "priduct_id": product_id,
      "customer_id": customer_id,
      "body": text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  static Future<double> get_dollar()async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/key'));
    request.body = json.encode({
      "key": "Dollar"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var map = json.decode(jsonString);
      return map['amount'];
    }
    else {
      return 1.0;
    }

  }
  static add_like(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product/likes'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  static un_like(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product/unlikes'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  static Future<ProductData?> get_product_info(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_data'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return ProductData.fromJson(json.decode(jsonString));
    }
    else {
      return null;
    }

  }
  static Future<int> Apply_dis_code(String code)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/check_code'));
    request.body = json.encode({
      "code": code
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      Global.dis_code=int.parse(jsonString);
      Store.save_dic_code(Global.dis_code);
      return int.parse(jsonString);
    }
    else {
      return 0;
    }

  }

  static Future<SubCategoryList> get_sub_category(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/sub_category_category'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var jsonString = await response.stream.bytesToString();
      // print(jsonString);
      return SubCategoryList.fromJson(json.decode(jsonString));
    }
    else {
      return SubCategoryList(subCategory: <SubCategory>[]);
      print(response.reasonPhrase);
    }


  }

  static rate(Product productInfo , double rate)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    double x= productInfo.rate*productInfo.ratingCount;
    double result = (x+rate)/(productInfo.ratingCount+1);
    var request = http.Request('POST', Uri.parse(url+'api/rate'));
    request.body = json.encode({
      "rate": result,
      "rating_count": productInfo.ratingCount++,
      "id": productInfo.id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  static Future<List<Product>> getProducts(List<Product> wishlist,int sub_category_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_sub_category'));
    request.body = json.encode({
      "id": sub_category_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsons = await response.stream.bytesToString();
      var jsonlist = jsonDecode(jsons) as List;
      List<Product> list = <Product>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromJson(jsonlist[i]));
      }
      return get_favorite(wishlist,list);
    }
    else {
      return <Product>[];
    }

  }
  static Future<List<Product>> getProductsSearch(List<Product> wishlist,String q)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product/search'));
    request.body = json.encode({
      "title": q
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonlist = jsonDecode(jsonString) as List;
      List<Product> list = <Product>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromJson(jsonlist[i]));
        // list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist, list);
    }
    else {
      return <Product>[];
    }

  }
  static Future<List<Product>> getProductsByBrand(List<Product> wishlist,int brand_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_brand'));
    request.body = json.encode({
      "id": brand_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsons = await response.stream.bytesToString();
      var jsonlist = jsonDecode(jsons) as List;
      List<Product> list = <Product>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromJson(json.decode(jsonlist[i])));
      }
      return get_favorite(wishlist, list);
    }
    else {
      return <Product>[];
    }

  }
  static List<Product> get_favorite(List<Product> wishlist,List<Product> prods){

    for(int i=0 ; i<wishlist.length;i++){
      for(int j=0 ; j<prods.length;j++){
        if(prods[j].id==wishlist[i].id){
          prods[j].favorite.value=true;
        }
      }
    }
    return prods;
  }

  ///-------------logIn-------------
  static Future<MyReult> resend_code(String email)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'resend_code'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }

  }
  static Future<Result> sign_up(String email,String pass,String firstname,String lastname)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'add_user'));
    request.body = json.encode({
      "email": email,
      "pass": pass,
      "firstname":firstname,
      "lastname":lastname
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      Global.customer=result.data.first;
      return result;
    }
    else {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      return result;
    }

  }
  static Future<Result> login(String email,String pass)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'log_in'));
    request.body = json.encode({
      "email": email,
      "pass": pass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      Global.customer=result.data.first;
      Store.save_verificat();
      return result;
    }
    else {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      return result;
    }
  }
  static Future<MyReult> change_password(String email,String newpass)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'change_password'));
    request.body = json.encode({
      "email": email,
      "pass": newpass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      Store.saveLoginInfo(email, newpass);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  static Future<MyReult> forget_password(String email)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'forget_password'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  static Future<MyReult> verify_code(String email,String code)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'verify_email'));
    request.body = json.encode({
      "email": email,
      "code": code
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }

  static Future<bool> check_internet()async{
    // return false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }else{
      return false;
    }

  }
}