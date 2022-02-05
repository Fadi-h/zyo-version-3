import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/view/home.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 3000)).then((value) {
      Get.to(() => Home());
    });
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: AppColors.main,
                    image: DecorationImage(
                        image: AssetImage("assets/checkout/order_confirmed.png")
                    )
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(App_Localization.of(context)!.translate("order_confirmed"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
