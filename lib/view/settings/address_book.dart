import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/view/checkout.dart';
import 'package:zyo_version_1/view/settings/address.dart';

class AddressBook extends StatelessWidget {
  const AddressBook({Key? key}) : super(key: key);

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
          SizedBox(width: 5,),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(App_Localization.of(context)!.translate("my_address"),
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
        SizedBox(height: 50,),
        Global.address==null?Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/settings/non-address.png")
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(App_Localization.of(context)!.translate("it_is_empty"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
              ),
            ),
          )
        ):Container(
            width: MediaQuery.of(context).size.width,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 120,
                          child: Text(App_Localization.of(context)!.translate("phone_number0")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.phone_code+Global.address!.phone,style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(App_Localization.of(context)!.translate("country/region")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.country,style: TextStyle(color: Colors.white),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(App_Localization.of(context)!.translate("state_province0")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.state,style: TextStyle(color: Colors.white),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(App_Localization.of(context)!.translate("city0")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.city,style: TextStyle(color: Colors.white),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(App_Localization.of(context)!.translate("address_10")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.address1,style: TextStyle(color: Colors.white),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(App_Localization.of(context)!.translate("address_20")+":",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Text(Global.address!.address2,style: TextStyle(color: Colors.white),),
                    ],
                  ),


                ],
              ),
            )
        ),
        SizedBox(height: 50),
        _add_shipping_address(context)

      ],
    );
  }
  _add_shipping_address(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddressView());
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: Text(App_Localization.of(context)!.translate("add_a_shipping_address"),
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
