class SubCategoryList {
  SubCategoryList({
    required this.subCategory,
  });
  late final List<SubCategory> subCategory;

  SubCategoryList.fromJson(Map<String, dynamic> json){
    subCategory = List.from(json['sub_category']).map((e)=>SubCategory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sub_category'] = subCategory.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
  });
  late final int id;
  late final String title;
  late final String image;
  late final int categoryId;

  SubCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['category_id'] = categoryId;
    return _data;
  }
}