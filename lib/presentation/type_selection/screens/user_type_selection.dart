import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main/global.dart';
import '../../../utils/app_constant.dart';
import '../../../main/navigation/routes/name.dart';
import '../../../core/theme/app_colors.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  _UserTypeSelectionScreenState createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image from assets
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-photo.jpg', // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay to enhance text and button visibility
          Positioned.fill(
            child: Container(
              color: Colors.black
                  .withOpacity(0.4), // Dark overlay with transparency
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Are you a mechanic or a customer?",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 18.sp,
                          color: Colors.white, // White text color to stand out
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 40.h),

                  // Mechanic button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUserType = 'mechanic';
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border:
                            Border.all(color: AppColors.secondary, width: 2),
                        color: selectedUserType == 'mechanic'
                            ? AppColors.secondary // Filled when selected
                            : Colors
                                .transparent, // Transparent when not selected
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "I am a Mechanic",
                        style: TextStyle(
                          color: selectedUserType == 'mechanic'
                              ? Colors.white // Text color when selected
                              : AppColors
                                  .primary, // Text color when not selected
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Customer button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUserType = 'customer';
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border:
                            Border.all(color: AppColors.secondary, width: 2),
                        color: selectedUserType == 'customer'
                            ? AppColors.secondary // Filled when selected
                            : Colors
                                .transparent, // Transparent when not selected
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "I am a Customer",
                        style: TextStyle(
                          color: selectedUserType == 'customer'
                              ? Colors.white // Text color when selected
                              : AppColors
                                  .primary, // Text color when not selected
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Continue button
                  ElevatedButton(
                    onPressed: selectedUserType == null
                        ? null
                        : () {
                            Global.storageServices
                                .setUserType(selectedUserType!);
                            // Navigate to the registration screen
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppRoutes.register, (route) => false);
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
