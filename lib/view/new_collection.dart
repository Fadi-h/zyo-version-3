import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/controller/cart_controller.dart';
import 'package:zyo_version_1/controller/home_controller.dart';
import 'package:zyo_version_1/controller/new_coll_controller.dart';
import 'package:zyo_version_1/view/cart.dart';
import 'package:zyo_version_1/view/product.dart';

class NewCollection extends StatelessWidget {
  NewCollection({Key? key}) : super(key: key);

  NewCollectionController newCollectionController = Get.put(NewCollectionController());
  HomeController homeController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.main,
      body: WillPopScope(
        onWillPop: homeController.onWillPop,
        child: Obx((){
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.main,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _new_collection(context),
                        _products(context)
                      ],
                    ),
                  ),
                ),
                Positioned(child: homeController.loading.value?Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  ),
                ):Center())
              ],
            ),
          );
        }),
      )
    );
  }

  _new_collection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/new_collection/Mask Group 3.png")
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(context),
          Center(
            child: Text(App_Localization.of(context)!.translate("new_collection"),
             style: TextStyle(
               color: Colors.white,
               fontSize: 25,
               fontWeight: FontWeight.bold
             )),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
}
  _header(BuildContext context) {
    return Container(

        width: MediaQuery.of(context).size.width * 0.93,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.select_nav_bar.value = 3;
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
                    SizedBox(width: 10),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: newCollectionController.search_controller,
                            cursorColor: Colors.grey,
                            onSubmitted: (query){
                              homeController.go_to_search_page_with_loading(query);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                fillColor: Colors.white70.withOpacity(0.4),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12,width: 0.5),
                                ),
                                hintText: App_Localization.of(context)!.translate("search"),
                                contentPadding: EdgeInsets.all(5),
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 20)
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
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
                )
              ],
            ),
          ],
        )
    );
  }
  _products(BuildContext context) {
    return  Padding(
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
            itemCount: homeController.homePage.new_products.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: (){
                  homeController.go_to_product_page(homeController.homePage.new_products[index].id);
                },
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  homeController.homePage.new_products[index].image.toString()
                              ),
                              fit: BoxFit.cover
                          ),
                        ),

                      ),),
                    Expanded(
                        flex:1,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(( homeController.homePage.new_products[index].price*Global.currency_covert).toStringAsFixed(2)+" "+App_Localization.of(context)!.translate(Global.currency_code),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(( homeController.homePage.new_products[index].title),
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
                ),
              );
            }),
      ),
    );
  }

}
