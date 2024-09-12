import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/global/widgets/toast_info.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';

class AuthenticationController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, String name, String userType, BuildContext context) async {
    try {
      // Step 1: Register the user in Firebase Authentication
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.sendEmailVerification();

      // Step 2: Add basic user info to Firestore (without additional details)
      if (userType == 'mechanic') {
        await firestore.collection("mechanics").doc(userCredential.user!.uid).set({
          'id': userCredential.user!.uid,
          'name': name,
          'email': email,
          'expertise': '', // Placeholder for later input
          'inventory': [], // Placeholder for later input
          'imageUrl': '', // Placeholder for profile image
        });
      } else {
        await firestore.collection("customers").doc(userCredential.user!.uid).set({
          'id': userCredential.user!.uid,
          'name': name,
          'email': email,
          'vehicles': [], // Placeholder for vehicle details later
          'imageUrl': '', // Placeholder for profile image
        });
      }

      // Step 3: Move to AdditionalDetailsScreen for additional input

      // Stop loading
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
    } on firebase_auth.FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      switch (e.code) {
        case 'weak-password':
          errorMessage = "The password provided is too weak.";
          break;
        case 'email-already-in-use':
          errorMessage = "An account already exists for that email.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
      // Stop loading and show error message
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
      showToast(msg: errorMessage);
    } catch (e) {
      // Stop loading and show error message
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
      showToast(msg: "Error during registration: ${e.toString()}");
    }
  }
}
