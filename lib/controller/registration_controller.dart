import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/view/home.dart';
import 'package:zyo_version_1/view/no_internet.dart';
import 'package:zyo_version_1/view/verification_code.dart';

class RegistrationController extends GetxController {

  GlobalKey<ScaffoldState> globalKey =  GlobalKey<ScaffoldState>();
  var selected = 0.obs;
  TextEditingController email_sign_in = TextEditingController();
  TextEditingController password_sign_in = TextEditingController();
  TextEditingController email_register = TextEditingController();
  TextEditingController password_register = TextEditingController();
  TextEditingController fname_register = TextEditingController();
  TextEditingController lname_register = TextEditingController();
  var validate_sign = false.obs;
  var validate_register = false.obs;
  var loading = false.obs;
  var isHidden_sign = true.obs;
  var isHidden_register = true.obs;
  var isChecked_1 = false.obs;
  var isChecked_2 = false.obs;

  visible_password_signin() {
    isHidden_sign.value = !isHidden_sign.value;
  }

  visible_password_register() {
    isHidden_register.value = !isHidden_register.value;
  }

  next_sign_in() {
    if(email_sign_in.text.isEmpty || password_sign_in.text.isEmpty ||
       !RegExp(r'\S+@\S+\.\S+').hasMatch(email_sign_in.text) ||
        password_sign_in.text.length < 6 )
      {
        validate_sign.value = true;
      }
    else {
      validate_sign.value = false;
      Get.offAll(()=>Home());
    }
  }


  signIn(BuildContext context,String email,String pass){
    try{
      if(email_sign_in.text.isEmpty || password_sign_in.text.isEmpty ||
          !RegExp(r'\S+@\S+\.\S+').hasMatch(email_sign_in.text) ||
          password_sign_in.text.length < 6 ){
          validate_sign.value=true;

      }else{
        Api.check_internet().then((net) {
          if(net){
            loading.value=true;
            Api.login(email, pass).then((value) {
              if(value.state==200){
                Store.saveLoginInfo(email, pass);
                App.sucss_msg(context,App_Localization.of(context)!.translate("login_succ"));
                Api.login(email,pass).then((result){
                  loading.value=false;
                  Global.customer=result.data.first;
                    Get.offAll(()=>Home());
                });

              }else{
                loading.value=false;
                App.error_msg(context, App_Localization.of(context)!.translate("wrong_mail"));
              }
            });
          }else{

            Get.to(()=>NoInternet())!.then((value) {
              signIn(context,email,pass);
            });
          }
        });

      }

    }catch (e){
      print(e.toString());
      loading.value=false;
      App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
    }

  }

  signUp(BuildContext context,String email,String pass,String fname,String lname){
    try{
      if(email_register.text.isEmpty || password_register.text.isEmpty ||
          !RegExp(r'\S+@\S+\.\S+').hasMatch(email_register.text) ||
          fname.isEmpty||lname.isEmpty||
          password_register.text.length < 6 ){
          validate_register.value=true;
      }else{
        Api.check_internet().then((net) {
          if(net){
            loading.value=true;
            Api.sign_up(email, pass,fname,lname).then((value) {
              if(value.state==200){
                Store.saveLoginInfo(email, pass);

                // Global.customer=value.data.first;
                App.sucss_msg(context, App_Localization.of(context)!.translate("sign_up_succ"));
                loading.value=false;
                Get.offAll(() => VerificatioCode());

              }else{
                loading.value=false;
                App.error_msg(context, App_Localization.of(context)!.translate("wrong_signup_msg"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              signUp(context,email,pass,fname,lname);
            });
          }
        });
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
    }
  }



}