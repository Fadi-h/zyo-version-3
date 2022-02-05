import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class App{

  static sucss_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
        backgroundColor: Colors.grey,
      ),
    );
  }
  static error_msg(BuildContext context,String err){
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message:
        err,
      ),
    );
  }
  static openwhatsapp(BuildContext context,String msg) async{
    var whatsapp ="+971 52 692 4021";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";
    if( await canLaunch(whatappURL_ios)){
      await launch(whatappURL_ios);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }
  }
}