import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../core/widgets/product_box.dart';
import '../data/sqldb.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<List<Map>> readData() async {
    List<Map> response = await SqlDb().readData("SELECT * FROM favorite");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('المفضلة'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: FutureBuilder(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
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
                      id: int.parse(snapshot.data![index]['product_id']),
                      image: snapshot.data![index]['image'],
                      title: snapshot.data![index]['title'],
                      desc: snapshot.data![index]['desc'],
                      price: snapshot.data![index]['price'],
                      created: snapshot.data![index]['created'],
                      userId: snapshot.data![index]['userId'],
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
