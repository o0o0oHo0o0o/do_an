import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:weather/UI/chat_home/chat_home.dart';
import 'package:weather/UI/weather_home/weather_home_screen.dart';
class MyPageView extends StatefulWidget {
  @override
  _MyPageView createState() => _MyPageView();
}

class _MyPageView extends State<MyPageView> {
  final PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
            children: [
              ChatHome(),
              WeatherHome(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CirclePageIndicator(
            itemCount: 2, // Số lượng trang
            currentPageNotifier: _currentPageNotifier,
          ),
        ),
      ],
    );
  }
}
