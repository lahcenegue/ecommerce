import 'package:ecommerce/core/widgets/button_favorite.dart';
import 'package:flutter/material.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          //ButtonFavorite(id: id, title: title, image: image, created: created, price: price, desc: desc, userId: userId)
          Icon(Icons.favorite),
          Icon(Icons.share_rounded)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [],
      ),
    );
  }
}
