import '../models/categories_model.dart';

class CategoriesViewModel {
  final CategoriesModel _categoriesModel;
  CategoriesViewModel({required CategoriesModel categoriesModel})
      : _categoriesModel = categoriesModel;

  int? get id {
    return _categoriesModel.id;
  }

  String? get name {
    return _categoriesModel.name;
  }

  List<SubCat>? get subCat {
    List<SubCat> subCatList = [];
    if (_categoriesModel.subCat!.isNotEmpty) {
      for (int i = 0; i < _categoriesModel.subCat!.length; i++) {
        subCatList.add(_categoriesModel.subCat![i]);
      }
    }
    return subCatList;
  }
}
