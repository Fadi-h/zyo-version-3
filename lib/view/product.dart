import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/api.dart';
import 'package:zyo_version_1/const/app.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/btn_sheet.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/const/top_bar.dart';
import 'package:zyo_version_1/controller/cart_controller.dart';
import 'package:zyo_version_1/controller/product_controller.dart';
import 'package:zyo_version_1/controller/wishlist_controller.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/view/cart.dart';
import 'package:zyo_version_1/view/content_page.dart';
import 'package:zyo_version_1/view/no_internet.dart';
import 'package:zyo_version_1/view/registation.dart';

class ProductInfo extends StatelessWidget {
  ProductData product_data;
  String tag;


  ProductController productController = Get.put(ProductController());
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();
  ProductInfo(this.product_data,this.tag){
    for(int i=0;i<wishListController.wishlist.length;i++){
      if(wishListController.wishlist[i].id==product_data.product.id){
        product_data.product.favorite.value=true;
        break;
      }
    }
    for(int i=0;i<wishListController.rate.length;i++){
      if(product_data.product.id==wishListController.rate[i].id){
        productController.ratingValue.value=wishListController.rate[i].rate;
        print('********');
        print(productController.ratingValue.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Obx(()=> SafeArea(
        child:  CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.main,
                  child: Column(
                    children: [
                      _header(context),
                      _body(context),
                    ],
                  ),
                ),
              ),
              backgroundColor: AppColors.main,
              expandedHeight: MediaQuery.of(context).size.height,
            ),
            Container(
              child: SliverList(delegate: SliverChildListDelegate.fixed([

                Obx(() =>  Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height*0.8,
                  color: AppColors.main,
                  child: Column(
                    children: [
                       _goods(context) ,
                      _footer(context),
                      _reviews(context),
                    ],
                  ),
                ))
              ])),
            )
          ],
        ),
      )),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      height: MediaQuery.of(context).size.height * 0.1,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
              )
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
    );
  }
  _footer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx((){
                 return GestureDetector(
                      onTap: () {
                        if(!product_data.product.favorite.value){
                          product_data.product.likes.value++;
                          wishListController.add_to_wishlist(product_data.product, context);
                          product_data.product.favorite.value=true;
                        }else {
                          product_data.product.likes.value--;
                          wishListController.delete_from_wishlist(product_data
                              .product);
                          product_data.product.favorite.value = false;
                        }
                      },
                      child: !product_data.product.favorite.value ?
                      Icon(Icons.favorite_border,color: AppColors.main,size: 30,) :
                      Icon(Icons.favorite, color: Colors.red,size: 30,)
                  );
                })
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                product_data.product.commingSoon==1
                    ?Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: Text(App_Localization.of(context)!.translate("comming_soon"),
                      style: TextStyle(
                          color: AppColors.main,
                          fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
                    :GestureDetector(
                  onTap: () {
                    if(product_data.subProduct[productController.selected_sub_product.value].size.isNotEmpty&&product_data.subProduct[productController.selected_sub_product.value].size.length>productController.select_size.value&&product_data.subProduct[productController.selected_sub_product.value].size[productController.select_size.value].availability!=0){
                      product_data.product.cart_details="";
                      if(product_data.subProduct.isNotEmpty){
                        product_data.product.cart_details=product_data.subProduct[productController.selected_sub_product.value].color;
                      }
                      if(product_data.subProduct[productController.selected_sub_product.value].size.isNotEmpty){
                        product_data.product.cart_details+=":"+product_data.subProduct[productController.selected_sub_product.value].size[productController.select_size.value].title;
                      }
                      // product_data.product.cart_details=product_data.subProduct[productController.selected_sub_product.value].color;
                      cartController.add_to_cart(product_data.product, 1);
                      App.sucss_msg(context, App_Localization.of(context)!.translate("just_added_to_your_bag"));
                    }
                  },
                  child: Container(
                    color: AppColors.main,
                    width: MediaQuery.of(context).size.width * 0.78,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(App_Localization.of(context)!.translate("add_to_bag"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        _slider_images(context),
        SizedBox(height: 20),
        _title2(product_data.product,context),
        SizedBox(height: 10),
        _price_and_rating(product_data.product,context),
      ],
    );
  }
  _slider_images(BuildContext context) {
    return Hero(
      tag: this.tag,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: productController.controller,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.67,
                autoPlay: product_data.subProduct.length!=0&&product_data.subProduct[productController.selected_sub_product.value].images.length!=0
                    ? true
                    : false,
                viewportFraction: 1,
                autoPlayInterval: Duration(seconds: 3),
                onPageChanged: (index, reason) {

                  productController.set_index(index);
                }),

            itemCount: product_data.subProduct.length!=0&&product_data.subProduct[productController.selected_sub_product.value].images.length!=0
                ?product_data.subProduct[productController.selected_sub_product.value].images.length:1,
            itemBuilder: (BuildContext context,
                int index, int realIndex) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration:BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          product_data.subProduct.length!=0&&product_data.subProduct[productController.selected_sub_product.value].images[index]!=0
                          ?product_data.subProduct[productController.selected_sub_product.value].images[index].link.replaceAll("localhost", "10.0.2.2")
                          :product_data.product.image
                      ),
                      fit: BoxFit.fill,
                    )),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 5,
            right: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 SizedBox(width: 50),
                  Column(
                    children: [
                      product_data.subProduct.isNotEmpty&&product_data.subProduct[productController.selected_sub_product.value].images.isNotEmpty?Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: product_data.subProduct.isNotEmpty&&product_data.subProduct[productController.selected_sub_product.value].images.isNotEmpty?Center(
                            child: Text(
                              (productController.activeIndex.value+1).toString()+
                                  "/" +
                                  product_data.subProduct[productController.selected_sub_product.value].images.length.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),)
                        ):Center(),
                      ):Center(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red,size: 30,),
                        SizedBox(width: 7,),
                        Text(product_data.product.likes.value.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
  _price_and_rating(Product product, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              (product.price*Global.currency_covert).toStringAsFixed(2) + " " + App_Localization.of(context)!.translate(Global.currency_code),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),),
          ),
          RatingBar(
              itemSize: 20,
              initialRating: productController.ratingValue.value,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                  full: Icon(Icons.star, color: Colors.white),
                  half: Icon(
                    Icons.star_half,
                    color: Colors.white,
                  ),
                  empty: Icon(
                    Icons.star_outline,
                    color: Colors.white,
                  )),
              onRatingUpdate: (rating) {
                Product p= Product(bodtHtml: product_data.product.bodtHtml, id: product_data.product.id, subCategoryId: product_data.product.subCategoryId, title: product_data.product.title, subTitle: product_data.product.subTitle, description: product_data.product.description, image: product_data.product.image, search: product_data.product.search, availability: product_data.product.availability, price: product_data.product.price, ratingCount: product_data.product.ratingCount, rate: product_data.product.rate, commingSoon: product_data.product.commingSoon, likes: product_data.product.likes);
                wishListController.add_to_rate(p, rating);
                Api.check_internet().then((net) {
                  if(net){
                    Api.rate(product_data.product, rating);
                  }else{
                    Get.to(NoInternet())!.then((value) {
                      Api.rate(product_data.product, rating);
                    });
                  }
                });

                productController.ratingValue.value = rating;
              }),
        ],
      ),
    );
  }
  _goods(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // _header2(context),
          // _product_image(context),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.15,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(App_Localization.of(context)!.translate("goods"),
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               decoration: productController.selected.value==0 ?
          //               TextDecoration.underline : TextDecoration.none
          //           )
          //       ),
          //       SizedBox(width: 50,),
          //       GestureDetector(
          //         onTap: () {
          //           productController.selected.value ++;
          //         },
          //         child: Text(App_Localization.of(context)!.translate("reviews"),
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //             )
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10),
          // _title2(product_data.product,context),
          // SizedBox(height: 10),
          // _price_and_rating(product_data.product,context),
          SizedBox(height: 10),
          _list_of_color(context),
          SizedBox(height: 10),
          _list_of_size(context),
          SizedBox(height: 10),
          Divider(
            color: Colors.white12,
            thickness: 5,
          ),
          GestureDetector(
           onTap: () {
             Get.to(()=>ContentPage(App_Localization.of(context)!.translate("return_police"), App_Localization.of(context)!.translate("return_policy_content")));
            },
           child:  Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(
                   children: [
                     Row(
                       children: [
                         Transform.scale(
                           scale: 1.1,
                           child: Checkbox(
                             side: MaterialStateBorderSide.resolveWith(
                                   (states) => BorderSide(width: 1.0,
                                   color: productController.checked.value ? Colors.transparent : Colors.white),
                             ),
                             activeColor: Colors.green,
                             checkColor: Colors.black,
                             shape: CircleBorder(),
                             value: productController.checked.value,
                             onChanged: (value) {
                               productController.checked.value = value!;
                             },
                           ),
                         ),
                         Center(
                           child: Text(App_Localization.of(context)!.translate("return_police"),
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 15
                             ),),
                         ),
                       ],
                     )
                   ],
                 ),
                 Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(10),
                       child: Icon(Icons.arrow_forward_ios,
                         color: Colors.white,size: 20,),
                     )
                   ],
                 ),
               ],
             ),
           ),
         ),
          Divider(
            color: Colors.white12,
            thickness: 5,
          ),
          _description(context),
          Divider(
            color: Colors.white12,
            thickness: 1,
          ),
          _size_information(context),
          SizedBox(height: 10)
        ],
      ),
    );
  }
  _header2(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.93,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
  _product_image(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration:BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(product_data.product.image),
                fit: BoxFit.fill,
              )),
        )
      ],
    );
  }
  _title2(Product product,BuildContext context) {
    return Column(
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.93,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.93-100,
                        child: Text(
                          product.title.toString(),
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(product_data.product.rate.toStringAsFixed(2), style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),),
                            SizedBox(width: 10,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ],
    );
  }
  _list_of_color(BuildContext context) {
    return product_data.subProduct.isEmpty?Center():Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context)!.translate("color")+" "+ product_data.subProduct[productController.selected_sub_product.value].color,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),),
          SizedBox(height: 10,),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: product_data.subProduct.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      _colors(context,index),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  _colors(BuildContext context, int index) {
    return Obx(() => GestureDetector(
      onTap: () {
        productController.set_index(0);
        productController.selected_sub_product.value = index;
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: product_data.subProduct[index].degree.startsWith("#")?hexToColor(product_data.subProduct[index].degree):Colors.white, //this is the important line
            borderRadius: BorderRadius.all(Radius.circular(30)),
            image:product_data.subProduct[index].degree.startsWith("#")?null: DecorationImage(
              image: NetworkImage(product_data.subProduct[index].degree),
              fit: BoxFit.fill
            ),
            border: Border.all(color: productController.selected_sub_product == index.obs ?
            Colors.white : Colors.transparent , width: 2,

            ),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.3,
              blurRadius: 0.2
            )
          ]
        ),
      ),
    ));
  }
  _list_of_size(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product_data.subProduct[productController.selected_sub_product.value].size.isEmpty?Center():Text(App_Localization.of(context)!.translate("size"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:  product_data.subProduct[productController.selected_sub_product.value].size.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(width: 10),
                      _sizes(context,index),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
  _sizes(BuildContext context, int index) {
    return Obx(() => GestureDetector(
      onTap: () {
        productController.select_size.value = index;
      },
      child: Container(
        width: 65.0,
        decoration: BoxDecoration(
           // color: Colors.red, //this is the important line
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color:
            product_data.subProduct[productController.selected_sub_product.value].size[index].availability==0
                ?Colors.red
                : productController.select_size == index.obs ?
            Colors.white : Colors.white24 , width: 2
            )
        ),
        child: Center(
          child: Text(
           product_data.subProduct[productController.select_color.value].size[index].title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }
  _description(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child:GestureDetector(
            onTap: () {
              _btm_sheet_desc(context);
            },
            child:  Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width * 0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(App_Localization.of(context)!.translate("description"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.white,size: 20,)
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
  _size_information(BuildContext context) {
    return product_data.subProduct[productController.select_color.value].size.isEmpty?Center():Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product_data.subProduct[productController.select_color.value].size[productController.select_size.value].details,style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
  _reviews(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        children: [
          // _header2(context),
          // _product_image(context),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.15,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           productController.selected.value --;
          //         },
          //         child: Text(App_Localization.of(context)!.translate("goods"),
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 18,
          //                 decoration: productController.selected.value==0 ?
          //                 TextDecoration.underline : TextDecoration.none
          //             )
          //         ),
          //       ),
          //       SizedBox(width: 50),
          //       Text(App_Localization.of(context)!.translate("reviews"),
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               decoration: productController.selected.value==1 ?
          //               TextDecoration.underline : TextDecoration.none
          //           )
          //       ),
          //     ],
          //   ),
          // ),
          _review_detail(context),
        ],
      ),
    );
  }
  _review_detail(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        children: [
          _post_review(context),
          Row(
              children: [
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("reviews"),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 10),
                Center(
                  child: Text(
                    "("+product_data.review.length.toString()+")",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ]),
          SizedBox(height: 25),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: product_data.review.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _list_reviews(context,index),
                      SizedBox(height: 10,)
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
  _post_review(BuildContext context){
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width*0.93,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: TextField(
              controller: productController.review_controller,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
               hintText: App_Localization.of(context)!.translate("add_yours"),
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.white,
                        width: 2.0),
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0),
                ),
              ),
              style:  TextStyle(color: Colors.white),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width*0.2,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  if(Global.customer==null){
                    Get.offAll(Registration());
                  }else{
                    if(productController.review_controller.text.isNotEmpty){
                      productController.loading.value=true;
                      Api.check_internet().then((net) {
                        if(net){
                          Api.add_review(Global.customer!.id, product_data.product.id, productController.review_controller.text);
                          List<Review> reviews = <Review>[];
                          reviews.add(Review(id: -1, priductId: product_data.product.id, customerId: Global.customer!.id, body: productController.review_controller.text, customer: Global.customer!.firstname));
                          reviews.addAll(product_data.review);
                          product_data.review.clear();
                          product_data.review.addAll(reviews);
                          productController.review_controller.clear();
                          productController.loading.value=false;
                        }else{
                          Get.to(NoInternet())!.then((value) {
                            Api.add_review(Global.customer!.id, product_data.product.id, productController.review_controller.text);
                          });
                        }
                      });


                    }
                  }
                },
                child: Padding(padding: EdgeInsets.all(8),child: Text(App_Localization.of(context)!.translate("post"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
            ),
          )
        ],
      ),
    );
  }
  _list_reviews(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text( product_data.review[index].customer,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),)),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      product_data.review[index].body
                      ,style: TextStyle(color: Colors.white , fontSize: 14),),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  _btm_sheet_desc(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context)
      {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(App_Localization.of(context)!.translate("description"),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close,color: Colors.white,))

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Divider(
                  thickness: 2,
                  color: Colors.white12,
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product_data.product.bodtHtml,style: TextStyle(color: Colors.white,fontSize: 17,height: 2),)
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}



