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

  List<String>? get subCatName {
    List<String> subCatNames = [];
    if (_categoriesModel.subCat!.isNotEmpty) {
      for (int i = 0; i < _categoriesModel.subCat!.length; i++) {
        subCatNames.add(_categoriesModel.subCat![i].name!);
      }
    }
    return subCatNames;
  }

  List<int>? get subCatId {
    List<int> subCatId = [];
    if (_categoriesModel.subCat!.isNotEmpty) {
      for (int i = 0; i < _categoriesModel.subCat!.length; i++) {
        subCatId.add(_categoriesModel.subCat![i].id!);
      }
    }
    return subCatId;
  }
}
