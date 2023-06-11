import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagesSlider extends StatefulWidget {
  final List urlImages;
  final double height;
  const ImagesSlider(
      {super.key, required this.urlImages, required this.height});

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  final controller = CarouselController();

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.urlImages.length,
          itemBuilder: (context, index, realindex) {
            final urlImage = widget.urlImages[index];
            return buildImage(urlImage, index);
          },
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            height: widget.height,
            autoPlay: false,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        ),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(urlImage),
            fit: BoxFit.cover,
          ),
        ),
      );
}
