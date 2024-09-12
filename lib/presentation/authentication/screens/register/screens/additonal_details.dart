import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/global/widgets/app_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/global/widgets/reusable_button.dart';
import '../../../../../main/global.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../../../widgets/build_text_field.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({Key? key}) : super(key: key);

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  String expertise = '';
  String inventory = '';
  String vehicleMake = '';
  String vehicleModel = '';
  String vehicleVariant = '';
  bool isLoading = false;

  Future<void> _submitDetails() async {
    setState(() {
      isLoading = true;
    });

    final userType = Global.storageServices.getUserType();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      if (userType == 'mechanic') {
        await FirebaseFirestore.instance
            .collection('mechanics')
            .doc(userId)
            .update({
          'expertise': expertise,
          'inventory': inventory.split(',').map((e) => e.trim()).toList(),
        });
      } else if (userType == 'customer') {
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(userId)
            .update({
          'vehicle_make': vehicleMake,
          'vehicle_model': vehicleModel,
          'vehicle_variant': vehicleVariant,
        });
      }

      // Navigate to login after saving details
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (route) => false);
    } catch (e) {
      print("Error saving details: $e");
      // Show error message if needed
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType =
        Global.storageServices.getUserType(); // Get user type from storage

    return Scaffold(
      appBar: BuildAppBar(
        appBarTitle: 'Additional Details',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Write Addional Details Here Before Sign Up...',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 40.h,
              ),
              if (userType == 'mechanic') ...[
                BuildTextField(
                  text: 'Expertise',
                  textType: TextInputType.text,
                  iconName: 'expertize',
                  onValueChange: (value) {
                    setState(() {
                      expertise = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                BuildTextField(
                  text: 'Inventory (comma-separated)',
                  textType: TextInputType.text,
                  iconName: 'inventory',
                  onValueChange: (value) {
                    setState(() {
                      inventory = value;
                    });
                  },
                ),
              ] else if (userType == 'customer') ...[
                BuildTextField(
                  text: 'Vehicle Make',
                  textType: TextInputType.text,
                  iconName: 'vehicle',
                  onValueChange: (value) {
                    setState(() {
                      vehicleMake = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                BuildTextField(
                  text: 'Vehicle Model',
                  textType: TextInputType.text,
                  iconName: 'vehicle',
                  onValueChange: (value) {
                    setState(() {
                      vehicleModel = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                BuildTextField(
                  text: 'Vehicle Variant',
                  textType: TextInputType.text,
                  iconName: 'vehicle',
                  onValueChange: (value) {
                    setState(() {
                      vehicleVariant = value;
                    });
                  },
                ),
              ],
              SizedBox(height: 20.h),
              ReusableButton(
                gradient: AppColors.secondaryGradient,
                text: isLoading ? "Saving..." : "Submit",
                onPressed: isLoading ? null : _submitDetails,
                isLoading: isLoading,
                isIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
