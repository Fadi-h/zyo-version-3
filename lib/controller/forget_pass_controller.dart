import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/view/home.dart';
import 'package:zyo_version_1/view/no_internet.dart';

class ForgetPassController extends GetxController {

  TextEditingController email = TextEditingController();
  var validate = false.obs;
  var loading = false.obs;

  submit() {
    if(email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text))
    {
      validate.value = true;
    }
    else {
      validate.value = false;
      Get.offAll(()=>Home());
    }
  }

  forget_pass(BuildContext context,String email){
    try{
      if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
        if(email.isEmpty){
          validate.value=true;
          // App.error_msg(context, App_Localization.of(context).translate("enter_mail"));
        }
        // email_vaildate.value=false;
      } else{
        Api.check_internet().then((net) {
          if(net){
            // email_vaildate.value=true;
            loading.value=true;
            Api.forget_password(email).then((value) {
              loading.value=false;
              if(value.succses){
                App.sucss_msg(context, App_Localization.of(context)!.translate("resend_pass_succ"));
              }else{
                App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
              }
            })
                .catchError((value){
              loading.value=false;
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              forget_pass(context,email);
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