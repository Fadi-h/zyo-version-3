import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/settings/change_pass_controller.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  ChangePassController changePassController = Get.put(ChangePassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=> SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.main,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  _body(context)
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
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
          SizedBox(width: 5,),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(App_Localization.of(context)!.translate("change_password"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 10),
        _new_pass(context),
        SizedBox(height: 10),
        _confirm_pass(context),
        SizedBox(height: 70),
        _sumbit(context)
      ],
    );
  }
  _old_pass(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: changePassController.old_pass,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorText:
              changePassController.validate.value &&(
                  changePassController.old_pass.text.isEmpty || changePassController.old_pass.text.length < 6)
                  ?
              App_Localization.of(context)!.translate("must_be_at_least_6_character") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("old_password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
  _new_pass(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: changePassController.new_pass,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorText:
              changePassController.validate.value &&(
                  changePassController.new_pass.text.isEmpty || changePassController.new_pass.text.length < 6)
                  ?
              App_Localization.of(context)!.translate("must_be_at_least_6_character") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("new_password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
  _confirm_pass(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: changePassController.confirm_pass,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorText:
              changePassController.validate.value &&(
                  changePassController.confirm_pass.text.isEmpty || changePassController.confirm_pass.text.length < 6)
                  ?
              App_Localization.of(context)!.translate("must_be_at_least_6_character") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("confirm_password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
  _sumbit(BuildContext context) {
    return GestureDetector(
      onTap: () => changePassController.change_password(context,changePassController.new_pass.text,changePassController.confirm_pass.text),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.93,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: Text(App_Localization.of(context)!.translate("submit"),
            style: TextStyle(
                color: AppColors.main,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
