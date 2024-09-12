import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../core/global/widgets/toast_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user.dart' as user_model;
import '../../../main/global.dart';
import '../../../main/navigation/routes/name.dart';
import '../../../utils/app_constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

GestureDetector buildThirdPartyWidget(
    {required String iconPath, Function()? onPressed, required String text}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        height: 40.h,
        width: 145.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(
              width: 5.w,
            ),
            Text(text),
          ],
        )),
  );
}

class ThirdPartyPlugins extends StatefulWidget {
  const ThirdPartyPlugins({super.key});

  @override
  State<ThirdPartyPlugins> createState() => _ThirdPartyPluginsState();
}

class _ThirdPartyPluginsState extends State<ThirdPartyPlugins> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void _toggleLoading(bool value) {
    _isLoading.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoading, child) {
        return Column(
          children: [
            if (isLoading)
              Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 35.r,
                ),
              ),
            if (!isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildThirdPartyWidget(
                    iconPath: "assets/icons/google-filled.svg",
                    onPressed: () {
                      _toggleLoading(true);
                      GoogleAuthentication()
                          .signInWithGoogle(context, _toggleLoading);
                    },
                    text: 'Google',
                  ),
                  SizedBox(width: 10.h),
                ],
              ),
          ],
        );
      },
    );
  }
}

class GoogleAuthentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithGoogle(
      BuildContext context, Function(bool) toggleLoading) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        toggleLoading(false); // Stop loading when user cancels the login
        return;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await storeUserDataInFirestore(user, context);
      }
      toggleLoading(false);
    } catch (error) {
      toggleLoading(false);
    }
  }
}

Future<void> storeUserDataInFirestore(
    User firebaseUser, BuildContext context) async {
  user_model.User newUser = user_model.User(
    name: firebaseUser.displayName ?? "",
    id: firebaseUser.uid,
    imageUrl: firebaseUser.photoURL ?? "",
    email: firebaseUser.email ?? "",
  );

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .set(newUser.toJson());
    String? token = await firebaseUser.getIdToken();
    if (token != null) {
      await Global.storageServices
          .setString(AppConstants.STORAGE_USER_TOKEN_KEY, token);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.application, (route) => false);
    }
  } catch (e) {
    showToast(msg: e.toString());
  }
}
