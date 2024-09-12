import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobi_fix/presentation/authentication/screens/register/screens/additonal_details.dart';
import 'package:mobi_fix/presentation/type_selection/screens/user_type_selection.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import 'navigation/routes/name.dart';
import 'navigation/routes/page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...AppPage.allBlocProviders(context),
      ],
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppPage.generateRouteSettings,
            initialRoute: AppRoutes.initial,
            themeMode: ThemeMode.dark,
            theme: AppTheme(context: context).darkTheme,
            darkTheme: AppTheme(context: context).darkTheme,
          );
        },
      ),
    );
  }
}
