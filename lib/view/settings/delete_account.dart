import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/settings/delete_account_controller.dart';

class DeleteAccount extends StatelessWidget {

  DeleteAccount({Key? key}) : super(key: key);

  DeleteAccountController deleteAccountController = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.main,
        body: SafeArea(
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
        )
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
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(App_Localization.of(context)!.translate("delete_account"),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50,),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/settings/sad-face.png")
                )
            ),
        ),
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          child: Center(
            child: Text(
              App_Localization.of(context)!.translate("do_you_really_want_to_delete_your_account"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        deleteAccountController.submit(context, App_Localization.of(context)!.translate("no")),
        SizedBox(height: 20),
        deleteAccountController.submit(context, App_Localization.of(context)!.translate("yes"))
      ],
    );
  }
}
