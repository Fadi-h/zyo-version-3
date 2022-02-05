import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/controller/settings/personal_info_controller.dart';
import 'package:zyo_version_1/view/registation.dart';

class PersonalInfo extends StatelessWidget {

  PersonalInfo({Key? key}) : super(key: key);

  PersonalInfoController personalInfoController = Get.put(PersonalInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      height: 80,
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
            child: Text(App_Localization.of(context)!.translate("personal_information"),
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
        //if the user does not sign in
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.4,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text("Please sign up first",
        //         style: TextStyle(
        //           color: Colors.white
        //         ),),
        //         GestureDetector(
        //           onTap: () {
        //            Get.to(()=> Registration());
        //           },
        //           child: Text("sign in",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 decoration: TextDecoration.underline,
        //                 decorationColor: Colors.white
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          child: Column(
            children: [
              _first_name(context),
              SizedBox(height: 20),
              _last_name(context),
              SizedBox(height: 20),
              _email(context),
            ],
          ),
        ),
      ],
    );
  }
  _first_name(BuildContext context) {
    return Container(
      color: AppColors.main3,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(App_Localization.of(context)!.translate("firstname1"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(Global.customer!.firstname,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          ),
        ],
      ),
    );
  }
  _last_name(BuildContext context) {
    return Container(
      color: AppColors.main3,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(App_Localization.of(context)!.translate("lastname1"),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(Global.customer!.lastname,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          ),
        ],
      ),
    );
  }
  _email(BuildContext context) {
    return Container(
      color: AppColors.main3,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(App_Localization.of(context)!.translate("email"),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(Global.customer!.email,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          ),
        ],
      ),
    );
  }
}
