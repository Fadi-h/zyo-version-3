import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/store.dart';
import 'package:zyo_version_1/controller/settings_controller.dart';
import 'package:zyo_version_1/view/no_internet.dart';

class CurrencyView extends StatelessWidget {
  List<String> currencies=['AED', 'Dollar'];
  Settings_controlller settings_controlller = Get.find();
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
            child: Text(App_Localization.of(context)!.translate("currency"),
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
        SizedBox(height: 20),
        _languages(context),
        SizedBox(height: 20)
      ],
    );
  }
  _languages(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          child: Obx((){
            return Column(
              children: [
                settings_controlller.loading.value?Center():Center(),
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Api.check_internet().then((net) {
                          if(net){
                            Global.currency_code = currencies[0];
                            Store.save_currency(currencies[0]);
                            settings_controlller.loading.value=!settings_controlller.loading.value;
                            if(currencies[0]!="AED"){
                              Api.get_dollar().then((value) {
                                Global.currency_covert=value;
                              });
                            }else{
                              Global.currency_covert=1.0;
                            }
                          }else{
                            Get.to(NoInternet());
                          }
                        });

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            color: AppColors.main,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  App_Localization.of(context)!.translate(currencies[0]),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                  ),
                                ),
                                Icon(
                                  Icons.check,
                                  color:
                                  Global.currency_code==currencies[0]?Colors.white:Colors.transparent,size: 20,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Api.check_internet().then((net) {
                          if(net){
                            Global.currency_code = currencies[1];
                            Store.save_currency(currencies[1]);
                            settings_controlller.loading.value=!settings_controlller.loading.value;
                            if(currencies[1]!="AED"){
                              Api.get_dollar().then((value) {
                                Global.currency_covert=value;
                              });
                            }else{
                              Global.currency_covert=1.0;
                            }
                          }else{
                            Get.to(NoInternet());
                          }
                        });

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            color: AppColors.main,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  App_Localization.of(context)!.translate("USD"),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                  ),
                                ),
                                Icon(
                                  Icons.check,
                                  color:
                                  Global.currency_code==currencies[1]?Colors.white:Colors.transparent,size: 20,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          )
                        ],
                      ),
                    ),

                  ],
                )
              ],
            );
          }),
        )
      ],
    );
  }

}