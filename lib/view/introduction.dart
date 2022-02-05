import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/introduction_controller.dart';
import 'package:zyo_version_1/view/registation.dart';

class Introduction extends StatelessWidget {
  Introduction({Key? key}) : super(key: key);

  IntroController introController = Get.put(IntroController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/intro/intro.png"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _btn(context),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  //remove later
  _btn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(()=>Registration());
      },
      child:Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
