import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';

class ContentPage extends StatelessWidget {

  String title;
  String content;

  ContentPage(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

        backgroundColor: AppColors.main,
      ),
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/logo/logo.svg")
                  ],
                ),
                SizedBox(height: 10,),
                Html(
                  data: content,
                  style: {
                    "p": Style(
                      color: Colors.white,
                    ),
                    "h2": Style(
                      color: Colors.white,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
