import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';

class ConnectToUs extends StatelessWidget {
  ConnectToUs({Key? key}) : super(key: key);


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
            child: Text(App_Localization.of(context)!.translate("connect_to_us"),
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
        SizedBox(height: 20,),
        _facebook(context),
        SizedBox(height: 20,),
        _instagram(context),
        SizedBox(height: 20,),
        _twitter(context)
      ],
    );
  }
  _facebook(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.main3,
      child: GestureDetector(
        onTap: () {
          //todo something
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/social_media_contact_us/facebook.svg",width: 30,height: 30,),
              SizedBox(width: 10,),
              Text(App_Localization.of(context)!.translate("facebook"),
                style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }
  _instagram(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.main3,
      child: GestureDetector(
        onTap: () {
          //todo something
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/social_media_contact_us/insta.png")
                    )
                ),
              ),
              SizedBox(width: 10,),
              Text(App_Localization.of(context)!.translate("instagram"),
                style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }
  _twitter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.main3,
      child: GestureDetector(
        onTap: () {
          //todo something
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/social_media_contact_us/twitter.svg",width: 30,height: 30,),
              SizedBox(width: 10,),
              Text(App_Localization.of(context)!.translate("twitter"),
                style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }
}
