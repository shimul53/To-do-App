import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:todo_app/models/onboarding_info.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/images/onboard1.png', 'Create your schedule',
        'Make your important schedule well organized at work to make your work easier later.'),
    OnboardingInfo('assets/images/onboard2.png', 'Easily Manage Task',
        'You can easily organize your work and schedule properly so that you are more comfortable while doing work'),
    OnboardingInfo('assets/images/onboard3.png', 'Ready Start Your Day',
        'And after all your schedule has been arranged properly and neatly,now you are ready to start the day with fun .Enjoy your day.')
  ];
}
