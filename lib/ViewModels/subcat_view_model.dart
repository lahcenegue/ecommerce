import '../models/subcat_model.dart';

class SubCategoryViewModel {
  final SubCatModel _subcategoruModel;
  SubCategoryViewModel({required SubCatModel subcategoryModel})
      : _subcategoruModel = subcategoryModel;

  List<SubCat>? get subCat {
    List<SubCat> subCatList = [];
    if (_subcategoruModel.subCat != null) {
      if (_subcategoruModel.subCat!.isNotEmpty) {
        for (int i = 0; i < _subcategoruModel.subCat!.length; i++) {
          subCatList.add(_subcategoruModel.subCat![i]);
        }
      }
    }

    return subCatList;
  }
}
