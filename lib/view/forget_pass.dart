import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/forget_pass_controller.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  ForgetPassController forgetPassController = Get.put(ForgetPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.main,
      body: Obx(()=> SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                SizedBox(height: 100,),
                _body(context),
                SizedBox(height: 100,),
                _submit(context)
              ],
            ),
          ),
        ),
      ))
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      height: MediaQuery.of(context).size.height * 0.1,
      child:  Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
          ),
          SizedBox(width: 5,),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(App_Localization.of(context)!.translate("forget_password"),
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
        controller: forgetPassController.email,
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          errorText:
          forgetPassController.validate.value &&
              (forgetPassController.email.text.isEmpty ||
                  !RegExp(r'\S+@\S+\.\S+').hasMatch(forgetPassController.email.text)) ?
          App_Localization.of(context)!.translate("email_is_required") : null,
          errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: App_Localization.of(context)!.translate("email_address"),
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
       forgetPassController.submit();
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
