import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/verification_code_controller.dart';

class VerificatioCode extends StatelessWidget {

  VerificationCodeController verificationCodeController = Get.put(VerificationCodeController());
  var loading=false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
        body: Obx(()=> SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      SizedBox(height: 100,),
                      _body(context),
                      SizedBox(height: 50,),
                      Text(App_Localization.of(context)!.translate("check_mail"),style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(height: 30,),
                      _submit(context)
                    ],
                  ),
                ),
              ),
              Positioned(child: !verificationCodeController.loading.value?Center():
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                     child: CircularProgressIndicator(color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      height: MediaQuery.of(context).size.height * 0.1,
      child:  Row(
        children: [

          SizedBox(width: 5,),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(App_Localization.of(context)!.translate("verificatio_code"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
          )

        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: verificationCodeController.code,
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          errorText:
          verificationCodeController.validate.value &&
              (verificationCodeController.code.text.isEmpty ) ?
          App_Localization.of(context)!.translate("code_required") : null,
          errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: App_Localization.of(context)!.translate("code"),
          hintStyle: TextStyle(color: Colors.white,fontSize: 15),
          contentPadding: EdgeInsets.all(5),
          suffixIcon: Icon(
            Icons.email_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
  _submit(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // forgetPassController.submit();
        verificationCodeController.verificate(context, verificationCodeController.code.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.93,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.white,
        child: Center(
          child: Text(
            App_Localization.of(context)!.translate("submit"),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
