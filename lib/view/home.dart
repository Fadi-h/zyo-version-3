import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/controller/cart_controller.dart';
import 'package:zyo_version_1/controller/home_controller.dart';
import 'package:zyo_version_1/model/sub_categories.dart';
import 'package:zyo_version_1/view/cart.dart';
import 'package:zyo_version_1/view/categories.dart';
import 'package:zyo_version_1/view/new_collection.dart';
import 'package:zyo_version_1/view/product.dart';
import 'package:zyo_version_1/view/settings.dart';
import 'package:zyo_version_1/view/sub_category.dart';
import 'package:zyo_version_1/view/wishlist.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  ScrollController _scrollController = ScrollController();

  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.find();
  String _url = 'https://flutter.dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeController.key,
      backgroundColor: AppColors.main,
      bottomNavigationBar: _btnNavBar(context),
      body: Obx(() {
        return  homeController.select_nav_bar == 0 ? _home(context) :
        homeController.select_nav_bar == 1 ? Categories() :
        homeController.select_nav_bar == 2 ? NewCollection() :
        homeController.select_nav_bar == 3 ? WishList() : Settings();
      }),
    );
  }

  _btnNavBar(BuildContext context) {
    return Obx(() => Container(
      width: MediaQuery.of(context).size.width,
      child: BottomNavigationBar(
        mouseCursor: SystemMouseCursors.grab,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(fontSize: 11),
        selectedLabelStyle: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
        selectedItemColor: AppColors.main,
        unselectedItemColor: Colors.black87,
        currentIndex: homeController.select_nav_bar.value,
        onTap: (index) {
          if(index==0&&homeController.select_nav_bar==0){
            _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
          homeController.last_select_nav_bar.value=homeController.select_nav_bar.value;
            homeController.set_nav_bar(index);
        },
        items: [
          BottomNavigationBarItem(
            icon:
            homeController.select_nav_bar.value==0 ?
            Icon(Icons.home, size: 25) :
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/Icon_home.svg',width: 15,height: 15,
              ),
            ),
            label: App_Localization.of(context)!.translate("home"),
          ),
          BottomNavigationBarItem(
            icon: homeController.select_nav_bar.value == 1 ?
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/categories2.svg',width: 15,height: 15,
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/categories.svg',width: 15,height: 15,
              ),
            ),
            label: App_Localization.of(context)!.translate("categories"),
          ),
          BottomNavigationBarItem(
            icon: homeController.select_nav_bar.value == 2 ?
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/new_collection2.svg',width: 18,height: 18,
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/new_collection.svg', width: 18,height: 18
              ),
            ),
            label: App_Localization.of(context)!.translate("new"),
          ),
          BottomNavigationBarItem(
            icon: homeController.select_nav_bar.value == 3 ?
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/wishlist2.svg',width: 15,height: 15,
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/wishlist_icon.svg',width: 15,height: 15,
              ),
            ),
            label: App_Localization.of(context)!.translate("wishlist"),
          ),
          BottomNavigationBarItem(
            icon: homeController.select_nav_bar.value == 4 ?
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/settings2.svg',width: 15,height: 15,
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(3),
              child: SvgPicture.asset('assets/icons/Icon_settings.svg',width: 15,height: 15,
              ),
            ),
            backgroundColor: Colors.white,
            label: App_Localization.of(context)!.translate("settings"),
          ),
        ],
      ),
    ),
    );
  }

  _home(BuildContext context) {
    return WillPopScope(
      onWillPop: homeController.onWillPop,
      child: SafeArea(
        child: Obx((){
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
                      _body(context)
                    ],
                  ),
                ),
              ),
              Positioned(child:  _header(context),),
              Positioned(child: homeController.loading.value?Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                ),
              ):Center())
            ],
          );
        }),
      ),
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height * 0.12,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Column(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         //todo something
                    //       },
                    //       child: SvgPicture.asset('assets/icons/noun_message.svg',width: 20,height: 20,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(width: 15),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.select_nav_bar.value =3;
                          },
                          child: SvgPicture.asset('assets/icons/noun_Heart.svg',
                            width: 20,height: 20, color: Colors.white,
                          ),
                        )

                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //todo something
                          },
                          child: SvgPicture.asset('assets/icons/noun_message.svg',width: 20,height: 20,color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ],
            ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.search,
                            color: Colors.white),
                        onPressed: () => _pressed_on_search(context)
                    ),
                    Stack(
                     children: [
                       Column(
                         children: [
                           GestureDetector(
                             onTap: () {
                               Get.to(()=>Cart());
                             },
                             child: Container(
                               height: 50,
                               width: 20,
                                 child: Icon(Icons.shopping_bag_outlined,color: Colors.white,)),
                           ),
                         ],
                       ),
                       Positioned(
                         top: 28,
                            child: cartController.my_order.length==0?Center():Container(
                              width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(cartController.my_order.length.toString(),
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 7,
                               fontWeight: FontWeight.bold
                             ),),
                          ),
                        ))
                      ],
                   )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _slider(BuildContext context){
    return Stack(
      children: [
        CarouselSlider(
          items: homeController.homePage.slider.map((e){
            return GestureDetector(
              onTap: (){
                homeController.go_to_product_page(e.productId);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    // image: DecorationImage(
                    //     image: CachedNetworkImageProvider(e.image),
                    //     fit: BoxFit.cover)
                  ),
                  child: CachedNetworkImage(
                    // placeholder: (context, url) => const CircularProgressIndicator(),
                    imageUrl: e.image.replaceAll("localhost", "10.0.2.2"),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 2.0,
            initialPage: 0,
            onPageChanged: (index, reason) {
              homeController.slider_value.value=index;
            },
          ),
        ),
        /**3 point*/
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:homeController.homePage.slider.map((e) {
                      return  Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: homeController.slider_value.value == homeController.homePage.slider.indexOf(e)
                                ? Colors.white
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: _slider(context),
        ),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.homePage.category.length,
                  itemBuilder: (context, index) {
                    return _categories(index);
                  }),
            ),
            // Slider(
            //   value: double.parse(homeController.sub_category_value.value.toString()),
            //   onChanged: (value) {
            //     // homeController.slider_value.value = double.parse(value.round().toString());
            //   },
            //   min: 0,
            //   max: (double.parse(homeController.categories.length.toString())-1)+0.5,
            //   activeColor: Colors.white,
            //   inactiveColor: AppColors.main2,
            // ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: SvgPicture.asset("assets/home/shop_by_cat.svg",width: 50,color: Colors.white,),
        ),
        Column(
          children: [
            SizedBox(height: 10,),
            _slider_categories(context),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: homeController.forthSubCategory.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2,right: 2),
                      child: Container(
                        width: 10,
                        height: 2,
                        color: homeController.selectedFourthSubCategory.value==homeController.forthSubCategory.indexOf(e)?Colors.white:Colors.grey,
                      ),
                    );
                  }).toList(),
                )
            ),
            SizedBox(height: 10),

          ],
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height * 0.25,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage("assets/home/home3.png"),
        //           fit: BoxFit.cover
        //       )
        //   ),
        //   child:  Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: Align(
        //       alignment: Alignment.centerRight,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //             child: Text("CYPER MONDAY",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 25
        //                 )
        //             ),
        //           ),
        //           Container(
        //             child: Text("Shopping Guide",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 15
        //                 )
        //             ),
        //           ),
        //           Container(
        //             child: Text("Games, prizes, and more you don't wanto miss!",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 10
        //                 )
        //             ),
        //           ),
        //           SizedBox(height: 10,),
        //           GestureDetector(
        //             onTap: () {
        //               //todo something
        //             },
        //             child: Container(
        //               width: MediaQuery.of(context).size.width * 0.3,
        //               height: MediaQuery.of(context).size.height * 0.04,
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.all(Radius.circular(50))
        //               ),
        //               child: Center(
        //                 child: Text(App_Localization.of(context)!.translate("view_more")),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width * 0.93,
              child: Row(
                children: [
                  Text(
                    App_Localization.of(context)!.translate("flash_sale"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.26,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.homePage.flashSale.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child:  _flash_sale(context,index),
                        ),
                        SizedBox(width: 15)
                      ],
                    );
                  }),
            ),
          ],
        ),
        SizedBox(height: 20),
        _shop_by_age(context),
        SizedBox(height: 20),
        _shop_by_unisex(context),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.035,),
            Text(App_Localization.of(context)!.translate("comming_soon"),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: homeController.homePage.comingSoon.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 7/9
          ), itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                homeController.go_to_product_page(homeController.homePage.comingSoon[index].id);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      fit: BoxFit.fill,
                      image: NetworkImage(homeController.homePage.comingSoon[index].image),
                    )
                  ),


                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.035,),
            Text(App_Localization.of(context)!.translate("our_products"),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        ),
        _products(context),
      ],
    );
  }
  _categories(int index) {
    return GestureDetector(
      onTap: () {
        homeController.select_category.value = index;
        homeController.get_sub_category(index);
      },
      child: Row(
        children: [
          SizedBox(width: 20),
          Obx((){
            return Text(
              homeController.homePage.category[index].title.toString(),
              style: TextStyle(
                  color: homeController.select_category.value == index ?
                  Colors.white : AppColors.main2
              ),
            );
          }),
          SizedBox(width:18)
        ],
      ),
    );
  }
  _slider_categories(BuildContext context) {
    return CarouselSlider(
      carouselController: homeController.controller,
      options: CarouselOptions(
        viewportFraction: 1,
        height: 130.0,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        // autoPlay: true,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {
          homeController.set_index(index);
        },
      ),
      items: homeController.forthSubCategory.map((c){
        return Builder(
            builder:(BuildContext context){
              return Container(
                  child: Row(
                    children: [
                      _sub_categories(context,c.first!),
                      c.second==null?Center():_sub_categories(context,  c.second!),
                      c.third==null?Center(): _sub_categories(context, c.third!),
                      c.fourth==null?Center():_sub_categories(context,  c.fourth!)
                    ],
                  )
              );
            }
        );
      }).toList(),
    );
  }
  _sub_categories(BuildContext context, SubCategory subCategory) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    homeController.go_to_sub_category_page(subCategory);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white , width: 2),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(
                              subCategory.image.toString().replaceAll("localhost", "10.0.2.2")),
                          fit: BoxFit.fill
                        )
                    ),
                  ),
                ),

                Container(
                  height: 35,
                  child: Column(
                    children: [
                      Text(
                        subCategory.title.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _flash_sale(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              homeController.go_to_product_page( homeController.homePage.flashSale[index].id);
            },
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            homeController.homePage.flashSale[index].image.replaceAll("localhost", "10.0.2.2"),)
                      )
                  ),
                ),
                SvgPicture.asset("assets/icons/flash_sale.svg")
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text((homeController.homePage.flashSale[index].price*Global.currency_covert).toStringAsFixed(2)+" "+App_Localization.of(context)!.translate(Global.currency_code),
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text( (homeController.homePage.flashSale[index].oldPrice*Global.currency_covert).toStringAsFixed(2)+" "+App_Localization.of(context)!.translate(Global.currency_code),
            style: TextStyle(
                decorationColor: Colors.white,
                decoration: TextDecoration.lineThrough,
                color: AppColors.main2,
                fontSize: 13
            ),),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text( homeController.homePage.flashSale[index].title,
            style: TextStyle(
                decorationColor: Colors.white,
                color: AppColors.main2,
                fontSize: 12
            ),maxLines: 2,),
        )
      ],
    );
  }
  _products(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4/7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
            ),
            itemCount: homeController.homePage.home_page_products.length,
            itemBuilder: (BuildContext ctx, index) {
              // print(index);
              // print(homeController.homePage.home_page_products.length);
              return _list_products(context,index);
            }),
      ),
    );
  }
  _list_products(BuildContext context, int index) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child:GestureDetector(
            onTap: () {
              homeController.go_to_product_page(homeController.homePage.home_page_products[index].id);
             },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(homeController.homePage.home_page_products[index].image.toString().replaceAll("localhost", "10.0.2.2")),
                    fit: BoxFit.fill
                ),
              ),
              // child: Padding(
              //   padding: const EdgeInsets.all(5),
              //   child: Align(
              //       alignment: Alignment.bottomRight,
              //       child: Obx(() => GestureDetector(
              //         onTap: () {
              //           homeController.wishlistIcon.value = !homeController.wishlistIcon.value;
              //         },
              //         child: homeController.wishlistIcon.value
              //             ? Icon(
              //           Icons.favorite_border,
              //           color: Colors.white,
              //           size: 25,
              //         )
              //             : Icon(
              //           Icons.favorite_outlined,
              //           color: AppColors.main,
              //           size: 25,
              //         ),
              //       ))
              //   ),
              // ),
            ),
          ),),
        Expanded(
            flex:1,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text((homeController.homePage.home_page_products[index].price*Global.currency_covert).toStringAsFixed(2)+" "+App_Localization.of(context)!.translate(Global.currency_code),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                Text((homeController.homePage.home_page_products[index].title),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                  ),
                maxLines: 2,
                ),
              ],
            )
        )
      ],
    );
  }
  _pressed_on_search(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(suggestion_list: Global.suggestion_list,homeController: homeController));
    homeController.go_to_search_page(result!);
    print(result);
  }
  _shop_by_age(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.035,),
            Text(
              App_Localization.of(context)!.translate("shop_by_age"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4/5
        ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.homePage.ages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: GestureDetector(
              onTap: (){
                homeController.go_to_search_page_by_age(homeController.homePage.ages[index]);
              },
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                      child:Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(homeController.homePage.ages[index].image),
                            fit: BoxFit.fill
                          )
                        ),
                      )

                  ),
                  Expanded(
                      flex: 2,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        homeController.homePage.ages[index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          );
        },)
      ],
    );
  }
  _shop_by_unisex(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.035,),
            Text(
              App_Localization.of(context)!.translate("shop_by_unisex"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 4/5
        ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.homePage.unisex.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: GestureDetector(
                onTap: (){
                    homeController.go_to_search_page_by_unisex(homeController.homePage.unisex[index]);
                },
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child:Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(homeController.homePage.unisex[index].image),
                                  fit: BoxFit.fill
                              )
                          ),
                        )

                    ),
                    Expanded(
                        flex: 2,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              homeController.homePage.unisex[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },)
      ],
    );
  }
}

class SearchTextField extends SearchDelegate<String> {
  final List<String> suggestion_list;
  String? result;
  HomeController homeController;

  SearchTextField(
      {required this.suggestion_list, required this.homeController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Visibility(
        child: Text(''),
        visible: false,
      )
          : IconButton(
        icon: Icon(Icons.search, color: Colors.white,),
        onPressed: () {
          close(context, query);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: AppBarTheme(
        color: AppColors.main, //new AppBar color
        elevation: 0,
      ),
      hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
    homeController.go_to_search_page(query);
    close(context, query);
    return Container(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      color: AppColors.main,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
              style: TextStyle(color: AppColors.main2),
            ),
            onTap: () {
              query = suggestions.elementAt(index);
              close(context, query);
            },
          );
        },
      ),
    );
  }
}



