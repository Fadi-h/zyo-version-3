import 'package:zyo_version_1/model/product.dart';

class HomePage {
  HomePage({
    required this.category,
    required this.slider,
    required this.comingSoon,
    required this.flashSale,
    required this.home_page_products,
    required this.new_products,
    required this.ages,
    required this.unisex,
  });
  late final List<Category> category;
  late final List<MySlider> slider;
  late final List<ComingSoon> comingSoon;
  late final List<FlashSale> flashSale;
  late final List<Product> home_page_products;
  late final List<Product> new_products;
  late final List<Brands> ages;
  late final List<Brands> unisex;

  HomePage.fromJson(Map<String, dynamic> json){
    category = List.from(json['category']).map((e)=>Category.fromJson(e)).toList();
    slider = List.from(json['slider']).map((e)=>MySlider.fromJson(e)).toList();
    comingSoon = List.from(json['coming_soon']).map((e)=>ComingSoon.fromJson(e)).toList();
    flashSale = List.from(json['flash_sale']).map((e)=>FlashSale.fromJson(e)).toList();
    home_page_products = List.from(json['home_page_product']).map((e)=>Product.fromJson(e)).toList();
    new_products = List.from(json['new']).map((e)=>Product.fromJson(e)).toList();
    ages = List.from(json['brands']).map((e)=>Brands.fromJson(e)).toList();
    unisex = List.from(json['unisex']).map((e)=>Brands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category.map((e)=>e.toJson()).toList();
    _data['slider'] = slider.map((e)=>e.toJson()).toList();
    _data['coming_soon'] = comingSoon.map((e)=>e.toJson()).toList();
    _data['flash_sale'] = flashSale.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Brands {
  Brands({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;

  Brands.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}

class MySlider {
  MySlider({
    required this.id,
    required this.title,
    required this.image,
    required this.productId,
  });
  late final int id;
  late final String title;
  late final String image;
  late final int productId;

  MySlider.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['product_id'] = productId;
    return _data;
  }
}

class ComingSoon {
  ComingSoon({
    required this.bodtHtml,
    required this.id,
    required this.subCategoryId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
    required this.search,
    required this.availability,
    required this.price,
    required this.ratingCount,
    required this.rate,
    required this.commingSoon,
  });
  late final String bodtHtml;
  late final int id;
  late final int subCategoryId;
  late final String title;
  late final String subTitle;
  late final Description description;
  late final String image;
  late final String search;
  late final int availability;
  late final double price;
  late final int ratingCount;
  late final double rate;
  late final int commingSoon;

  ComingSoon.fromJson(Map<String, dynamic> json){
    bodtHtml = json['bodt_html'];
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = Description.fromJson(json['description']);
    image = json['image'];
    search = json['search'];
    availability = json['availability'];
    price = double.parse(json['price'].toString());
    ratingCount = json['rating_count'];
    rate = double.parse(json['rate'].toString());
    commingSoon = json['comming_soon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bodt_html'] = bodtHtml;
    _data['id'] = id;
    _data['sub_category_id'] = subCategoryId;
    _data['title'] = title;
    _data['sub_title'] = subTitle;
    _data['description'] = description.toJson();
    _data['image'] = image;
    _data['search'] = search;
    _data['availability'] = availability;
    _data['price'] = price;
    _data['rating_count'] = ratingCount;
    _data['rate'] = rate;
    _data['comming_soon'] = commingSoon;
    return _data;
  }
}

class Description {
  Description({
    required this.type,
    required this.data,
  });
  late final String type;
  late final List<int> data;

  Description.fromJson(Map<String, dynamic> json){
    type = json['type'];
    data = List.castFrom<dynamic, int>(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['data'] = data;
    return _data;
  }
}

class FlashSale {
  FlashSale({
    required this.id,
    required this.subCategoryId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
    required this.search,
    required this.availability,
    required this.price,
    required this.ratingCount,
    required this.rate,
    required this.commingSoon,
    required this.productId,
    required this.oldPrice,
  });
  late final int id;
  late final int subCategoryId;
  late final String title;
  late final String subTitle;
  late final Description description;
  late final String image;
  late final String search;
  late final int availability;
  late final double price;
  late final int ratingCount;
  late final double rate;
  late final int commingSoon;
  late final int productId;
  late final int oldPrice;

  FlashSale.fromJson(Map<String, dynamic> json){
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = Description.fromJson(json['description']);
    image = json['image'];
    search = json['search'];
    availability = json['availability'];
    price = double.parse(json['price'].toString());
    ratingCount = json['rating_count'];
    rate = double.parse(json['rate'].toString());
    commingSoon = json['comming_soon'];
    productId = json['product_id'];
    oldPrice = json['old_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sub_category_id'] = subCategoryId;
    _data['title'] = title;
    _data['sub_title'] = subTitle;
    _data['description'] = description.toJson();
    _data['image'] = image;
    _data['search'] = search;
    _data['availability'] = availability;
    _data['price'] = price;
    _data['rating_count'] = ratingCount;
    _data['rate'] = rate;
    _data['comming_soon'] = commingSoon;
    _data['product_id'] = productId;
    _data['old_price'] = oldPrice;
    return _data;
  }
}