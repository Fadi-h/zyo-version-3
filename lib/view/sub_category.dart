import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zyo_version_1/const/app_colors.dart';
import 'package:zyo_version_1/const/app_localization.dart';
import 'package:zyo_version_1/const/global.dart';
import 'package:zyo_version_1/controller/cart_controller.dart';
import 'package:zyo_version_1/controller/home_controller.dart';
import 'package:zyo_version_1/controller/sub_category_controller.dart';
import 'package:zyo_version_1/controller/wishlist_controller.dart';
import 'package:zyo_version_1/model/product.dart';
import 'package:zyo_version_1/view/cart.dart';
import 'package:zyo_version_1/view/product.dart';

class SubCategoryView extends StatelessWidget {
  String title;
  RxList<Product> products;
  SubCategoryView(this.title, this.products){
    subCategoryController.products=this.products;
  }

  SubCategoryController subCategoryController = Get.put(SubCategoryController());
  CartController cartController = Get.find();
  HomeController homeController = Get.find();
  WishListController wishListController = Get.find();

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
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Row(
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
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          )
                      )
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            )),
                      )
                    ],
                  ),
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
                      GestureDetector(
                        onTap: () {
                          //todo something
                        },
                        child: SvgPicture.asset('assets/icons/sort.svg',
                          width: 20,height: 20,
                        ),
                      )
                    ],
                  ),
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
                                height: 45,
                                width: 20,
                                child: Icon(Icons.shopping_bag_outlined,color: Colors.white,)),
                          ),
                        ],
                      ),
                      Positioned(
                          top: 25,
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
      ),
          Divider(
            thickness: 2,
            color: AppColors.main2,
          )
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.57,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10
            ),
            itemCount: subCategoryController.products.length,
            itemBuilder: (BuildContext ctx, index) {
              return _list_products(context,index);
            }),
      ),
    );
  }
  _list_products(BuildContext context, int index) {
    return Column(
      children: [
        Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
                homeController.go_to_product_page(subCategoryController.products[index].id);
              },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(subCategoryController.products[index].image.toString().replaceAll("localhost", "10.0.2.2")),
                      fit: BoxFit.cover
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(() => GestureDetector(
                        onTap: () {
                          if(!subCategoryController.products[index].favorite.value){
                            subCategoryController.products[index].likes.value++;
                            wishListController.add_to_wishlist(subCategoryController.products[index], context);
                            subCategoryController.products[index].favorite.value=true;
                          }else{
                            subCategoryController.products[index].likes.value--;
                            wishListController.delete_from_wishlist(subCategoryController.products[index]);
                            subCategoryController.products[index].favorite.value=false;
                          }
                        },
                        child: !subCategoryController.products[index].favorite.value
                            ? Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 25,
                        )
                            : Icon(
                          Icons.favorite_outlined,
                          color: AppColors.main,
                          size: 25,
                        ),
                      ))
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 1,
          child: _price(context,index),),
        Expanded(
          child: _title(context,index),),
      ],
    );
  }
  _price(BuildContext context,int index) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text((subCategoryController.products[index].price*Global.currency_covert).toStringAsFixed(2)+" "+App_Localization.of(context)!.translate(Global.currency_code),
          style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),),
      ),
    );
  }
  _title(BuildContext context,int index) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          child: Text(subCategoryController.products[index].title.toString(),
            maxLines: 2,
            style: TextStyle(
                color: Colors.white,
              fontSize: 10
            ),),
        ),
      ),
    );
  }
  _pressed_on_search(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(suggestion_list: Global.suggestion_list,homeController: homeController));
    // homeController.get_products_by_search(result!, context);
    homeController.go_to_search_page(result!);

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
    // homeController.go_to_search_page(query);
    // close(context, query);
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

