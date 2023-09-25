import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../core/widgets/product_box.dart';
import '../data/search_api.dart';
import '../models/ads_model.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'أدخل كلمة البحث';

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: FutureBuilder(
        future: apiSearch(query: query),
        builder:
            (BuildContext context, AsyncSnapshot<List<AdsModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            print('=================================');
            print(snapshot.data!.length);
            print('=================================');
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (buildContext, index) {
                return const SizedBox(height: 20);
              },
              itemBuilder: (buildContext, index) {
                return MasonryGridView.builder(
                    physics: const BouncingScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return productBox(
                        widthSceeren: widthScreen,
                        id: snapshot.data![index].id!,
                        image: snapshot.data![index].images![0],
                        title: snapshot.data![index].title!,
                        desc: snapshot.data![index].desc!,
                        price: snapshot.data![index].price!,
                        created: snapshot.data![index].created!,
                        userId: snapshot.data![index].userId!,
                      );
                    });
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
