import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';

class NoInternet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/background/no_internet.png"),
            //   fit: BoxFit.cover
            // )

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Icon(Icons.wifi_off,size: 100,color: Colors.white,),
              Column(
                children: [
                  Text(App_Localization.of(context)!.translate("oops"),style: TextStyle(color: Colors.white,fontSize: 32),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(App_Localization.of(context)!.translate("no_internet"),style:TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: (){
                  Api.check_internet().then((value) {
                    if(value){
                      Get.back();
                    }
                  });
                },
                elevation: 2,
                color: Colors.white,
                child:Text(App_Localization.of(context)!.translate("reload"),style: TextStyle(color: Colors.black,fontSize: 16),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            ],
          ),
        ),
      ),
    );
  }

}