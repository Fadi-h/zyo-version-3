import 'package:get/get.dart';

class ProductData {
  ProductData({
    required this.product,
    required this.review,
    required this.subProduct,
  });
  late final Product product;
  late final List<Review> review;
  late final List<SubProduct> subProduct;

  ProductData.fromJson(Map<String, dynamic> json){
    product = Product.fromJson(json['product']);
    review = List.from(json['review']).map((e)=>Review.fromJson(e)).toList();
    subProduct = List.from(json['sub_product']).map((e)=>SubProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.toJson();
    _data['review'] = review.map((e)=>e.toJson()).toList();
    _data['sub_product'] = subProduct.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
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
    required this.likes
  });
  late final String bodtHtml;
  late final int id;
   Rx<int> likes=0.obs;
  late final int subCategoryId;
  late final String title;
  late final String subTitle;
  late final Description description;
  late final String image;
  late final String search;
  late final int availability;
  late final double price;
  int ratingCount=0;
  double rate=0.0;
  late final int commingSoon;
  Rx<bool> favorite=false.obs;
  String cart_details = "";

  Product.fromJson(Map<String, dynamic> json){
    bodtHtml = json['bodt_html']==null?"":json['bodt_html'];
    id = json['id'];
    likes = json['likes']==null?0.obs:int.parse(json['likes'].toString()).obs;
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = Description.fromJson(json['description']);
    image = json['image'];
    search = json['search'];
    cart_details = json['cart_details']==null?"":json['cart_details'];
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
    _data['cart_details'] = cart_details;
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

class Review {
  Review({
    required this.id,
    required this.priductId,
    required this.customerId,
    required this.body,
    required this.customer,
  });
  late final int id;
  late final int priductId;
  late final int customerId;
  late final String body;
  late final String customer;

  Review.fromJson(Map<String, dynamic> json){
    id = json['id'];
    priductId = json['priduct_id'];
    customerId = json['customer_id'];
    body = json['body'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['priduct_id'] = priductId;
    _data['customer_id'] = customerId;
    _data['body'] = body;
    _data['customer'] = customer;
    return _data;
  }
}

class Size {
  Size({
    required this.id,
    required this.productId,
    required this.title,
    required this.details,
    required this.availability,
  });
  late final int id;
  late final int productId;
  late final int availability;
  late final String title;
  late final String details;

  Size.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    details = json['details'];
    availability = json['availability']==null?0:json['availability'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['title'] = title;
    _data['details'] = details;
    _data['availability'] = availability;
    return _data;
  }
}

class SubProduct {
  SubProduct({
    required this.id,
    required this.productId,
    required this.colorId,
    required this.color,
    required this.degree,
    required this.images,
    required this.size,

  });
  late final List<Size> size;
  late final int id;
  late final int productId;
  late final int colorId;
  late final String color;
  late final String degree;
  late final List<Images> images;

  SubProduct.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    color = json['color'];
    degree = json['degree'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    size = List.from(json['size']).map((e)=>Size.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['color_id'] = colorId;
    _data['color'] = color;
    _data['degree'] = degree;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['size'] = size.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.subProductId,
    required this.link,
  });
  late final int id;
  late final int subProductId;
  late final String link;

  Images.fromJson(Map<String, dynamic> json){
    id = json['id'];
    subProductId = json['sub_product_id'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sub_product_id'] = subProductId;
    _data['link'] = link;
    return _data;
  }
}