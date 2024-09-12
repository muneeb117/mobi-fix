import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobi_fix/presentation/profile/screens/profile_screen.dart';

import '../../../core/theme/app_colors.dart';

Widget buildPage(index) {
  List<Widget> widgets = [
    const ProfileScreen()
    //  const DraftsScreen(),
    // const ProfileScreen(),
  ];
  return widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Refine AI",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset("assets/icons/nav-icon-ai.svg"),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        // Center the icon within the container
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/nav-icon-ai.svg",
            colorFilter: const ColorFilter.mode(
                AppColors.surface, BlendMode.srcIn), // Icon color when active
          ),
        ),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Draft",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset("assets/icons/nav-icon-draft.svg"),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        // Center the icon within the container
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/nav-icon-draft.svg",
            colorFilter: const ColorFilter.mode(
                AppColors.surface, BlendMode.srcIn), // Icon color when active
          ),
        ),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset("assets/icons/nav-icon-profile.svg"),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        // Center the icon within the container
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/nav-icon-profile.svg",
            colorFilter: const ColorFilter.mode(
                AppColors.surface, BlendMode.srcIn), // Icon color when active
          ),
        ),
      ),
    ),
  )
];
