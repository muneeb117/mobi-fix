import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/widgets/build_dot.dart';
import '../../../core/global/widgets/reusable_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../main/global.dart';
import '../../../main/navigation/routes/name.dart';
import '../../../utils/app_constant.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  state.page = index;
                  BlocProvider.of<OnBoardingBloc>(context)
                      .add(OnBoardingEvent());
                },
                children: [
                  onBoardingScreen(
                    1,
                    'Next',
                    'Welcome to Mob Fix',
                    'Your go-to app for real-time vehicle repair and maintenance services',
                    'assets/images/splash_1.jpg',
                    context,
                  ),
                  onBoardingScreen(
                    2,
                    'Next',
                    'Real-Time & Scheduled Services',
                    'Book a mechanic in real-time or schedule for later, based on your convenience',
                    'assets/images/splash_2.jpg',
                    context,
                  ),
                  onBoardingScreen(
                    3,
                    'Next',
                    'Expert Mechanics at Your Service',
                    'From electrical to mechanical repairs, our experts cover it all..',
                    'assets/images/splash_3.jpg',
                    context,
                  ),
                  onBoardingScreen(
                    4,
                    'Get Started',
                    'Track Your Service',
                    'Live tracking, updates, and seamless communication throughout the service.',
                    'assets/images/splash_4.jpg',
                    context,
                  ),
                ],
              ),
              Positioned(
                bottom: mediaQuery.size.height * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => buildDot(index, state.page),
                  ),
                ),
              ),
              Positioned(
                bottom: mediaQuery.size.height * 0.05,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ReusableButton(
                        iconAssetPath: 'assets/icons/Small-Arrow-Right.svg',
                        gradient: AppColors.gradient,
                        onPressed: () {
                          if (state.page < 3) {
                            pageController.animateToPage(state.page + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          } else {
                            Global.storageServices.setBool(
                                AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME,
                                true);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.userTypeSelection, (route) => false);
                          }
                        },
                        text: state.page < 3 ? "Next" : "Get Started",
                        isIcon: true,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () {
                        Global.storageServices.setBool(
                            AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.userTypeSelection, (route) => false);
                      },
                      child: Text(
                        "Skip",
                        style: textTheme.labelMedium!.copyWith(
                          color: AppColors.surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget onBoardingScreen(
  int index,
  String buttonName,
  String title,
  String subtitle,
  String imagePath,
  BuildContext context,
) {
  final textTheme = Theme.of(context).textTheme;
  final mediaQuery = MediaQuery.of(context);

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
            top: mediaQuery.size.height * 0.1, left: 40.h, right: 40.h),
        height: mediaQuery.size.height * 0.4,
        width: mediaQuery.size.width * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Image.asset(imagePath),
      ),
      Container(
        margin: EdgeInsets.only(top: 20.h, left: 50.w, right: 50.w),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.titleLarge!,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium!.copyWith(
            color: AppColors.disable,
          ),
        ),
      ),
    ],
  );
}
