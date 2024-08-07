import 'package:flutter/material.dart';
import 'package:horizontal_image_carousel/Resources/Asstes.dart';

class ImageSlider extends StatefulWidget {
  final ImageSliderViewModel viewModel;

  ImageSlider({required this.viewModel});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToPrevious() {
    if (currentIndex > 0) {
      _pageController.animateToPage(
        currentIndex - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void goToNext() {
    if (currentIndex < (widget.viewModel.images.length - 1)) {
      _pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 8,
            width: double.infinity,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.viewModel.images.length,
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 240,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              widget.viewModel.images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.withOpacity(0.2),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 48,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentIndex != 0)
                        IconButton(
                          onPressed: goToPrevious,
                          icon: const SizedBox(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage(Assets.leftIcon),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      const Spacer(),
                      if ((widget.viewModel.images.length - 1) != currentIndex)
                        IconButton(
                          onPressed: goToNext,
                          icon: const SizedBox(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage(Assets.rightIcon),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSliderViewModel extends ChangeNotifier {
  List<String> images = [
    'https://picsum.photos/id/1/200/300',
    'https://picsum.photos/id/12/200/300',
    'https://picsum.photos/id/10/200/300',
    // Add more images as needed
  ];
}
