import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('الأقسام'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              AppBar().preferredSize.height,
            ),
            child: Container(
              height: heightScreen * 0.07,
              color: Colors.red,
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(),
                tabs: [
                  Tab(text: 'الأقسام'),
                  Tab(text: 'المواد'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          Text('1'),
          Text('2'),
        ]),
      ),
    );
  }
}
