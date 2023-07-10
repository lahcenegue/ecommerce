class SubCatModel {
  List<SubCat>? subCat;

  SubCatModel({
    this.subCat,
  });
  SubCatModel.fromJson(Map<String, dynamic> json) {
    if (json['sub'] != null) {
      subCat = <SubCat>[];
      json['sub'].forEach(
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
    name = json['name'];
  }
}
