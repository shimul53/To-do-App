import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        activeBulletColor: Color(0xFFFFB746),
        inactiveBulletColor: Colors.white,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Get.to(()=>HomePage());
        },
        finishCallback: () {
          Get.to(()=>HomePage());
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/images/onboard1.png',
        title: 'Create your schedule',
        body: 'Make your important schedule well organized at work to make your work easier later.',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/onboard2.png',
        title: 'Easily Manage Task',
        body: 'You can easily organize your work and schedule properly so that you are more comfortable while doing work',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/images/onboard3.png',
        title: 'Ready Start Your Day',
        body: 'And after all your schedule has been arranged properly and neatly,now you are ready to start the day with fun .Enjoy your day.',
        doAnimateImage: true),

  ];
}
