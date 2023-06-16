import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      body: FutureBuilder(
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
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductView(product: product),
                      //   ),
                      // );
                    },
                    child: SizedBox(
                      width: widthScreen * 0.45,
                      height: heightScreen * 0.35,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: heightScreen * 0.22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(08),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data![index]['image']),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              // Positioned(
                              //   top: 0,
                              //   right: 0,
                              //   child: ButtonFavorite(
                              //     id: snapshot.data![index]['product_id'],
                              //     title: snapshot.data![index]['name'],
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${snapshot.data![index]['price']} AEU',
                                        textScaleFactor: 1.2,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${snapshot.data![index]['regulare_price']} AEU',
                                        textScaleFactor: 1.2,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 05),
                                FittedBox(
                                  child: Text(
                                    'Only ${snapshot.data![index]['stock_quantity']} left',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data![index]['name'],
                                  textScaleFactor: 1.2,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
