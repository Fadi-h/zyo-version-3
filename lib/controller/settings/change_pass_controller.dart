import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/top_bar.dart';
import 'package:zyo_version_1/view/no_internet.dart';

class ChangePassController extends GetxController {

  TextEditingController old_pass = TextEditingController();
  TextEditingController new_pass = TextEditingController();
  TextEditingController confirm_pass = TextEditingController();
  var validate = false.obs;
  var loading = false.obs;

  submit(BuildContext context) {
    if(old_pass.text.isEmpty || new_pass.text.isEmpty ||
        confirm_pass.text.isEmpty || old_pass.text.length < 6 ||
        new_pass.text.length < 6 || confirm_pass.text.length < 6 ) {
      validate.value = true;
    }
    else {
      validate.value = false;
      TopBar().success_top_bar(context, "password Changed");
    }
  }

  change_password(BuildContext context,String pass,String confPass){
    if(pass.isEmpty||confPass.isEmpty){
      if(pass.isEmpty){
        validate.value=true;
      }else{
        validate.value=false;
      }

      if(confPass.isEmpty){
        validate.value=true;
      }else{
        validate.value=false;
      }
    }else{
      if(pass==confPass&&pass.length>=6){
        Api.check_internet().then((internet){
          if(internet){
            // validateConfNewPass.value=true;
            // validateNewPass.value=true;
            loading.value=true;
            Api.change_password(Global.customer!.email, pass).then((result) {
              loading.value=false;
              if(result.succses){
                App.sucss_msg(context, App_Localization.of(context)!.translate("pass"));
              }else{
                App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              change_password(context,pass,confPass);
            });
          }
        });
      }else{
        if(pass.length<6){
          App.error_msg(
              context, App_Localization.of(context)!.translate("small_pass"));
        }else if(confPass.length<6){
          App.error_msg(
              context, App_Localization.of(context)!.translate("small_pass"));
        }else {
          App.error_msg(
              context, App_Localization.of(context)!.translate("conf_eq_pass"));
        }
      }
    }
  }
}