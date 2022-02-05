import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/view/home.dart';
import 'package:zyo_version_1/view/no_internet.dart';

class VerificationCodeController extends GetxController {

  TextEditingController code = TextEditingController();
  var validate = false.obs;
  var loading = false.obs;


  resend(BuildContext context){
    try{
      Api.check_internet().then((net) {
        if(net){
          loading.value=true;
          Store.loadLogInInfo().then((info) {
            Api.resend_code(info.email).then((result) {
              loading.value=false;
              if(result.succses){
                App.sucss_msg(context, App_Localization.of(context)!.translate("resend_succ"));
              }else{
                App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
              }
            });
          });
        }else{
          Get.to(()=>NoInternet())!.then((value) {
            resend(context);
          });
        }
      });
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
    }

  }

  verificate(BuildContext context,String code){
    try{
      if(code.isEmpty){
        validate.value=false;
      }else{
        Api.check_internet().then((net) {
          if(net){
            validate.value=true;
            loading.value=true;
            Store.loadLogInInfo().then((info) {
              Api.verify_code(info.email,code).then((result) {
                loading.value=false;
                Api.login(info.email,info.pass);
                if(result.succses){
                  App.sucss_msg(context, App_Localization.of(context)!.translate("mail_verificated"));
                  Store.save_verificat();
                  Get.offAll(()=>Home());
                }else{
                  App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
                }
              });
            });
          }else{
            //todo no internet
            // Get.to(()=>NoInternet())!.then((value) {
            //   verificate(context,code);
            // });
          }
        });
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context)!.translate("wrong"));
    }

  }

}