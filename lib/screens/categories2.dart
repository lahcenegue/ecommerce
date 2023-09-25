import 'package:ecommerce/ViewModels/categories_viewmodel.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/homeViewModel/home_view_model.dart';
import 'package:ecommerce/models/categories_model.dart';
import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/search_screen.dart';
import 'package:ecommerce/screens/subcategory_ads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories2 extends StatefulWidget {
  const Categories2({super.key});

  @override
  State<Categories2> createState() => _Categories2State();
}

class _Categories2State extends State<Categories2> {
  int id = 0;
  List<CategoriesViewModel> categorie = [];
  List<SubCat> subCategories = [];

  @override
  Widget build(BuildContext context) {
    categorie = Provider.of<HomeViewModel>(context).listCategories!;
    subCategories =
        Provider.of<HomeViewModel>(context).listCategories![id].subCat!;
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('الأقسام'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: heightScreen,
            width: widthScreen * 0.35,
            color: Colors.grey[300],
            child: ListView.separated(
              itemCount: categorie.length,
              separatorBuilder: (context, index) => const Divider(
                indent: 10,
                endIndent: 10,
              ),
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      id = categorie.indexOf(categorie[index]);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categorie[index].name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: id == categorie.indexOf(categorie[index])
                            ? widthScreen * 0.05
                            : widthScreen * 0.04,
                        color: id == categorie.indexOf(categorie[index])
                            ? AppColors.primary
                            : AppColors.secondary,
                        fontWeight: id == categorie.indexOf(categorie[index])
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
              height: heightScreen,
              width: widthScreen * 0.65,
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemCount: subCategories.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: widthScreen * 0.05),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SubCategoryAds(
                            title: subCategories[index].name!,
                            id: subCategories[index].id!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: widthScreen * 0.2,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(subCategories[index].name!),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
