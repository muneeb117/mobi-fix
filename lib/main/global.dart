
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../core/services/storage_services.dart';
import '../utils/api_constants.dart';
import '../config/firebase_options.dart';

class Global {
  static late StorageServices storageServices;

  static Future init() async {

    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    ApiConstants.load();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    storageServices = await StorageServices().init();

  }
}
