class CategoriesModel {
  int? id;
  String? name;
  List<SubCat>? subCat;

  CategoriesModel({
    this.id,
    this.name,
    this.subCat,
  });
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['category_name'];

    if (json['sub_cat'] != null) {
      subCat = <SubCat>[];
      json['sub_cat'].forEach(
        (v) {
          subCat!.add(SubCat.fromJson(v));
        },
      );
    }
  }
}

class SubCat {
  int? id;
  String? name;
  SubCat({
    this.id,
    this.name,
  });
  SubCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json[name];
  }
}
