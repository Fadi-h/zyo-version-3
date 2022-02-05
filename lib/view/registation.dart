import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/controller/registration_controller.dart';
import 'package:zyo_version_1/view/forget_pass.dart';
import 'package:zyo_version_1/view/home.dart';

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);

  RegistrationController registrationController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: registrationController.globalKey,
      body: SafeArea(
          child: Obx(() => Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(context),
                      registrationController.selected.value==0 ? _sign_in(context) : _register(context),
                      SizedBox(height: 100),
                      _footer(context)
                    ],
                  ),
                ),
              ),
              Positioned(child: !registrationController.loading.value?Center():
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                ),
              ))
            ],
          ))
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 45,
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child:  SvgPicture.asset("assets/logo/logo.svg",),
                    )

                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
            Get.offAll(()=> Home());
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      App_Localization.of(context)!.translate("skip"),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _footer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white70,
                      thickness: 2,
                      indent: 120.0,
                      endIndent: 5.0,
                    )
                  ],
                ),
              ),
              Text(
                  App_Localization.of(context)!.translate("or_join_with"),
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 15
                  )),
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white70,
                      thickness: 2,
                      indent: 5.0,
                      endIndent: 120.0,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //todo something
                    },
                    child:  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/social_media/google.png")
                        )
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //todo something
                    },
                    child:  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/social_media/instagram.png")
                          )
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //todo something
                    },
                    child:  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/social_media/facebook.png")
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child:
                    registrationController.selected.value==1 ?
                    Text(
                      App_Localization.of(context)!.translate("by_joining"),
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10
                      ),
                    ) : Center(),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  _sign_in(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(App_Localization.of(context)!.translate("sign_in"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: registrationController.selected.value==0 ?
                      TextDecoration.underline : TextDecoration.none,
                  )
              ),
              GestureDetector(
                onTap: () {
                  registrationController.selected.value ++;
                },
                child: Text(App_Localization.of(context)!.translate("register"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.email_sign_in,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_sign.value &&
                  (registrationController.email_sign_in.text.isEmpty ||
                      !RegExp(r'\S+@\S+\.\S+').hasMatch(registrationController.email_sign_in.text)) ?
              App_Localization.of(context)!.translate("email_is_required") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("email_address"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: !registrationController.validate_sign.value ? 5 : 0),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.password_sign_in,
            cursorColor: Colors.white,
            obscureText: registrationController.isHidden_sign.value,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_sign.value &&
                  (registrationController.password_sign_in.text.isEmpty ||
                      registrationController.password_sign_in.text.length < 6) ?
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
              hintText: App_Localization.of(context)!.translate("password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: InkWell(
                onTap: registrationController.visible_password_signin,
                child: Icon(
                  registrationController.isHidden_sign.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        _forget_pass(context),
        SizedBox(height: 20,),
        _sign_button(context),
      ],
    );
  }
  _forget_pass(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Center(
          child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(()=>ForgetPassword());
                },
                child: Text(
                  App_Localization.of(context)!.translate("forget_your_password"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),),
              )),
        ),
      ),
    );
  }
  _sign_button(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // registrationController.next_sign_in();
        registrationController.signIn(context, registrationController.email_sign_in.text, registrationController.password_sign_in.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.93,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.white,
        child: Center(
          child: Text(
            App_Localization.of(context)!.translate("sign_in"),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
  _register (BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  registrationController.selected.value --;
                },
                child: Text(App_Localization.of(context)!.translate("sign_in"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: registrationController.selected.value==0 ?
                        TextDecoration.underline : TextDecoration.none
                    )
                ),
              ),
              Text(App_Localization.of(context)!.translate("register"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                      decoration: registrationController.selected.value==1 ?
                      TextDecoration.underline : TextDecoration.none
                  )
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.fname_register,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_register.value &&
                  (registrationController.fname_register.text.isEmpty ) ?
              App_Localization.of(context)!.translate("first_name_required") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("first_name"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: Icon(
                     Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: !registrationController.validate_register.value ? 5 : 0),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.lname_register,
            cursorColor: Colors.white,

            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_register.value &&
                  (registrationController.lname_register.text.isEmpty) ?
              App_Localization.of(context)!.translate("last_name_required") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("last_name"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: !registrationController.validate_register.value ? 5 : 0),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.email_register,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_register.value &&
                  (registrationController.email_register.text.isEmpty ||
                      !RegExp(r'\S+@\S+\.\S+').hasMatch(registrationController.email_register.text)) ?
              App_Localization.of(context)!.translate("email_is_required") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: App_Localization.of(context)!.translate("email_address"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: !registrationController.validate_register.value ? 5 : 0),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: registrationController.password_register,
            cursorColor: Colors.white,
            obscureText: registrationController.isHidden_register.value,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              registrationController.validate_register.value &&
                  (registrationController.password_register.text.isEmpty ||
                      registrationController.password_register.text.length < 6) ?
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
              hintText: App_Localization.of(context)!.translate("password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              contentPadding: EdgeInsets.all(5),
              suffixIcon: InkWell(
                onTap: registrationController.visible_password_register,
                child: Icon(
                  registrationController.isHidden_register.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            registrationController.isChecked_1.value =
            ! registrationController.isChecked_1.value;
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.93,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    registrationController.isChecked_1.value =
                    ! registrationController.isChecked_1.value;
                  },
                  child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: !registrationController.isChecked_1.value ?
                          Colors.transparent : Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 1.5)
                      ),
                      child: Center(
                          child: Icon(
                            Icons.check,size:15,
                            color: registrationController.isChecked_1.value ?
                            Colors.white : Colors.transparent,
                          ))
                  ),
                ),
                SizedBox(width: 5,),
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("i_agree_to_the"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),),
                ),
                Center(
                  child: Text(" "+
                      App_Localization.of(context)!.translate("privacy_&_cookie_policy"),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12
                    ),),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            registrationController.isChecked_2.value =
            ! registrationController.isChecked_2.value;
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.93,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    registrationController.isChecked_2.value =
                    ! registrationController.isChecked_2.value;
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: !registrationController.isChecked_2.value ?
                                Colors.transparent : Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white,width: 1.5)
                            ),
                            child: Center(
                                child: Icon(
                                  Icons.check,size:15,
                                  color: registrationController.isChecked_2.value ?
                                  Colors.white : Colors.transparent,
                                ))
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.84,
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Text(
                        App_Localization.of(context)!.translate("by_registering"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15,),
        _register_button(context)
      ],
    );
  }
  _register_button(BuildContext context) {
    return GestureDetector(
      onTap: () {
       registrationController.signUp(context,registrationController.email_register.text, registrationController.password_register.text,registrationController.fname_register.text,registrationController.lname_register.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.93,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.white,
        child: Center(
          child: Text(
            App_Localization.of(context)!.translate("register"),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
